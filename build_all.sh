#!/usr/bin/env bash
set -euo pipefail

# Where your decks live and where to place built files
INPUT_ROOT="${INPUT_ROOT:-content/slides}"
OUT_AT_REPO="${OUT_AT_REPO:-dist}"

# MODE: "relative" (default) => --base ./ (recommended)
#       "absolute" => --base "/<repo>/<deck>/" (for GH Pages project sites)
MODE="${MODE:-absolute}"

# Only used when MODE=absolute. Defaults to "/<repo-name>/"
# You can override in CI: REPO_BASE="/my-repo/"
REPO_BASE="${REPO_BASE:-/$(basename "$(git rev-parse --show-toplevel)")/}"

echo "Repo base: $REPO_BASE"

cd slides

# Find all decks recursively; adjust -maxdepth if you only want the top level
mapfile -t decks < <(find "$INPUT_ROOT" -type f -name "*.md" | sort)

if [[ ${#decks[@]} -eq 0 ]]; then
  echo "No .md decks found under $INPUT_ROOT" >&2
  exit 1
else
  echo "Found ${#decks[@]} decks:"
  for d in "${decks[@]}"; do
    echo " - $d"
  done
fi

SLIDES_OUT_ROOT="$INPUT_ROOT/$OUT_AT_REPO"

for md in "${decks[@]}"; do
  rel="${md#"$INPUT_ROOT"/}"        # e.g. 2AHWII/SWP1/WEB/01_intro.md
  rel_no_ext="${rel%.md}"           # e.g. 2AHWII/SWP1/WEB/01_intro
  rel_dir="$(dirname "$rel")"       # e.g. 2AHWII/SWP1/WEB

  # How many folders deep is the md under INPUT_ROOT?
  depth=0
  if [[ "$rel_dir" != "." ]]; then
    # Count components in rel_dir
    IFS='/' read -r -a parts <<< "$rel_dir"
    depth="${#parts[@]}"
  fi

  # Build an escape prefix like "../../../" relative to the deck's folder
  up=""
  if (( depth > 0 )); then
    up=$(printf '../%.0s' $(seq 1 $depth))
  fi

  # --out must be relative to the deck's folder → step out to repo, then into shared dist
  out_rel="${up}${OUT_AT_REPO}/${rel_no_ext}"   # e.g. ../../../dist/2AHWII/SWP1/WEB/01_intro

  # base for Slidev/Vite
  if [[ "$MODE" == "relative" ]]; then
    base="./"
  else
    # absolute base (good for GH Pages project sites)
    base="${REPO_BASE}${rel_no_ext}/"   # e.g. /skript/2AHWII/SWP1/WEB/01_intro/
  fi

  echo "→ Building: $md"
  echo "   depth:  $depth"
  echo "   out:    $out_rel"
  echo "   base:   $base"

  npx pnpm build "$md" --base "$base" --out "$out_rel"
done

echo "✅ All decks built to $OUT_AT_REPO"

# --- Generate grouped Bootstrap index.html under the shared dist root ---
INDEX_FILE="$SLIDES_OUT_ROOT/index.html"

cat > "$INDEX_FILE" <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Slidev Presentations</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="container py-5">
    <h1 class="mb-5 text-center">Available Presentations</h1>
HTML

prev1=""; prev2=""; prev3=""; open_row=0

# IMPORTANT: search under $SLIDES_OUT_ROOT and strip that exact prefix
while IFS= read -r -d '' idx; do
  # idx is an absolute/relative path like content/slides/dist/2AHWII/SWP1/WEB/01_intro/index.html
  deck_path="${idx#"$SLIDES_OUT_ROOT/"}"   # -> 2AHWII/SWP1/WEB/01_intro/index.html
  deck_dir="${deck_path%/index.html}"      # -> 2AHWII/SWP1/WEB/01_intro

  IFS='/' read -r -a parts <<< "$deck_dir"
  seg1="${parts[0]:-}"                     # 2AHWII
  seg2="${parts[1]:-}"                     # SWP1 (optional)
  seg3="${parts[2]:-}"                     # WEB  (optional)
  name="${parts[${#parts[@]}-1]}"          # 01_intro
  display="${name}"                        # show as 01_intro

  if [[ "$display" == "index.html" ]]; then
    continue
  fi

  # Headings (h2/h3/h4) per your nesting rules
  if [[ -n "$seg1" && "$seg1" != "$prev1" ]]; then
    if (( open_row )); then echo '    </div>' >> "$INDEX_FILE"; open_row=0; fi
    echo "    <h2 class=\"mt-4\">$seg1</h2>" >> "$INDEX_FILE"
    prev1="$seg1"; prev2=""; prev3=""
  fi
  if [[ -n "$seg2" && "$seg2" != "$prev2" ]]; then
    if (( open_row )); then echo '    </div>' >> "$INDEX_FILE"; open_row=0; fi
    echo "    <h3 class=\"mt-3\">$seg2</h3>" >> "$INDEX_FILE"
    prev2="$seg2"; prev3=""
  fi
  if [[ -n "$seg3" && "$seg3" != "$prev3" ]]; then
    if (( open_row )); then echo '    </div>' >> "$INDEX_FILE"; open_row=0; fi
    echo "    <h4 class=\"mt-2\">$seg3</h4>" >> "$INDEX_FILE"
    echo '    <div class="row g-3">' >> "$INDEX_FILE"
    open_row=1
    prev3="$seg3"
  fi
  if (( ! open_row )); then
    echo '    <div class="row g-3">' >> "$INDEX_FILE"
    open_row=1
  fi

  # Card (href relative to the deployed root; no SLIDES_OUT_ROOT prefix)
  cat >> "$INDEX_FILE" <<HTML
       <a href="$deck_dir/" target="_blank" >$display</a>

HTML
done < <(find "$SLIDES_OUT_ROOT" -type f -name 'index.html' -print0 | sort -z)

if (( open_row )); then echo '    </div>' >> "$INDEX_FILE"; fi

cat >> "$INDEX_FILE" <<'HTML'
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
HTML

echo "✅ Generated grouped index at $INDEX_FILE"