extends SceneTree
# Throwaway verification for Story 002 (brick health and XP). Not part of the repo.
# Run: Godot --headless --path <project> -s <this file>

var _failures: int = 0


func _check(ok: bool, what: String) -> void:
	print(("PASS: " if ok else "FAIL: ") + what)
	if not ok:
		_failures += 1


func _initialize() -> void:
	_run.call_deferred()


func _run() -> void:
	var type: BrickType = load("res://assets/data/bricks/basic_brick.tres")
	_check(type.max_health == 3 and type.xp_value == 10, "basic_brick.tres: max_health 3, xp_value 10")

	# Brick rules in isolation.
	var run := RunState.new()
	var totals: Array[int] = []
	run.xp_changed.connect(func(total: int) -> void: totals.append(total))
	var brick_scene: PackedScene = load("res://src/gameplay/bricks/brick.tscn")
	var brick: Brick = brick_scene.instantiate()
	brick.setup(type, Vector2(64, 26), Color.WHITE)
	brick.broken.connect(run.add_xp)
	root.add_child(brick)
	_check(brick.health == 3, "brick starts at its type's health (3)")
	brick.take_hit(1)
	_check(brick.health == 2 and run.xp == 0, "hit without a break: health 3 -> 2, no XP")
	brick.take_hit(1)
	brick.take_hit(1)
	_check(run.xp == 10, "break grants the type's XP (10)")
	_check(brick.collision_layer == 0, "broken brick stops colliding (layer 0)")
	_check(brick.is_queued_for_deletion(), "broken brick is queued for removal")
	brick.take_hit(1)
	brick.take_hit(5)
	_check(run.xp == 10 and totals == [10], "more hits in the same frame after the break: one XP grant, one signal")

	var overkill: Brick = brick_scene.instantiate()
	overkill.setup(type, Vector2(64, 26), Color.WHITE)
	overkill.broken.connect(run.add_xp)
	root.add_child(overkill)
	overkill.take_hit(7)
	_check(run.xp == 20 and totals == [10, 20], "overkill hit breaks once; xp_changed carries the new total (20)")

	# Board integration: one real volley at 70 degrees.
	var board: Node2D = load("res://src/gameplay/board/board.tscn").instantiate()
	root.add_child(board)
	await process_frame
	var board_bricks_before: int = _live_bricks(board).size()
	_check(board_bricks_before == 35, "board builds 35 real bricks (got %d)" % board_bricks_before)
	var board_totals: Array[int] = []
	board.run_state.xp_changed.connect(func(total: int) -> void: board_totals.append(total))
	board.get_node("Launcher").fire_at_angle(70.0)
	await create_timer(4.0).timeout
	var live: Array[Brick] = _live_bricks(board)
	var broken_count: int = 35 - live.size()
	var damaged: PackedStringArray = []
	for b: Brick in live:
		if b.health < 3:
			damaged.append("%d@(%d,%d)" % [b.health, int(b.position.x), int(b.position.y)])
	print("INFO: volley broke %d brick(s); damaged survivors: %s; run XP %d; xp_changed totals %s"
		% [broken_count, ", ".join(damaged), board.run_state.xp, str(board_totals)])
	_check(broken_count >= 1, "a 5-ball volley breaks at least one brick")
	_check(board.run_state.xp == broken_count * 10, "board XP equals 10 per broken brick")
	_check(board_totals.size() == broken_count, "one xp_changed per broken brick")

	print("RESULT: %d failure(s)" % _failures)
	quit(1 if _failures > 0 else 0)


func _live_bricks(board: Node) -> Array[Brick]:
	var out: Array[Brick] = []
	for child: Node in board.get_children():
		var b := child as Brick
		if b != null and not b.is_queued_for_deletion():
			out.append(b)
	return out
