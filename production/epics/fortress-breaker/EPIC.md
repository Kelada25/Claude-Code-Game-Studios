# Epic: Fortress Breaker

> **Source**: `design/game-brief.md` (workflow: minimal — the brief is the design record; no GDDs or ADRs)
> **Created**: 2026-11-02 by /create-stories

## Goal

Aim and fire a volley of balls to smash through hand-built brick fortresses where every brick has health and drops XP, and each level-up lets you pick one of three powerups to build an unstoppable run.

## Scope (brief MVP)

1. Aim-and-fire volley with bouncing balls, portrait touch controls
2. Bricks with health that show their HP and drop XP when broken
3. XP bar and level-up screen: pick 1 of 3 powerups, with a rare special ball every 3rd level
4. 6 powerups: 3 stat boosts (damage, extra ball, speed) and 3 special balls (fire, split, lightning chain)
5. 3 hand-built fortress stages with the advancing wall and 2 special brick types (armored, explosive)
6. Run loop: start, stages, win/lose screen, one-tap retry

Out of scope: see the brief's "Out of scope" list.

## Order

The brief's build order is the plan: volley feel first, then brick health / XP / level-up, then the first fortress with the advancing wall, then remaining powerups, brick types and stages, then the run loop, juice and a phone build.

## Stories

| # | Story | Type | Status | ADR |
|---|-------|------|--------|-----|
| 001 | Aim-and-fire volley | Visual/Feel | Ready | N/A (minimal) |
| 002 | Brick health and XP | Logic | Ready | N/A (minimal) |
| 003 | Six powerups | Logic | Ready | N/A (minimal) |
| 004 | XP bar and level-up | Logic | Ready | N/A (minimal) |
| 005 | Fortress stages | Integration | Ready | N/A (minimal) |
| 006 | Run loop | UI | Ready | N/A (minimal) |
