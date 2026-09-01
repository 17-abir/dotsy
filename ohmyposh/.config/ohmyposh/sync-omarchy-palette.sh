#!/usr/bin/env bash
# Regenerates the "palette" block of your oh-my-posh theme from Omarchy's
# active colors.toml. Cheap to call every prompt (the caller in .zshrc only
# invokes it when colors.toml's mtime moves).
#
# Palette keys now match colors.toml keys 1:1 (accent, muted, red, blue, ...),
# so this just copies every `key = "#hexvalue"` line straight across —
# no per-key mapping to maintain. Non-color keys (mode = "dark") are skipped
# automatically since their value doesn't start with #.
set -euo pipefail

COLORS_TOML="$HOME/.local/state/omarchy/current/theme/colors.toml"
OMP_CONFIG="$HOME/.config/ohmyposh/omarchy.omp.json"

[[ -f "$COLORS_TOML" && -f "$OMP_CONFIG" ]] || exit 0
command -v jq >/dev/null || { echo "sync-omarchy-palette: jq not found (sudo apt install jq)" >&2; exit 1; }

palette=$(awk -F'"' '/^[a-z_]+[ \t]*=[ \t]*"#/ {
  key=$1; gsub(/[ \t=]+$/, "", key); print key "\t" $2
}' "$COLORS_TOML" | jq -R -s '
  split("\n") | map(select(length > 0) | split("\t")) |
  map({(.[0]): .[1]}) | add
')

tmp=$(mktemp)
jq --argjson p "$palette" '.palette = $p' "$OMP_CONFIG" > "$tmp" && mv "$tmp" "$OMP_CONFIG"