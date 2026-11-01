# Game Brief: Fortress Breaker

**One-sentence pitch:** Aim and fire a volley of balls to smash through hand-built brick fortresses where every brick has health and drops XP, and each level-up lets you pick one of three powerups to build an unstoppable run.

## Core loop
- Drag to aim, release to fire a volley; balls ricochet through the fortress chipping bricks, and each brick has visible health.
- Broken bricks drop XP and fill the bar; a level-up pauses play and offers 3 powerups to choose from.
- Every 3rd level-up offers a rare special ball (fire, split, lightning) instead of a stat boost.
- After each volley the fortress creeps one row closer; clear it before it reaches you, then move to the next, tougher fortress.

## Player goal & fail state — what "working" looks like
- Goal: clear all fortresses in a run (MVP: 3 stages) with a build strong enough to survive the last one.
- Fail: a run ends when any brick crosses the bottom line. A failed run restarts with one tap.

## MVP — what must exist to be the game
1. Aim-and-fire volley with bouncing balls, portrait touch controls
2. Bricks with health that show their HP and drop XP when broken
3. XP bar and level-up screen: pick 1 of 3 powerups, with a rare special ball every 3rd level
4. 6 powerups: 3 stat boosts (damage, extra ball, speed) and 3 special balls (fire, split, lightning chain)
5. 3 hand-built fortress stages with the advancing wall and 2 special brick types (armored, explosive)
6. Run loop: start, stages, win/lose screen, one-tap retry

## Out of scope — not building this
- Progress between runs: no unlock tree, no save system
- Bosses, shops, multiple characters
- Procedural levels (hand-built only), level editor
- Ads, IAP, leaderboards, multiplayer
- Landscape and tablet layouts

## Build order
1. Volley feel in an empty box with one block of bricks. Touch feel is the riskiest part, so prove it first.
2. Brick health, XP, and the level-up pick-3 with 3 powerups. This proves the hook.
3. First fortress with the advancing wall. This proves the tension.
4. Remaining powerups and brick types, then stages 2 and 3.
5. Run loop, juice (screen shake, damage numbers, particles), and a build on a real phone.

---
**Who it's for / what they feel:** Commuters and couch players who want a one-thumb, 5-minute run with a "just one more run" pull.

**Art & audio direction:** Bold neon bricks on a dark board with big damage numbers and screen shake; punchy hit sounds that rise in pitch on combos.

**Reference game:** Ball x Pit is the closest shipped game; the MVP keeps only its bouncing-ball XP and pick-3 level-up loop, and drops its base building and ball fusion. Our difference is intricate hand-built fortresses and one-thumb mobile play.
