---
name: suggest-assets
description: Look at one of Kaian's games (or all of them) and suggest Kenney art, sounds and music that would fit. Use when he asks "what could my game use", "suggest stuff for my game", "make my game look better", "what art should I add", "check all my games for assets", opens a game that still has placeholder shapes, or finishes a piece and it's time to make it look or sound nicer.
---

# Suggest Kenney assets

Kaian's games live in `~/Games/<Game Name>/`. The Kenney library (about
90,000 files) is searched with `kenney-find`. This skill works out what a game
*needs* and brings him a short list of real options. **He picks. You never
grab anything he hasn't picked.**

## 1. Work out which game

- He named one: find it in `~/Games/` even if the spelling is off
  ("sipder" is Sipder Smash, "nana" is Nana's Dreamland).
- He said "all my games": go through every folder in `~/Games/`, but tell
  him **one or two ideas per game**, not a pile. Start with the ones he
  worked on most recently (`ls -t ~/Games`).
- He's already in a game folder: use that one.

## 2. Find out what the game is about

Read whichever of these exist, in this order:

1. `GAME_PLAN.md` or `GAME_DESIGN.md`: who you are, enemies, how you win
2. `README.md` and `CLAUDE.md`
3. `CREDITS.md`: what's **already** been grabbed from Kenney. Don't
   suggest it again.
4. `assets/` and `shots/`: look at a screenshot with the Read tool, so you
   can see what's still a plain box or circle.

Also check: is it **2D or 3D**? It's Godot if there's a `project.godot`
(look for `3D` nodes in `.tscn` files). Loose `index.html` games are 2D web
games. 3D games get `--kind model` (take the `.glb`). 2D games get
pictures.

## 3. Make a short "needs" list

Pick from the plan's own words. Usually:

- **The hero** (who you are)
- **Enemies / obstacles** (what hurts you)
- **The world** (tiles, background)
- **Pickups** (coins, friends, power-ups)
- **Sounds**: jump, hit, pickup, win, lose
- **Music** for the "feels like" line (epic, spooky, happy)
- **Buttons and font** for the title screen

Skip anything the game already has real art for.

## 4. Search, one plain word at a time

```
kenney-find dragon
kenney-find rock
kenney-find jump --kind sound
kenney-find music --kind sound
kenney-find castle --kind model
```

If a word finds nothing, try a nearby word ("lava" → "fire", "cat" → "fox"
or "Cube Pets"). **Never invent a path.** If it isn't in the results, it
doesn't exist.

## 5. Show him, don't tell him

- Use the Read tool on the actual PNGs (or the `Previews/` picture for 3D
  kits) so he **sees** them.
- **3 or 4 choices at a time.** One need at a time.
- Say it in his words: *"For the rocks Night dodges, I found these three.
  Which one looks right?"*
- For sounds, give him the file path to play with
  `afplay "<path>"` so he can hear it before picking.

## 6. Grab only what he picks

From **inside that game's folder**:

```
kenney-find <word> --grab
```

This copies the files into `assets/kenney/` and adds the artist to
`CREDITS.md`. Then wire it in (see the `find-assets` skill for spritesheets
and GLB notes) and save with his sentence:

```
game-save "added the spiky rocks"
```

## When doing "all my games"

End with a tiny menu, not a report:

> **Night and Hu**: real rocks and a dragon roar
> **Super Snack Cat**: a happy background song
> **Sipder Smash**: a 3D city to smash
>
> Which game do you want to start with?

Then do that one game properly, steps 2–6.
