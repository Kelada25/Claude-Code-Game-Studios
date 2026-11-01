# Test Evidence: Aim-and-fire volley

> **Story**: `production/epics/fortress-breaker/story-001-aim-and-fire-volley.md`
> **Story Type**: Visual/Feel
> **Date**: 2026-11-02
> **Tester**: Alex Kelada (hands-on); automated capture by /dev-story
> **Build / Commit**: uncommitted working tree on `main` (base `05ad7c8`); Godot 4.7.2.stable.official.ed1daf0bf

---

## What Was Tested

The aim-and-fire volley in the Story 001 test board: drag to aim, release to fire 5 balls in sequence, constant-speed bounces off walls and placeholder bricks, and balls leaving play at the bottom line. Evidence is three retained frames from Movie Maker runs (`--autofire=70`, which fires without input) plus a hands-on play session on desktop with the mouse standing in for touch. The table below says which of the two backs each criterion.

**Acceptance criteria covered**: AC-1 to AC-9.

---

## Acceptance Criteria Results

| # | Criterion (from story) | Result | How verified |
|---|----------------------|--------|--------------|
| AC-1 | Touching and dragging shows an aim line from the launch point; releasing fires the volley in that direction. | PASS | Hands-on (Alex Kelada). No retained image of the aim line: the automated capture fires without input |
| AC-2 | A volley fires all of the player's balls one after another along the aim line. | PASS | Screenshot 1: 5 balls evenly spaced along the 70° aim line |
| AC-3 | Balls bounce off the side walls, the top wall and bricks at a constant speed. | PASS | Bricks: screenshot 2 (3 of 5 balls already rebounded off the bottom brick row, 2 still approaching). Side walls, top wall and constant speed: hands-on only, no retained image |
| AC-4 | A ball that reaches the bottom line leaves play; aiming is disabled while any ball is in flight and re-enabled once every ball has returned. | PASS | Leaving play: screenshot 3 (board empty). Aim lock and unlock: hands-on only |
| AC-5 | The aim cannot point downward or flat sideways; a release outside the allowed range does not fire. | PASS | Hands-on only (faint red line, nothing fires). No retained image |
| AC-6 | The test scene is a walled portrait box with one block of placeholder bricks the balls bounce off. | PASS | Screenshots 1 to 3 |
| AC-7 | On a desktop run the mouse stands in for touch (press, drag, release). | PASS | Hands-on |
| AC-8 | Ball speed, ball count and the delay between balls are tuning values in a data resource, not hardcoded. | PASS | `assets/data/volley_config.tres`; code read, no hardcoded balance values in `ball.gd` or `launcher.gd` |
| AC-9 | Holds 60 fps with a full volley in flight on the desktop run. | PASS | Hands-on judgement only: smooth, no stutter. Not a measured frame rate. The recorder reported 0.11 ms average CPU render per frame, which shows rendering is cheap |

---

## Screenshots / Video

| # | Filename | What It Shows | Acceptance Criterion |
|---|----------|--------------|----------------------|
| 1 | `story-001-aim-and-fire-volley/01-volley-fired-in-sequence.png` | 5 balls leaving the launcher one after another along a 70° aim | AC-2, AC-6 |
| 2 | `story-001-aim-and-fire-volley/02-volley-bouncing-off-bricks.png` | Balls rebounding off the bottom brick row: 3 already heading back down, 2 still approaching | AC-3 (bricks), AC-6 |
| 3 | `story-001-aim-and-fire-volley/03-all-balls-left-play.png` | Board empty ~1.8 s after firing: every ball has left play | AC-4 (leaving play), AC-6 |

Stamp: `story-001-aim-and-fire-volley/stamp.txt` (all 10 code files unchanged at close).

---

## Test Conditions

- **Game state at start**: Story 001 test board (`res://src/gameplay/board/board.tscn`), 5 balls, indestructible placeholder bricks
- **Platform / hardware**: macOS, Apple M2, Metal 4.0, Mobile renderer, 540x960 window
- **Framerate during test**: not measured directly; smooth by hands-on judgement; recorder average 0.11 ms CPU render per frame
- **Any special setup required**: screenshots used the `-- --autofire=70` debug argument; the hands-on session used normal mouse input

---

## Observations

- Hands-on verdict from Alex Kelada: "Feels good".
- No retained image shows the aim line, the red blocked-aim line, or a wall or top-wall bounce. A screenshot or short capture of each would make AC-1, AC-3 and AC-5 image-backed.
- Not yet run on a phone with real touch. That is Story 006's job.

---

## Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Lead (designer) | Alex Kelada | 2026-11-02 | [x] Approved |

---

*Template: `.claude/docs/templates/test-evidence.md`*
