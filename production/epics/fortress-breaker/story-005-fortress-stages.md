# Story 005: Fortress stages

> **Epic**: Fortress Breaker
> **Status**: Ready
> **Layer**: Feature
> **Type**: Integration
> **Estimate**: L
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: — (set by /dev-story when implementation begins)

## Context

**GDD**: `design/game-brief.md`
**Requirement**: `Brief MVP feature 5`
*(3 hand-built fortress stages with the advancing wall and 2 special brick types (armored, explosive))*

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md` (Core loop, Player goal & fail state, MVP feature 5). The brief names the special bricks; their behaviour below was proposed at story creation on 2026-11-02 and approved by the user:*

- [ ] 3 fortress layouts are hand-built (one editable file per stage, no procedural generation) and load onto the board.
- [ ] Each stage is tougher than the last: later stages use bricks with more health.
- [ ] After every volley ends, the whole fortress moves down one row.
- [ ] The run is lost when any brick crosses the bottom line after the fortress moves.
- [ ] Breaking every brick clears the stage, and the next fortress loads with the player's level, XP and powerups kept.
- [ ] **Armored brick**: takes reduced damage from every hit (reduction in data, never below 1 damage).
- [ ] **Explosive brick**: when it breaks it damages the bricks around it (radius and damage in data); an explosion that breaks another explosive brick sets that one off too.
- [ ] Bricks broken by an explosion grant their XP as usual (Story 002's rules).

---

## Implementation Notes

- Engine risk is HIGH: check `docs/engine-reference/godot/` before using engine APIs.
- Brief, Build order: build the first fortress with the advancing wall before adding the remaining brick types and stages 2 and 3.
- Layouts must stay hand-editable; the brief's out-of-scope list rules out procedural levels and a level editor.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 006: the win and lose screens and retry (this story only signals stage cleared / run lost)

---

## Files

*Planned; `/dev-story` replaces this list with the files it changed.*

- `src/gameplay/fortress/fortress.gd`
- `src/gameplay/fortress/stages/stage_01.tscn`
- `src/gameplay/fortress/stages/stage_02.tscn`
- `src/gameplay/fortress/stages/stage_03.tscn`
- `assets/data/bricks/armored_brick.tres`
- `assets/data/bricks/explosive_brick.tres`
- `tests/integration/fortress/fortress_stage_flow_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level: minimal`: tests are waived (advisory, never "must exist and pass").*

**Story Type**: Integration
**Required evidence**:
- Integration: `tests/integration/fortress/fortress_stage_flow_test.gd` OR a playtest doc — advisory at `qa.level: minimal`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/fortress-breaker/story-002-brick-health-and-xp.md`
- Unlocks: `production/epics/fortress-breaker/story-006-run-loop.md`
