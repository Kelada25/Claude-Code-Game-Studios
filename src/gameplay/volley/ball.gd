class_name Ball
extends CharacterBody2D
## One volley ball: constant-speed bouncing via move_and_collide.
## Implements design/game-brief.md MVP features 1 and 2 (Stories 001, 002): a bounce off a
## brick also hits it for the configured ball damage.
## Balls sit on collision layer 2 and mask layer 1 (walls, bricks) only, so balls
## never collide with each other (set in ball.tscn).

## Emitted once when the ball crosses the bottom line moving downward, just before it frees itself.
signal left_play

## Bounces resolved in one physics step; any motion left after that is dropped.
const MAX_BOUNCES_PER_STEP: int = 4

var _config: VolleyConfig
var _bottom_line_y: float = 0.0

@onready var _collision_shape: CollisionShape2D = $CollisionShape2D


## Configures the ball. Call before adding it to the scene tree.
## [param direction] must be non-zero; it is normalised here.
func setup(config: VolleyConfig, direction: Vector2, bottom_line_y: float) -> void:
	_config = config
	_bottom_line_y = bottom_line_y
	velocity = direction.normalized() * config.ball_speed


func _ready() -> void:
	var circle := CircleShape2D.new()
	circle.radius = _config.ball_radius
	_collision_shape.shape = circle


func _physics_process(delta: float) -> void:
	var remaining: Vector2 = velocity * delta
	for _step: int in MAX_BOUNCES_PER_STEP:
		var collision: KinematicCollision2D = move_and_collide(remaining)
		if collision == null:
			break
		var normal: Vector2 = collision.get_normal()
		# Only reflect when moving into the surface; a ball already leaving it keeps its heading.
		if velocity.dot(normal) < 0.0:
			velocity = _bounced_velocity(velocity, normal)
			# One bounce off a brick is one hit on it. A ball in resting contact never
			# reflects, so it does not hit again every physics step.
			var brick := collision.get_collider() as Brick
			if brick != null:
				brick.take_hit(_config.ball_damage)
		# Continue the leftover distance along the new heading so no motion is lost.
		remaining = velocity.normalized() * collision.get_remainder().length()
		if remaining.is_zero_approx():
			break
	if velocity.y > 0.0 and global_position.y >= _bottom_line_y:
		left_play.emit()
		queue_free()


## Reflects [param incoming] off [param normal] at exactly ball_speed, then raises the
## vertical part to the configured minimum if the result is near-horizontal.
func _bounced_velocity(incoming: Vector2, normal: Vector2) -> Vector2:
	var speed: float = _config.ball_speed
	var bounced: Vector2 = incoming.bounce(normal).normalized() * speed
	var min_vertical: float = speed * _config.min_vertical_speed_ratio
	if absf(bounced.y) < min_vertical:
		var sign_y: float = 1.0 if bounced.y > 0.0 else -1.0
		var sign_x: float = 1.0 if bounced.x >= 0.0 else -1.0
		bounced = Vector2(
			sign_x * sqrt(speed * speed - min_vertical * min_vertical),
			sign_y * min_vertical)
	return bounced


func _draw() -> void:
	draw_circle(Vector2.ZERO, _config.ball_radius, Color.WHITE)
