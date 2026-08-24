# Shared helpers. Sourced by the other commands, not run on its own.

find_godot() {
  # An explicit override always wins.
  if [ -n "${GODOT_BIN:-}" ] && [ -x "$GODOT_BIN" ]; then printf '%s' "$GODOT_BIN"; return 0; fi
  local c
  for c in "$HOME/bin/godot" "$HOME/bin/Godot" \
           /usr/local/bin/godot /opt/homebrew/bin/godot; do
    [ -x "$c" ] && { printf '%s' "$c"; return 0; }
  done
  c="$(command -v godot 2>/dev/null)"
  [ -n "$c" ] && { printf '%s' "$c"; return 0; }
  # App bundles, newest first.
  for c in "$HOME/Applications"/Godot*.app /Applications/Godot*.app; do
    [ -d "$c" ] || continue
    local inner
    for inner in "$c/Contents/MacOS/Godot" "$c/Contents/MacOS/godot"; do
      [ -x "$inner" ] && { printf '%s' "$inner"; return 0; }
    done
  done
  return 1
}

godot_version() { "$1" --version 2>/dev/null | head -1; }

# Godot needs "export templates" matching its version to build a web version.
web_templates_ok() {
  local d="$HOME/Library/Application Support/Godot/export_templates"
  [ -d "$d" ] || return 1
  ls "$d"/*/web_nothreads_release.zip >/dev/null 2>&1 && return 0
  ls "$d"/*/web_release.zip           >/dev/null 2>&1 && return 0
  return 1
}
