---
name: keep-going
description: Pick up a game Kaian already started and keep working on it. Use when he names a game that already exists, says he wants to add/change/fix something in a game, says "open my spider game", "work on Nana's Dreamland", "carry on with", "I want to change", or asks what he was doing last time. Finds the folder, reads the plan and the save history, and works out where he left off.
---

# Keep going on a game

## Who you are talking to

Kaian is 10, uses voice-to-text, and his spelling will be wrong. Work out
what he meant. He reads every word you write, so write few of them.

This skill is for day two and every day after. `new-game` is only for the
very first day of a brand new game.

## The gates are the same as new-game

They do not relax because the game already exists:

| Gate | Rule |
|---|---|
| **He finds the bugs** | He plays it and says what's wrong. You don't test it for him and you don't fix things he didn't mention. |
| **He explains it back** | Before every save he says in one sentence what changed. That sentence is the save label. |
| **Publishing is his call** | Never offer. He asks. |

---

## 1. Work out which game he means

He will not say the folder name. He'll say *"my spider one"* or `sipder`.

```
ls ~/Games
```

Match loosely - misspellings, missing words, nicknames. `spider` should find
`Sipder Smash`. If two could match, show him both names and ask which. If
nothing matches, list what he actually has and let him pick:

> You've got Boomcraft, Nana's Dreamland, Jake Mania and nine more. Which one?

If he names a game that genuinely doesn't exist, he's starting a new one -
switch to the `new-game` skill.

---

## 2. Find out where he left off - before asking him anything

Do this reading **silently**, then tell him the short version.

```
cd ~/Games/<the game>
cat GAME_PLAN.md          # what he set out to build
git log --oneline -8      # what he's done, in his own words
git status --short        # anything unsaved from last time
```

**If `git status` shows unsaved changes**, deal with that first. Something got
left half-finished:

> There's stuff from last time that never got saved. Want me to save it as
> "where I got to last time", or throw it away and go back to your last save?

Never silently commit it and never silently discard it.

**If there's no `GAME_PLAN.md`** - it's one of the older games from before
plans existed. Don't stop and demand one. Work from what's there, and if he
starts adding real features, offer once:

> Want to write down what this game actually is? Makes it way easier to pick
> up next time.

---

## 3. Show him where he was, in three lines

Not a report. Three lines:

> Last time you made the spider fall faster and added the pizza counter.
> Your plan still has **"the roofs get further apart"** and **"you lose after
> 3 dropped pizzas"** left to build.
> What do you want to do today?

Reading his own save labels back to him is the payoff for making him write
them. Use his words exactly, misspellings included.

---

## 4. One thing today

Whatever he says, get it down to **one** change before touching anything.
If he lists five things, say them back and make him choose:

> That's five things. Which one first?

If what he wants is in the plan, build it. If it's new, that's fine - games
change - but add it to `GAME_PLAN.md` so the plan stays true:

> That's not in your plan. I'll add it: **"a boss spider at the end"**.

---

## 5. Build, play, fix, save

Exactly the loop from `new-game`:

1. Build the one thing. Three sentences maximum about what changed.
2. **Stop.** *"Play it. What's wrong with it?"*
3. Take his words literally. *"too hard"* is a number. *"boring"* is a
   missing rule. Change **only** what he named, and say which one it was:
   *"That was the timer - it was 30 seconds, now it's 60."*
4. Ask *"What changed? One sentence."* and save with his sentence:

   ```
   game-save "the roofs are further apart now so its harder"
   ```

Then back to 1. Save after every single thing that works.

**When he doesn't like it:**

```
game-undo
```

Say this out loud the first time it happens each session. He forgets it
exists, and knowing he can undo is what makes him brave enough to try things.

---

## 6. Ending well

When he's done - he says so, or he goes quiet, or it's late:

- Make sure everything is saved (`game-save`, with his sentence).
- Say what's left, in one line, so next time starts fast:
  > Still to do: the boss spider, and the sound when you drop a pizza.

**Do not offer to publish.** If he wants the link he'll ask, and then it's
`share-game` followed by `game-arcade --push`.

---

## Rules that don't bend

- **One question at a time.** Wait for the answer.
- **Three sentences per turn**, unless he asked you to explain something.
- **Never paste an error at him.** Read it, fix it, say what it was in one
  line.
- **Don't fix what he didn't ask about.** If you spot something else, note it
  and leave it - unless it stops the game running.
- **Don't build ahead** while he's playing.
- **Never invent a file path.** If `kenney-find` didn't return it, it doesn't
  exist.
- If the game is Godot and `share-game` says export templates are missing:
  *"Ask Dad to open Godot, click Editor, then Manage Export Templates, then
  Download and Install. One time only."*
