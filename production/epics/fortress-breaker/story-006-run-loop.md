# Story 006: Run loop

> **Epic**: Fortress Breaker
> **Status**: Ready
> **Layer**: Presentation
> **Type**: UI
> **Estimate**: L
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: — (set by /dev-story when implementation begins)

## Context

**GDD**: `design/game-brief.md`
**Requirement**: `Brief MVP feature 6`
*(Run loop: start, stages, win/lose screen, one-tap retry)*

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md` (Player goal & fail state, MVP feature 6, Build order step 5), scoped to this story:*

- [ ] A start screen with one tap-to-play control starts a new run at stage 1, level 1, with no powerups.
- [ ] Clearing the 3rd fortress shows a win screen; a lost run shows a lose screen. Both show the stage and level reached.
- [ ] One tap on the win or lose screen starts a fresh run.
- [ ] A new run resets everything: XP, level, powerups and ball count. Nothing carries between runs (brief: no progress between runs).
- [ ] Juice: screen shake when a brick breaks, damage numbers on hits, and particles on breaks.
- [ ] The game exports to and runs on a real phone in portrait, with touch controls working.
- [ ] Holds 60 fps on that phone during a full volley.

---

## Implementation Notes

- Engine risk is HIGH: check `docs/engine-reference/godot/` before using engine APIs (export, scene changes, particles).
- The phone build needs a mobile export preset; once it exists, set `commands.build` in `project.yaml` via `/settings`.
- Set `run/main_scene` in `project.godot` to the start screen if an earlier story has not set it.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 004: the level-up screen
- Story 005: the stage-cleared and run-lost rules (this story only shows the screens they lead to)

---

## Files

*Planned; `/dev-story` replaces this list with the files it changed.*

- `src/gameplay/run/run_controller.gd`
- `src/ui/screens/start_screen.tscn`
- `src/ui/screens/win_screen.tscn`
- `src/ui/screens/lose_screen.tscn`
- `src/gameplay/juice/screen_shake.gd`
- `src/gameplay/juice/damage_number.tscn`
- `export_presets.cfg`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level: minimal`: tests are waived (advisory), but this UI story's retained screenshots are not.*

**Story Type**: UI
**Required evidence**:
- UI: a retained screenshot of the start, win and lose screens, in `production/qa/evidence/`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/fortress-breaker/story-004-xp-bar-and-level-up.md`, `production/epics/fortress-breaker/story-005-fortress-stages.md`
- Unlocks: None
