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

pretty() {
  echo "$1" | sed -E 's/[-_]+/ /g'
}

# -------------------------------------------------------------------
# Generate Bootstrap index.html under the shared dist root
# -------------------------------------------------------------------
INDEX_FILE="$SLIDES_OUT_ROOT/index.html"

# Begin HTML
cat > "$INDEX_FILE" <<'HTML'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Betriebsinformatik Slides</title>
    <!-- Bootstrap CSS (CDN) -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
    />
    <style>
      :root {
        --brand: orange;
        --radius: 14px;
      }

      html, body {
        scroll-behavior: smooth;
      }

      /* Utilities */
      .rounded-xl { border-radius: var(--radius) !important; }

      /* Navbar */
      .navbar-brand { letter-spacing: 0.2px; }

      /* Hero */
      section.bg-light {
        background-image: radial-gradient(ellipse at top left, rgba(13,110,253,.08), transparent 50%);
      }

      /* Cards */
      .card { border-radius: var(--radius); }

      .link-icon {
          float: right;
          color: var(--brand);
          font-size: 24px;
      }

      .text-brand {
          color: var(--brand);
      }


      /* Footer */
      footer { background: linear-gradient(to bottom, rgba(0,0,0,0), rgba(0,0,0,0.02)); }

      /* Example: override Bootstrap primary button slightly */
      .btn-primary {
        --bs-btn-bg: var(--brand);
        --bs-btn-border-color: var(--brand);
        --bs-btn-hover-bg: #0b5ed7;
        --bs-btn-hover-border-color: #0a58ca;
      }
    </style>
  </head>
  <body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-body-tertiary border-bottom">
      <div class="container">
        <div class="navbar-brand fw-semibold">Betriebsinformatik Slides</div>
      </div>
    </nav>

    <!-- Hero / Jumbotron -->
    <section class="py-5 bg-light border-bottom">
      <div class="container">
        <div class="row align-items-center g-4">
          <div class="col-lg-7">
            <h1 class="display-5 fw-bold mb-3">Liebe Schüler👋</h1>
            <p class="lead text-secondary mb-4">
              Hier findet ihr zu jedem meiner Fächer die passenden Slides.
            </p>
          </div>
          <div class="col-lg-5">
            <div class="ratio ratio-16x9 rounded shadow-sm overflow-hidden bg-white">
              <div class="d-flex align-items-center justify-content-center h-100 w-100 text-secondary">
                <!-- Optional: place hero-banner.png into the same folder as index.html -->
                <img src="hero-banner.png" alt="Slides Übersicht" class="hero-img">
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Cards grid -->
    <main class="py-5">
      <div class="container">
HTML

# We’ll group as follows:
# seg1 → top H1 section (e.g., class or track)
# seg2 → H2 subject heading under seg1
# rows of cards under each seg2
prev1=""; prev2=""; open_row=0

# IMPORTANT: search under $SLIDES_OUT_ROOT and strip that exact prefix
while IFS= read -r -d '' idx; do
  # idx is like content/slides/dist/2AHWII/SWP1/WEB/01_intro/index.html
  deck_path="${idx#"$SLIDES_OUT_ROOT/"}"   # -> 2AHWII/SWP1/WEB/01_intro/index.html
  deck_dir="${deck_path%/index.html}"      # -> 2AHWII/SWP1/WEB/01_intro

  IFS='/' read -r -a parts <<< "$deck_dir"
  seg1="${parts[0]:-}"                     # e.g. 2AHWII
  seg2="${parts[1]:-}"                     # e.g. SWP1 (subject)
  # You can optionally use seg3 if you want deeper nesting:
  # seg3="${parts[2]:-}"
  name="${parts[${#parts[@]}-1]}"          # e.g. 01_intro
  display="$(pretty "$name")"

  # skip any accidental hits
  if [[ "$display" == "index.html" ]]; then
    continue
  fi

  # New top section?
  if [[ -n "$seg1" && "$seg1" != "$prev1" ]]; then
    # close any open row
    if (( open_row )); then
      echo '        </div>' >> "$INDEX_FILE"
      open_row=0
    fi
    echo "" >> "$INDEX_FILE"
    echo "        <h1 class=\"h1 mb-4 mt-4 text-brand\">$(pretty "$seg1")</h1>" >> "$INDEX_FILE"
    prev1="$seg1"
    prev2=""
  fi

  # New subject within seg1?
  if [[ -n "$seg2" && "$seg2" != "$prev2" ]]; then
    # close any open row
    if (( open_row )); then
      echo '        </div>' >> "$INDEX_FILE"
      open_row=0
    fi
    echo "        <h2 class=\"h3 mb-4 mt-4\">$(pretty "$seg2")</h2>" >> "$INDEX_FILE"
    echo '        <div class="row g-4">' >> "$INDEX_FILE"
    open_row=1
    prev2="$seg2"
  fi

  # Ensure a row exists (in case seg2 missing)
  if (( ! open_row )); then
    echo '        <div class="row g-4">' >> "$INDEX_FILE"
    open_row=1
  fi

  # Card
  cat >> "$INDEX_FILE" <<HTML
          <div class="col-sm-6 col-lg-4">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title h5">$display</h3>
                <a href="$deck_dir/" class="stretched-link" target="_blank" aria-label="Open $display"></a>
                <i class="bi bi-arrow-right-circle link-icon"></i>
              </div>
            </div>
          </div>

HTML

done < <(find "$SLIDES_OUT_ROOT" -type f -name 'index.html' -print0 | sort -z)

# Close final row/containers and footer
if (( open_row )); then
  echo '        </div>' >> "$INDEX_FILE"
fi

cat >> "$INDEX_FILE" <<'HTML'
      </div>
    </main>

    <!-- Footer -->
    <footer class="py-4 border-top">
      <div class="container d-flex flex-column flex-sm-row align-items-center justify-content-between gap-3">
        <span class="text-secondary small">&copy; <span id="year"></span> Dominik Widnig. All rights reserved.</span>
      </div>
    </footer>

    <!-- Bootstrap JS (Bundle includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Tiny helper to set the year -->
    <script>
      document.getElementById('year').textContent = new Date().getFullYear();
    </script>
  </body>
</html>
HTML

echo "✅ Generated grouped index at $INDEX_FILE"