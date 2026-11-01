class_name BrickType
extends Resource
## Data for one kind of brick: its starting health and the XP it drops when broken.
## Implements design/game-brief.md MVP feature 2 (Story 002). Instanced under
## assets/data/bricks/ so designers tune without touching code.

## Health a brick of this type starts with. Each ball hit removes the ball's damage from it.
@export_range(1, 9999) var max_health: int = 3

## XP added to the run's total when a brick of this type breaks.
@export_range(0, 9999) var xp_value: int = 10
