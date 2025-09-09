#!/usr/bin/env bash
set -euo pipefail

# Where your decks live and where to place built files
INPUT_ROOT="${INPUT_ROOT:-content/slides}"
OUT_ROOT="${OUT_ROOT:-dist}"

# MODE: "relative" (default) => --base ./ (recommended)
#       "absolute" => --base "/<repo>/<deck>/" (for GH Pages project sites)
MODE="${MODE:-absolute}"

# Only used when MODE=absolute. Defaults to "/<repo-name>/"
# You can override in CI: REPO_BASE="/my-repo/"
REPO_BASE="${REPO_BASE:-/$(basename "$(git rev-parse --show-toplevel)")/slides/}"

echo "Repo base: $REPO_BASE"

cd slides

# Find all decks recursively; adjust -maxdepth if you only want the top level
mapfile -t decks < <(find "$INPUT_ROOT" -type f -name "*.md" | sort)

if [[ ${#decks[@]} -eq 0 ]]; then
  echo "No .md decks found under $INPUT_ROOT" >&2
  exit 1
fi

rm -rf "$OUT_ROOT"
mkdir -p "$OUT_ROOT"
for md in "${decks[@]}"; do
  deck="$(basename "${md%.*}")"          # e.g. 1AWMBB2_01_intro.md -> 1AWMBB2_01_intro
  out="$OUT_ROOT"
  echo "Output dir: $out"
  mkdir -p "$out"

  if [[ "$MODE" == "relative" ]]; then
    base="./"
  else
    base="${REPO_BASE}${deck}/"
  fi

  echo "→ Building '$md' -> '$out' (base: '$base')"
  
  npx -y pnpm build "$md" --base "$base" --out "$out"

  # Safety: fix any absolute /assets URLs that might slip through
  if [[ "$MODE" == "relative" ]]; then
    if [[ -f "$out/index.html" ]]; then
      sed -i -E 's/(href|src)="\/assets\//\1="assets\//g' "$out/index.html" || true
    fi
  fi
done

echo "✅ All decks built to $OUT_ROOT"