# Story 002: Brick health and XP

> **Epic**: Fortress Breaker
> **Status**: Ready
> **Layer**: Core
> **Type**: Logic
> **Estimate**: S
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: — (set by /dev-story when implementation begins)

## Context

**GDD**: `design/game-brief.md`
**Requirement**: `Brief MVP feature 2`
*(Bricks with health that show their HP and drop XP when broken)*

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md` (Core loop, MVP feature 2), scoped to this story:*

- [ ] Each brick's starting health comes from its brick type, defined in a data resource, and is shown as a number on the brick.
- [ ] Each ball hit reduces the brick's health by the ball's damage, and the number on the brick updates immediately.
- [ ] A brick whose health reaches 0 or below breaks and is removed; balls no longer collide with it.
- [ ] A broken brick adds its brick type's XP value to the run's XP total; a brick that is hit but not broken adds none.
- [ ] Several balls hitting the same brick in the same frame break it once and grant its XP once.
- [ ] The run's XP total is exposed through a signal so the XP bar (Story 004) can listen to it.
- [ ] The placeholder bricks from Story 001 become real bricks with health.

---

## Implementation Notes

- Engine risk is HIGH: check `docs/engine-reference/godot/` before using engine APIs.
- Keep the damage and XP rules in a plain class or function that can be unit-tested without a scene (coding standards: dependency injection over singletons).
- Health and XP per brick type are data, not code.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 003: damage boosts and special-ball damage
- Story 004: the XP bar, levels and level-ups
- Story 005: armored and explosive bricks

---

## Files

*Planned; `/dev-story` replaces this list with the files it changed.*

- `src/gameplay/bricks/brick.gd`
- `src/gameplay/bricks/brick.tscn`
- `src/gameplay/bricks/brick_type.gd`
- `assets/data/bricks/basic_brick.tres`
- `src/gameplay/run/run_state.gd`
- `tests/unit/bricks/bricks_health_xp_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level: minimal`: tests are waived (advisory, never "must exist and pass").*

**Story Type**: Logic
**Required evidence**:
- Logic: `tests/unit/bricks/bricks_health_xp_test.gd` — advisory at `qa.level: minimal`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/fortress-breaker/story-001-aim-and-fire-volley.md`
- Unlocks: `production/epics/fortress-breaker/story-003-powerups.md`, `production/epics/fortress-breaker/story-004-xp-bar-and-level-up.md`, `production/epics/fortress-breaker/story-005-fortress-stages.md`
