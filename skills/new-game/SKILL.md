---
name: new-game
description: Start a brand new game. Use when Kaian says he has a game idea, wants to make/start/build a new game, or names a game that does not exist yet. Creates the folder, the Godot project, the GitHub repo and the web link in one step.
---

# Start a new game

Kaian is 10, uses voice-to-text, and reads every word you write. His spelling
will be wrong. Work out what he meant. Never make him spell something twice.

## Steps

1. **Get the name.** He usually says it in the idea ("I want to make spider
   smash"). Show it back to him in Title Case and ask one question:

   > Your game is called **Spider Smash**. Is that spelled right?

   If he says no, use his correction exactly. It is his game. Do not
   "fix" a name he likes.

2. **Pick a starting point.** Ask which one it is closest to, listing only
   these. Never explain all six in detail - one line each.

   | say this | template |
   |---|---|
   | jumping and running | `platformer` |
   | driving | `racing` |
   | shooting | `shooter` |
   | building a town | `city` |
   | matching puzzle | `match3` |
   | something else | `blank` |

3. **Make it.**

   ```
   new-game "Spider Smash" platformer
   ```

   That does everything: folder in `~/Games/`, Godot project, git, GitHub
   repo, web address, Desktop shortcut.

4. **Get art in immediately.** A new game with no art is boring. Ask what
   the main character is, then run `kenney-find <word>` and show him the
   list before grabbing. See the `find-assets` skill.

5. **Tell him the three things he can do now**, and nothing else:

   ```
   open-game "Spider Smash"    open it
   share-game                  put it online
   game-shot "first version"   save a picture
   ```

## Rules

- One question at a time. Wait for the answer.
- If `new-game` prints an error, read it and fix it yourself. Do not paste
  the raw error at him.
- If GitHub says "not logged in", tell him: *"Ask Dad to run `gh auth login`
  - everything else works, you just can't share the link yet."*
- Do not create the folder by hand. Always use the `new-game` command so
  every game is set up the same way.
