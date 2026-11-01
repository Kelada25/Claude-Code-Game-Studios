extends Node2D
## Story 001 test board: a walled portrait box with the bottom open, one block of
## indestructible placeholder bricks, and the launcher.
## Implements design/game-brief.md MVP feature 1 (build order step 1).
## Walls and bricks are on collision layer 1; balls (layer 2) mask layer 1.

const BRICK_SCENE: PackedScene = preload("res://src/gameplay/board/placeholder_brick.tscn")

## Playfield size in pixels (matches the 540x960 portrait viewport).
@export var board_size: Vector2 = Vector2(540.0, 960.0)
## Y of the top wall's inner face; the strip above it is reserved for a future HUD.
@export var top_wall_y: float = 60.0
## Wall thickness in pixels (thick so balls cannot tunnel through).
@export var wall_thickness: float = 64.0
## A ball at or below this Y that is moving downward has left play.
@export var bottom_line_y: float = 870.0
## Where balls are launched from (fixed).
@export var launch_point: Vector2 = Vector2(270.0, 860.0)
## Brick block columns.
@export var brick_columns: int = 7
## Brick block rows.
@export var brick_rows: int = 5
## Size of one brick in pixels.
@export var brick_size: Vector2 = Vector2(64.0, 26.0)
## Gap between neighbouring bricks in pixels.
@export var brick_gap: float = 8.0
## Y of the top edge of the first brick row.
@export var brick_grid_top: float = 140.0
## One neon colour per brick row (cycled if there are more rows than colours).
@export var row_colors: Array[Color] = [
	Color("#ff2e88"), Color("#ff8a1f"), Color("#ffe81f"), Color("#2eff8a"), Color("#1fd2ff"),
]
## Board background colour.
@export var background_color: Color = Color("#0d0f1a")
## Colour of the wall outline.
@export var wall_color: Color = Color("#3b4270")
## Colour of the bottom line.
@export var bottom_line_color: Color = Color(1.0, 0.2, 0.25, 0.5)

@onready var _launcher: Launcher = $Launcher


func _ready() -> void:
	var wall_top: float = top_wall_y - wall_thickness
	var side_height: float = board_size.y - wall_top
	_add_wall(Rect2(-wall_thickness, wall_top, board_size.x + wall_thickness * 2.0, wall_thickness))
	_add_wall(Rect2(-wall_thickness, wall_top, wall_thickness, side_height))
	_add_wall(Rect2(board_size.x, wall_top, wall_thickness, side_height))
	_build_bricks()
	_launcher.position = launch_point
	_launcher.bottom_line_y = bottom_line_y
	_debug_autofire()


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, board_size), background_color)
	draw_polyline(PackedVector2Array([
		Vector2(0.0, bottom_line_y), Vector2(0.0, top_wall_y),
		Vector2(board_size.x, top_wall_y), Vector2(board_size.x, bottom_line_y),
	]), wall_color, 6.0)
	draw_line(Vector2(0.0, bottom_line_y), Vector2(board_size.x, bottom_line_y), bottom_line_color, 2.0)
	draw_circle(launch_point, 12.0, wall_color)


func _add_wall(rect: Rect2) -> void:
	var body := StaticBody2D.new()  # default collision layer 1
	body.position = rect.get_center()
	var shape := RectangleShape2D.new()
	shape.size = rect.size
	var collider := CollisionShape2D.new()
	collider.shape = shape
	body.add_child(collider)
	add_child(body)


func _build_bricks() -> void:
	var grid_width: float = brick_columns * brick_size.x + (brick_columns - 1) * brick_gap
	var left: float = (board_size.x - grid_width) * 0.5
	for row: int in brick_rows:
		for column: int in brick_columns:
			var brick: PlaceholderBrick = BRICK_SCENE.instantiate()
			brick.setup(brick_size, row_colors[row % row_colors.size()])
			brick.position = Vector2(
				left + brick_size.x * 0.5 + column * (brick_size.x + brick_gap),
				brick_grid_top + brick_size.y * 0.5 + row * (brick_size.y + brick_gap))
			add_child(brick)


## DEBUG HOOK (screenshot automation, not gameplay): run with `-- --autofire=<degrees>`
## to fire one volley about 0.5 s after the scene is ready, without any input.
func _debug_autofire() -> void:
	for arg: String in OS.get_cmdline_user_args():
		if arg.begins_with("--autofire="):
			await get_tree().create_timer(0.5).timeout
			_launcher.fire_at_angle(arg.get_slice("=", 1).to_float())
