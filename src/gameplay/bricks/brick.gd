class_name Brick
extends StaticBody2D
## A destructible brick. It starts with its brick type's health, loses health on each ball
## hit, and breaks exactly once when health reaches 0 or below, reporting its type's XP.
## Implements design/game-brief.md MVP feature 2 (Story 002). Replaces the Story 001
## placeholder brick.
## Draws itself (rect plus health number) rather than using a ColorRect or Label: a
## Control would swallow mouse input before the launcher's _unhandled_input could see it.
## Sits on collision layer 1 and masks nothing (set in brick.tscn).

## Emitted exactly once, when health reaches 0 or below, just before the brick frees itself.
## [param xp_value] is the XP value of the brick's type.
signal broken(xp_value: int)

## Colour of the health number (dark, so it stays readable on every neon row colour).
@export var label_color: Color = Color("#0d0f1a")
## Font size of the health number in pixels.
@export_range(6, 64) var label_font_size: int = 16

## Current health. Starts at the brick type's max_health; the brick breaks at 0 or below.
var health: int = 0

var _type: BrickType
var _brick_size: Vector2 = Vector2.ZERO
var _brick_color: Color = Color.WHITE
var _is_broken: bool = false

@onready var _collision_shape: CollisionShape2D = $CollisionShape2D


## Sets the brick's type, size and colour, and gives it full health.
## Call before adding it to the scene tree.
func setup(type: BrickType, brick_size: Vector2, brick_color: Color) -> void:
	_type = type
	_brick_size = brick_size
	_brick_color = brick_color
	health = type.max_health


func _ready() -> void:
	var rect := RectangleShape2D.new()
	rect.size = _brick_size
	_collision_shape.shape = rect


func _draw() -> void:
	draw_rect(Rect2(-_brick_size * 0.5, _brick_size), _brick_color)
	# draw_string positions text by its baseline, so offset it to centre the line vertically.
	var font: Font = ThemeDB.fallback_font
	var baseline_y: float = font.get_ascent(label_font_size) - font.get_height(label_font_size) * 0.5
	draw_string(font, Vector2(-_brick_size.x * 0.5, baseline_y), str(health),
		HORIZONTAL_ALIGNMENT_CENTER, _brick_size.x, label_font_size, label_color)


## Applies [param damage] to the brick. Does nothing if the brick is already broken, so
## several balls hitting it in the same frame break it, and grant its XP, only once.
func take_hit(damage: int) -> void:
	if _is_broken:
		return
	health -= damage
	if health > 0:
		queue_redraw()
		return
	_is_broken = true
	# Balls call this from _physics_process, not from a physics callback, so changing the
	# layer directly is safe. It must happen now: queue_free() only removes the brick at the
	# end of the frame, and a ball's next bounce in this step must not hit it again.
	collision_layer = 0
	broken.emit(_type.xp_value)
	queue_free()
