class_name VolleyConfig
extends Resource
## Tuning values for the aim-and-fire volley.
## Implements design/game-brief.md MVP feature 1 (Story 001); ball_damage is MVP feature 2
## (Story 002). Instanced as assets/data/volley_config.tres so designers tune without
## touching code.

## Number of balls fired per volley.
@export_range(1, 200) var ball_count: int = 5

## Seconds between consecutive balls of one volley.
@export_range(0.0, 1.0, 0.005) var fire_interval_sec: float = 0.07

## Constant ball speed in pixels per second.
@export_range(100.0, 3000.0, 10.0) var ball_speed: float = 900.0

## Ball radius in pixels (collision shape and drawn circle).
@export_range(2.0, 32.0, 0.5) var ball_radius: float = 8.0

## Damage one ball hit deals to a brick.
@export_range(1, 1000) var ball_damage: int = 1

## Smallest allowed aim angle above horizontal, in degrees, on both the left and right side.
@export_range(0.0, 80.0, 0.5) var min_aim_angle_degrees: float = 12.0

## After a bounce, the vertical part of the ball's speed is raised to at least this
## fraction of ball_speed (0.08 = 8 percent), so balls cannot bounce near-horizontally forever.
@export_range(0.0, 0.5, 0.01) var min_vertical_speed_ratio: float = 0.08

## Aim line length in pixels when nothing is in its way.
@export var aim_line_max_length: float = 1600.0
