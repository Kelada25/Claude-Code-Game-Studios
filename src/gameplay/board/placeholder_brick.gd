class_name PlaceholderBrick
extends StaticBody2D
## Indestructible placeholder brick (Story 001). Replaced by real bricks in Story 002.
## Draws itself rather than using a ColorRect: a Control would swallow mouse input
## before the launcher's _unhandled_input could see it.

var _brick_size: Vector2 = Vector2.ZERO
var _brick_color: Color = Color.WHITE

@onready var _collision_shape: CollisionShape2D = $CollisionShape2D


## Sets the brick's size and colour. Call before adding it to the scene tree.
func setup(brick_size: Vector2, brick_color: Color) -> void:
	_brick_size = brick_size
	_brick_color = brick_color


func _ready() -> void:
	var rect := RectangleShape2D.new()
	rect.size = _brick_size
	_collision_shape.shape = rect


func _draw() -> void:
	draw_rect(Rect2(-_brick_size * 0.5, _brick_size), _brick_color)
