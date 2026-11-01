class_name Launcher
extends Node2D
## Aims and fires the volley. Child of the board, positioned at the launch point.
## Implements design/game-brief.md MVP feature 1 (Story 001).
## States: AIMING -> FIRING -> IN_FLIGHT -> AIMING (see TRANSITIONS).

## Emitted when every ball of a volley has left play and aiming is available again.
signal volley_finished

enum State { AIMING, FIRING, IN_FLIGHT }

## Explicit transition table: current state -> states it may move to.
const TRANSITIONS: Dictionary = {
	State.AIMING: [State.FIRING],
	State.FIRING: [State.IN_FLIGHT],
	State.IN_FLIGHT: [State.AIMING],
}

const BALL_SCENE: PackedScene = preload("res://src/gameplay/volley/ball.tscn")

## Physics layer mask of walls and bricks (layer 1); the aim ray tests against it.
const WORLD_LAYER_MASK: int = 1

## Volley tuning data (speed, count, spacing, aim limits).
@export var config: VolleyConfig

## Aim line colour when the current angle is allowed.
@export var aim_line_color: Color = Color(0.3, 0.9, 1.0, 0.9)

## Aim line colour when the current angle is not allowed (releasing will not fire).
@export var blocked_aim_line_color: Color = Color(1.0, 0.2, 0.25, 0.45)

## Aim line width in pixels.
@export var aim_line_width: float = 4.0

## Y of the bottom line, in global coordinates. Set by the board; passed on to every ball.
var bottom_line_y: float = 0.0

var _state: State = State.AIMING
var _dragging: bool = false
var _aim_direction: Vector2 = Vector2.ZERO
var _aim_allowed: bool = false
var _aim_end: Vector2 = Vector2.ZERO  # aim line end, local to the launcher
var _fire_direction: Vector2 = Vector2.ZERO
var _balls_to_fire: int = 0
var _fire_timer: float = 0.0
var _balls_in_flight: int = 0


## Fires a volley at [param angle_degrees] above horizontal (0 = right, 90 = straight up,
## 180 = left), exactly as a release would. Does nothing unless aiming is available and
## the angle is inside the allowed range.
func fire_at_angle(angle_degrees: float) -> void:
	if _state == State.AIMING and _is_angle_allowed(angle_degrees):
		_start_volley(Vector2.from_angle(deg_to_rad(-angle_degrees)))


# Touch is emulated as mouse input by default (input_devices/pointing/emulate_mouse_from_touch),
# so handling mouse events here IS the touch path on a phone. Events are identified by type,
# never by device id (4.7 changed the mouse device id).
func _unhandled_input(event: InputEvent) -> void:
	if _state != State.AIMING:
		return
	var button := event as InputEventMouseButton
	if button != null:
		if button.button_index != MOUSE_BUTTON_LEFT:
			return
		if button.pressed:
			_dragging = true
			_update_aim(_local_pointer(button))
		elif _dragging:
			_dragging = false
			_update_aim(_local_pointer(button))
			if _aim_allowed:
				_start_volley(_aim_direction)
			else:
				queue_redraw()
		return
	var motion := event as InputEventMouseMotion
	if motion != null and _dragging:
		_update_aim(_local_pointer(motion))


func _physics_process(delta: float) -> void:
	if _state != State.FIRING:
		return
	_fire_timer -= delta
	while _balls_to_fire > 0 and _fire_timer <= 0.0:
		_spawn_ball(-_fire_timer)
		_balls_to_fire -= 1
		_fire_timer += config.fire_interval_sec
	if _balls_to_fire == 0:
		_change_state(State.IN_FLIGHT)


func _draw() -> void:
	if _dragging:
		var color: Color = aim_line_color if _aim_allowed else blocked_aim_line_color
		draw_line(Vector2.ZERO, _aim_end, color, aim_line_width)


func _change_state(new_state: State) -> void:
	assert(new_state in TRANSITIONS[_state], "Invalid launcher state transition")
	_state = new_state


func _start_volley(direction: Vector2) -> void:
	_dragging = false
	_fire_direction = direction
	_balls_to_fire = config.ball_count
	_fire_timer = 0.0
	_change_state(State.FIRING)
	queue_redraw()


## Spawns one ball. [param overshoot_sec] is how long ago, within this physics step, the
## ball was due; the ball is placed that far along its path so spacing stays even.
func _spawn_ball(overshoot_sec: float) -> void:
	var ball: Ball = BALL_SCENE.instantiate()
	ball.setup(config, _fire_direction, bottom_line_y)
	ball.position = _fire_direction * config.ball_speed * overshoot_sec
	ball.left_play.connect(_on_ball_left_play)
	add_child(ball)
	_balls_in_flight += 1


func _on_ball_left_play() -> void:
	_balls_in_flight -= 1
	if _state == State.IN_FLIGHT and _balls_in_flight == 0:
		_change_state(State.AIMING)
		volley_finished.emit()


## Pointer position as an offset from the launch point (the launcher's local space).
func _local_pointer(event: InputEvent) -> Vector2:
	return (make_input_local(event) as InputEventMouse).position


## Updates aim direction, validity and the aim line end from a pointer offset.
func _update_aim(offset: Vector2) -> void:
	if offset.is_zero_approx():
		_aim_allowed = false
		_aim_end = Vector2.ZERO
	else:
		_aim_direction = offset.normalized()
		_aim_allowed = _is_angle_allowed(rad_to_deg(atan2(-offset.y, offset.x)))
		_aim_end = _first_hit_offset(_aim_direction)
	queue_redraw()


## Allowed when at least min_aim_angle_degrees above horizontal on either side.
func _is_angle_allowed(angle_degrees: float) -> bool:
	var min_angle: float = config.min_aim_angle_degrees
	return angle_degrees >= min_angle and angle_degrees <= 180.0 - min_angle


## Offset from the launch point to the first wall or brick along [param direction],
## or aim_line_max_length along it when nothing is hit.
func _first_hit_offset(direction: Vector2) -> Vector2:
	var from: Vector2 = global_position
	var to: Vector2 = from + direction * config.aim_line_max_length
	var query := PhysicsRayQueryParameters2D.create(from, to, WORLD_LAYER_MASK)
	var hit: Dictionary = get_world_2d().direct_space_state.intersect_ray(query)
	if hit.is_empty():
		return to - from
	return (hit["position"] as Vector2) - from
