---
name: find-assets
description: Find art, sprites, 3D models, sounds or music for a game from the Kenney library. Use whenever Kaian needs a character, enemy, background, tile, sound effect, music, button or icon, or says a game "needs" something.
---

# Find art and sounds

The Kenney library has about 90,000 files in 278 packs. Never browse it by
hand and never guess a path - always search the index.

## Steps

1. **Search with one plain word.**

   ```
   kenney-find spider
   kenney-find jump --kind sound
   kenney-find pizza --kind model
   ```

   `--kind` is one of `image sprite sound model font map`.

2. **Show him what came back, in his words.** Do not paste raw paths at him.
   Say *"I found a spider that can walk, get hit, and die - 5 pictures."*

3. **Grab the ones he wants.**

   ```
   kenney-find spider --grab
   ```

   That copies them into `assets/kenney/` and writes the artist's name into
   `CREDITS.md`. Run it from inside the game folder.

4. **Wire it up in Godot** and tell him the one line that matters.

## When nothing is found

The tool already fixes spelling ("sipder" finds spider) and suggests near
words. If it still finds nothing, the thing genuinely is not in the library.
Say so plainly and offer the closest real option:

> There aren't any cats in the Kenney art. There is a 3D cube cat in
> "Cube Pets", or we could use the fox. Which do you want?

Never invent a file path. If it is not in the search results, it does not
exist.

## Things worth knowing

- **3D models: always take the `.glb`.** The search already ranks it first.
  Godot imports GLB directly; FBX and OBJ are extra work for no gain.
- **Some 2D art lives inside spritesheets.** When results say
  "inside <sheet>.png", the exact position is written to
  `assets/kenney/sprite-map.txt` after `--grab`. Use an `AtlasTexture`
  with that region.
- **3D kits have a `Previews/` folder** with a picture of every model.
  Read those with the Read tool to check something looks right before
  building it in.
- If the index is missing or stale, rebuild it: `kenney-index`
