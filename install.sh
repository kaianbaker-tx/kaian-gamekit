#!/usr/bin/env bash
# Run this once on Kaian's laptop.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BIN="$HOME/bin"
GAMES="$HOME/Games"
ASSETS="$HOME/GameAssets"
TEMPLATES="$ASSETS/templates"
# Kaian runs Claude through the `kaian` launcher, which points
# CLAUDE_CONFIG_DIR at ~/.claude-kaian. Install the skills into both
# places so they work whichever way Claude is started.
CONFIG_DIRS="$HOME/.claude $HOME/.claude-kaian"

echo ""
echo "  Setting up Kaian's game kit"
echo "  =========================="

# 1 ---------------------------------------------------------------- folders
mkdir -p "$BIN" "$GAMES" "$TEMPLATES"
for cfg in $CONFIG_DIRS; do mkdir -p "$cfg/skills"; done
echo "  [ok] folders"

# 2 ---------------------------------------------------------------- commands
for f in "$HERE"/bin/*; do
  install -m 755 "$f" "$BIN/$(basename "$f")"
done
echo "  [ok] commands installed to $BIN"

# Strays from earlier hand-copies, where the hyphen went missing.
rm -f "$BIN/gamearchaeology" "$BIN/gamedoctor" "$BIN/newgame" "$BIN/sharegame"

case ":$PATH:" in
  *":$HOME/bin:"*) ;;
  *) for rc in "$HOME/.zshrc" "$HOME/.zprofile"; do
       [ -f "$rc" ] || continue
       grep -q 'HOME/bin' "$rc" || echo 'export PATH="$HOME/bin:$PATH"' >> "$rc"
     done
     echo "  [ok] added ~/bin to PATH (open a new Terminal tab)" ;;
esac

# 3 ---------------------------------------------------------------- Kenney art
if [ ! -d "$ASSETS/Kenney/2D assets" ]; then
  ZIP="$(ls "$HOME/Downloads"/Kenney*All-in-1*.zip 2>/dev/null | head -1 || true)"
  if [ -n "$ZIP" ]; then
    echo "  ... unzipping the Kenney art library (about a minute)"
    mkdir -p "$ASSETS/Kenney"
    ditto -x -k "$ZIP" "$ASSETS/Kenney"
  else
    echo "  [!!] Kenney library missing. Put the zip in ~/Downloads and run this again."
  fi
fi
[ -d "$ASSETS/Kenney" ] && echo "  [ok] Kenney art library"

# 4 ---------------------------------------------------------------- templates
# Kenney's own starter kits - same artist as the art, so everything matches.
clone_kit() {  # clone_kit <friendly-name> <repo>
  local name="$1" repo="$2"
  [ -d "$TEMPLATES/$name" ] && return 0
  if git clone --depth 1 -q "https://github.com/KenneyNL/$repo.git" "$TEMPLATES/$name" 2>/dev/null; then
    rm -rf "$TEMPLATES/$name/.git"
    echo "      + $name"
  else
    echo "      - $name (couldn't download)"
  fi
}
echo "  ... getting Kenney's starter games"
clone_kit platformer Starter-Kit-3D-Platformer
clone_kit city       Starter-Kit-City-Builder
clone_kit shooter    Starter-Kit-FPS
clone_kit racing     Starter-Kit-Racing
clone_kit match3     Starter-Kit-Match-3
clone_kit scene      Starter-Kit-Basic-Scene
echo "  [ok] templates in $TEMPLATES"

# 5 ---------------------------------------------------------------- skills
for cfg in $CONFIG_DIRS; do
  for d in "$HERE"/skills/*/; do
    n="$(basename "$d")"
    rm -rf "$cfg/skills/$n"
    cp -R "$d" "$cfg/skills/$n"
  done
done
echo "  [ok] Claude skills installed"

# 5b -------------------------------------------------------------- guardrails
# Kaian's own Claude gets a settings file that lets the game commands run
# without nagging him, and makes everything else stop and ask. Never
# overwritten - if it's already there, whatever is in it is deliberate.
KSET="$HOME/.claude-kaian/settings.json"
if [ ! -f "$KSET" ]; then
  mkdir -p "$(dirname "$KSET")"
  cp "$HERE/settings/kaian-settings.json" "$KSET"
  echo "  [ok] Kaian's Claude settings installed"
else
  echo "  [--] Kaian's Claude settings already exist - left alone"
fi

# 5c ------------------------------------------------------- daily arcade
# Every morning at 7: fresh pictures of every game, and the arcade pushed.
# If the laptop is asleep at 7, it runs when it wakes up.
PLIST="$HOME/Library/LaunchAgents/com.kaian.arcade-daily.plist"
mkdir -p "$(dirname "$PLIST")"
cat > "$PLIST" <<PL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>             <string>com.kaian.arcade-daily</string>
  <key>ProgramArguments</key>  <array><string>$BIN/arcade-daily</string></array>
  <key>StartCalendarInterval</key>
  <dict><key>Hour</key><integer>7</integer><key>Minute</key><integer>0</integer></dict>
  <key>StandardOutPath</key>   <string>$HOME/Library/Logs/arcade-daily.log</string>
  <key>StandardErrorPath</key> <string>$HOME/Library/Logs/arcade-daily.log</string>
  <key>ProcessType</key>       <string>Background</string>
</dict>
</plist>
PL
launchctl bootout "gui/$(id -u)/com.kaian.arcade-daily" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST" 2>/dev/null || true
echo "  [ok] arcade pictures update every morning at 7"

# 6 ---------------------------------------------------------------- index
if [ -d "$ASSETS/Kenney/2D assets" ]; then
  echo "  ... reading every piece of art and sound (one time)"
  "$BIN/kenney-index" || true
fi

# 7 ---------------------------------------------------------------- check
echo ""
"$BIN/game-doctor" || true

# 8 ---------------------------------------------------------------- Finder
ln -sfn "$GAMES" "$HOME/Desktop/Games" 2>/dev/null || true
open "$GAMES" 2>/dev/null || true

cat <<'MSG'

  Done!

  ONE THING LEFT, do it by hand:
    A Finder window just opened on the Games folder.
    Drag the word "Games" from the top of that window into the
    Finder sidebar on the left. Now every game shows up there forever.

  Then, to let him publish games, run:
    gh auth login

  Kaian starts Claude by typing:
    kaian
  That keeps his chats in his own space, separate from yours.

  Commands he can use:
    new-game "Spider Smash"     make a new game
    open-game                   pick a game and open it
    kenney-find spider          look for art and sounds
    kenney-find spider --grab   copy them into the game
    share-game                  put it online and get the link
    game-arcade --push          put ALL his games on one page
    arcade-shots                new pictures of every game (runs every morning)
    game-idea                   three things he could make next
    game-save "what changed"    save a version you can come back to
    game-undo                   go back to an earlier save
    import-web-games <folder>   rescue loose .html games into ~/Games
    game-shot "added jumping"   save a picture for the devlog
    fix-games                   tidy up the games that already exist
    game-doctor                 check everything still works
    game-archaeology            find every game he ever started

MSG
