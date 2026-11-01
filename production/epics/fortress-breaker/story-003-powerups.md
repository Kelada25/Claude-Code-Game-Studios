# Story 003: Six powerups

> **Epic**: Fortress Breaker
> **Status**: Ready
> **Layer**: Feature
> **Type**: Logic
> **Estimate**: L
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: — (set by /dev-story when implementation begins)

## Context

**GDD**: `design/game-brief.md`
**Requirement**: `Brief MVP feature 4`
*(6 powerups: 3 stat boosts (damage, extra ball, speed) and 3 special balls (fire, split, lightning chain))*

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md` (MVP feature 4). The brief names the special balls; their behaviour below was proposed at story creation on 2026-11-02 and approved by the user:*

- [ ] **Damage boost**: raises every ball's damage per hit by the amount in its data.
- [ ] **Extra ball**: adds one ball to the volley, starting with the next volley.
- [ ] **Speed boost**: raises ball speed by the amount in its data, starting with the next volley.
- [ ] Picking the same stat boost again stacks it (applies its amount again).
- [ ] **Fire ball**: a brick it hits catches fire and loses health after each volley ends (amount in data) until it breaks.
- [ ] **Split ball**: on its first brick hit in a volley it splits into two balls for the rest of that volley.
- [ ] **Lightning ball**: each brick it hits also arcs damage to nearby bricks (range, target count and damage in data).
- [ ] Picking a special ball adds one ball of that type to the volley.
- [ ] Bricks broken by fire, split balls or lightning grant XP exactly as a normal break does (Story 002's rules).
- [ ] Each powerup has a name, short description and its tuning values in a data resource.

---

## Implementation Notes

- Engine risk is HIGH: check `docs/engine-reference/godot/` before using engine APIs.
- Powerups can be applied directly (debug or test call) before Story 004's level-up screen exists; test each effect that way.
- Keep effect rules unit-testable without a running scene where possible.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 004: when and how powerups are offered (level-up screen, every-3rd-level special balls)
- Story 005: armored and explosive bricks

---

## Files

*Planned; `/dev-story` replaces this list with the files it changed.*

- `src/gameplay/powerups/powerup.gd`
- `src/gameplay/powerups/powerup_effects.gd`
- `src/gameplay/volley/special_balls/fire_ball.gd`
- `src/gameplay/volley/special_balls/split_ball.gd`
- `src/gameplay/volley/special_balls/lightning_ball.gd`
- `assets/data/powerups/` (one `.tres` per powerup)
- `tests/unit/powerups/powerups_effects_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level: minimal`: tests are waived (advisory, never "must exist and pass").*

**Story Type**: Logic
**Required evidence**:
- Logic: `tests/unit/powerups/powerups_effects_test.gd` — advisory at `qa.level: minimal`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/fortress-breaker/story-001-aim-and-fire-volley.md`, `production/epics/fortress-breaker/story-002-brick-health-and-xp.md`
- Unlocks: `production/epics/fortress-breaker/story-004-xp-bar-and-level-up.md`
