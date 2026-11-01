# Story 002: Brick health and XP

> **Epic**: Fortress Breaker
> **Status**: Complete
> **Layer**: Core
> **Type**: Logic
> **Estimate**: S
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-02

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

- `src/gameplay/bricks/brick_type.gd` (+ `.uid`) — created (BrickType data class)
- `src/gameplay/bricks/brick.gd` (+ `.uid`), `src/gameplay/bricks/brick.tscn` — created (destructible brick, draws its health)
- `src/gameplay/run/run_state.gd` (+ `.uid`) — created (run XP total, `xp_changed`)
- `assets/data/bricks/basic_brick.tres` — created (health 3, XP 10)
- `src/gameplay/board/board.gd`, `src/gameplay/board/board.tscn` — modified (real bricks, XP into `run_state`)
- `src/gameplay/volley/ball.gd` — modified (a bounce off a brick hits it)
- `src/gameplay/volley/volley_config.gd`, `assets/data/volley_config.tres` — modified (`ball_damage = 1`)
- `src/gameplay/board/placeholder_brick.gd` (+ `.uid`), `placeholder_brick.tscn` — deleted (replaced by the real brick)
- `production/qa/evidence/story-002-brick-health-and-xp/` — 3 screenshots + `stamp.txt`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level: minimal`: tests are waived (advisory, never "must exist and pass").*

**Story Type**: Logic
**Required evidence**:
- Logic: `tests/unit/bricks/bricks_health_xp_test.gd` — advisory at `qa.level: minimal`

**Status**: [x] Unit test waived at qa.level minimal. Evidence instead: 3 retained frames and a re-runnable headless check (`verify_story002.gd`, with its saved output) in `production/qa/evidence/story-002-brick-health-and-xp/`

---

## Dependencies

- Depends on: `production/epics/fortress-breaker/story-001-aim-and-fire-volley.md`
- Unlocks: `production/epics/fortress-breaker/story-003-powerups.md`, `production/epics/fortress-breaker/story-004-xp-bar-and-level-up.md`, `production/epics/fortress-breaker/story-005-fortress-stages.md`

---

## Completion Notes
**Completed**: 2026-11-02
**Criteria**: 7/7 passing. AC-1 to AC-3 and AC-7 are backed by retained frames; AC-4 to AC-6 by the headless check, which Alex Kelada accepted as the evidence.
**Deviations**: Advisory only. AC-5 was checked by repeated direct hits on one brick, not by real balls colliding in the same frame. `ball.gd`, `volley_config` (new `ball_damage`) and `board.gd` changed although they weren't in the original file plan; the criteria need them and they are now listed under Files.
**Test Evidence**: waived at qa.level minimal; 3 frames plus `verify_story002.gd` and `verify_story002-output.txt` (12 of 12 PASS) under `production/qa/evidence/story-002-brick-health-and-xp/`
**Reviewed by**: self, no independent review (Solo mode). Godot specialist engine-API check ran in /dev-story: no blocking findings; 3 minor, unfixed (a board with no `brick_type` assigned would crash, `collision_layer` is set directly and may need `set_deferred` if Story 005's explosions call `take_hit` from a physics callback, and 4.7's thinner line drawing).
