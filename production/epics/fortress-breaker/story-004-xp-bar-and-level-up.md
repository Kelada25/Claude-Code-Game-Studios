# Story 004: XP bar and level-up

> **Epic**: Fortress Breaker
> **Status**: Ready
> **Layer**: Feature
> **Type**: Logic
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: — (set by /dev-story when implementation begins)

## Context

**GDD**: `design/game-brief.md`
**Requirement**: `Brief MVP feature 3`
*(XP bar and level-up screen: pick 1 of 3 powerups, with a rare special ball every 3rd level)*

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md` (Core loop, MVP feature 3), scoped to this story:*

- [ ] An on-screen XP bar fills as XP is gained and shows the player's current level.
- [ ] The XP needed for each level comes from a data curve; reaching it triggers a level-up, and leftover XP carries into the next level.
- [ ] A single XP gain large enough for two levels triggers two level-ups, one after the other.
- [ ] A level-up pauses play (balls freeze in place) and shows 3 different powerups; tapping one applies it (Story 003) and resumes play.
- [ ] Level-ups that are not a multiple of 3 offer stat boosts; every 3rd level-up (3, 6, 9…) offers the special balls instead.
- [ ] Which levels offer special balls (every Nth) is a tuning value in data.
- [ ] The level-up screen is readable and tappable in portrait on a phone-sized window.

---

## Implementation Notes

- Engine risk is HIGH: check `docs/engine-reference/godot/` before using engine APIs (pausing, UI input).
- Keep the XP curve, carry-over and offer rules in a class that can be unit-tested without the UI.
- With only the 6 MVP powerups, each offer is a fixed set (all 3 stat boosts, or all 3 special balls); random offers arrive once there are more powerups than slots.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 003: what each powerup does
- Story 006: start, win and lose screens

---

## Files

*Planned; `/dev-story` replaces this list with the files it changed.*

- `src/gameplay/progression/level_progression.gd`
- `assets/data/xp_curve.tres`
- `src/ui/hud/xp_bar.gd`
- `src/ui/hud/xp_bar.tscn`
- `src/ui/level_up/level_up_screen.gd`
- `src/ui/level_up/level_up_screen.tscn`
- `tests/unit/progression/progression_level_up_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level: minimal`: tests are waived (advisory, never "must exist and pass").*

**Story Type**: Logic
**Required evidence**:
- Logic: `tests/unit/progression/progression_level_up_test.gd` — advisory at `qa.level: minimal`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/fortress-breaker/story-002-brick-health-and-xp.md`, `production/epics/fortress-breaker/story-003-powerups.md`
- Unlocks: `production/epics/fortress-breaker/story-006-run-loop.md`
