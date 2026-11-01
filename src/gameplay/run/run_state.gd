class_name RunState
extends RefCounted
## The run's progress state. For now just the XP total; the XP bar and levels (Story 004)
## listen to xp_changed. A plain object with no node or scene dependency, so it can be
## unit-tested without a scene.
## Implements design/game-brief.md MVP feature 2 (Story 002).

## Emitted after XP is added. [param total] is the run's new XP total.
signal xp_changed(total: int)

## The run's XP total.
var xp: int = 0


## Adds [param amount] XP to the run's total and emits xp_changed.
func add_xp(amount: int) -> void:
	xp += amount
	xp_changed.emit(xp)
