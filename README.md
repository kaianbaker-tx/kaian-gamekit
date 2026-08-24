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

## What he gets

| command | what it does |
|---|---|
| `new-game "Spider Smash"` | folder + Godot project + GitHub repo + web link |
| `open-game` | pick a game from a list, open it in Godot |
| `kenney-find spider` | search 90,000 Kenney files in plain English |
| `kenney-find spider --grab` | copy them in, write CREDITS.md |
| `share-game` | build web version, push, copy link to clipboard |
| `game-arcade` | one page with every game on it; `--push` puts it online |
| `game-idea` | three things he could make next; `--go` makes one |
| `import-web-games <folder>` | turn loose one-file .html games into real games with their own repos |
| `game-shot "added jumping"` | screenshot into DEVLOG.md |
| `game-archaeology` | find every game he ever started, on disk **and** in his Claude history |
| `game-doctor` | check Godot, templates, GitHub login, index |
| `fix-games` | tidy the games that already exist (plan only; `--go` to apply) |

Claude on his laptop gets three skills so he can just talk: `new-game`,
`find-assets`, `share-game`.
