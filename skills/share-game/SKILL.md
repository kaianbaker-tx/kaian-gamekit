---
name: share-game
description: Put a game online and get a link to send to someone. Use when Kaian wants to share, publish, send, or show a game to Dad or his friends, or asks for the link or URL.
---

# Put the game online

Sharing a link is his favourite part. Make it fast and never make him wait
on a wall of text.

**Wait to be asked.** Don't offer, don't hint, don't say "want to share it?".
He asks for this himself, every time. Suggesting it early turns a session
about making the game into a session about finishing it.

Works for both kinds of game: a Godot project builds a web version into
`docs/` first, a one-file web game is already the page and just gets pushed.

## Steps

1. From inside the game folder, run:

   ```
   share-game
   ```

2. It builds the web version into `docs/`, saves, pushes to GitHub, and
   copies the link to the clipboard.

3. **Give him the link on its own line** and say it is already copied:

   > Your game is live: https://kaianbaker-tx.github.io/spider-smash/
   > The link is copied - just paste it to Dad.

4. First publish takes about a minute before the page appears. Tell him
   that once, not repeatedly.

## When it fails

- **"export templates missing"** - Godot cannot build web versions yet.
  Tell him: *"Open Godot, click Editor, then Manage Export Templates, then
  Download and Install. It takes a few minutes, one time only."*
- **Black page when the link opens** - check `export_presets.cfg` has
  `variant/thread_support=false`. GitHub Pages cannot send the headers a
  threaded build needs. This is the single most common cause.
- **404 on the link** - Pages is not switched on. Run:
  `gh api -X POST repos/kaianbaker-tx/<slug>/pages -f "source[branch]=main" -f "source[path]=/docs"`
- **Not logged in** - `gh auth login`, which Dad has to do.

## After sharing

Offer once, then drop it:

> Want me to save a picture of it for your devlog? (`game-shot`)

Then put it on the arcade page with the rest of them:

```
game-arcade --push
```
