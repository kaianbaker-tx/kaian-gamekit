# Kaian's Game Kit

## Install it (or update it)

```
git clone https://github.com/kaianbaker-tx/kaian-gamekit.git ~/GameKit
cd ~/GameKit && ./install.sh
```

Already have it? Updating is the same two lines every time:

```
cd ~/GameKit && git pull && ./install.sh
```

Then two manual steps `install.sh` will remind you about:

1. Drag the `Games` folder into the Finder sidebar (once).
2. `gh auth login` as `kaianbaker-tx`, so he can publish.
3. Kaian starts Claude by typing `kaian`, not `claude`. That points
   `CLAUDE_CONFIG_DIR` at `~/.claude-kaian`, so his chat list, settings and
   skills are entirely his own and none of Dad's sessions show up in it.

## What he gets

| command | what it does |
|---|---|
| `new-game "Spider Smash"` | folder + Godot project + GitHub repo + web link |
| `open-game` | pick a game from a list, open it in Godot |
| `kenney-find spider` | search 90,000 Kenney files in plain English |
| `kenney-find spider --grab` | copy them in, write CREDITS.md |
| `share-game` | build web version, push, copy link to clipboard |
| `game-arcade` | one page with every game on it; `--push` puts it online |
| `arcade-shots` | fresh picture of every online game for the arcade; runs every morning at 7 with `game-arcade --push` |
| `game-idea` | three things he could make next; `--go` makes one |
| `import-web-games <folder>` | turn loose one-file .html games into real games with their own repos |
| `game-save "what changed"` | save a version he can come back to |
| `game-undo` | put the game back to how it was at an earlier save |
| `kaian` | start Claude in his own space, with his own chat list |
| `game-shot "added jumping"` | screenshot into DEVLOG.md |
| `game-archaeology` | find every game he ever started, on disk **and** in his Claude history |
| `game-doctor` | check Godot, templates, GitHub login, index |
| `fix-games` | tidy the games that already exist (plan only; `--go` to apply) |

Claude on his laptop gets four skills so he can just talk:

- **`new-game`** - the whole first day of a new game. Shows him two of his own
  games to pick an engine, then runs a seven-question design interview that
  becomes `GAME_PLAN.md` before a line of code is written. Builds one piece at
  a time, stops after each so he plays it and says what's wrong, and saves
  using his own sentence as the label. Never offers to publish - he asks.
- **`keep-going`** - day two and after. Finds the game he means even if he
  spells it wrong, reads the plan and the save history, tells him where he
  left off, and runs the same loop.
- **`find-assets`** - searches 90,000 Kenney files and shows him the actual
  pictures to choose from.
- **`share-game`** - publishes and hands him the link.

## Guardrails

`install.sh` writes `~/.claude-kaian/settings.json` the first time, allowing
the game commands to run without prompting and making everything else ask.
It is never overwritten once it exists.

Be clear-eyed about what that is: Claude Code's own documentation says Bash
prefix rules are **a convenience, not a security boundary**. They stop
accidents and casual mischief. They are not designed to withstand someone
deliberately trying to get around them. If you want real enforcement, the
supported answer is sandboxing, not a longer deny list.
