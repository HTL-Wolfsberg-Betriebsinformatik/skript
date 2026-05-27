# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a teaching materials repository for a Betriebsinformatik (Business IT) school curriculum. It contains two independent sub-projects:

- **`script/`** — MkDocs-based written course notes (text/wiki)
- **`slides/`** — Slidev-based presentation decks (interactive slide shows)

Both are built and merged into a single GitHub Pages site via CI (`build_all.sh` + `.github/workflows/docs.yml`).

## Commands

### Script (MkDocs)

```bash
cd script
pip install -r ../requirements.txt  # one-time; uses mkdocs-material[all]
mkdocs serve                        # dev server at http://127.0.0.1:8000
mkdocs build --strict               # production build → script/site/
```

### Slides (Slidev)

```bash
cd slides
pnpm install                        # install deps
npx pnpm dev content/slides/SWP/PR/05-conditions.md   # dev single deck
npx pnpm build content/slides/SWP/PR/05-conditions.md # build single deck
```

Build all decks (used by CI):

```bash
# Run from repo root — outputs to slides/content/slides/dist/
bash build_all.sh
```

CI environment variables for `build_all.sh`:
- `MODE=absolute` — use absolute base paths (for GitHub Pages project sites)
- `REPO_BASE=/<repo-name>/slides/` — base URL prefix
- `INPUT_ROOT=content/slides` — where decks live (relative to `slides/`)

## Architecture

### Script (`script/`)

- `mkdocs.yml` — navigation tree and Material theme config; all new pages must be registered here under `nav:`
- `docs/` — all `.md` content files, organized by subject (`INFI/`, `SWP/PR/`, `SWP/WEB/`, `SWP/PM/`, `MUL/`) and then by class year (`2AHWII/`, `3AHWII/`, etc.)
- Uses pymdownx extensions: `superfences` (mermaid diagrams), `snippets` (file includes with `base_path: ["docs"]`), `tabbed`, `admonition`

### Slides (`slides/`)

- Each `.md` file in `content/slides/**` is an independent Slidev deck
- Slide decks are organized by subject: `content/slides/Informatik/`, `content/slides/SWP/PR/`, `content/slides/SWP/WEB/`, `content/slides/MINT/`
- Naming convention: `NN_kebab-case-topic.md` (some older files use `-` separators instead of `_`)
- Each deck frontmatter uses `theme: seriph`, background from the shared `background-cover-16-9.webp`, `routerMode: hash`, and `download: true`
- Custom Vue components live in `slides/components/` and are auto-imported into every deck
- `build_all.sh` discovers all `*.md` files under `INPUT_ROOT`, builds each with `npx pnpm build`, then generates a Bootstrap index page grouping decks by class year and subject

### CI / Deployment

`build_all.sh` + `.github/workflows/docs.yml` builds both sub-projects on push to `main` and deploys to GitHub Pages. The MkDocs output lands at the site root; Slidev decks land under `/slides/`.

## Content Subjects

| Subject | Abbrev | Topics |
|---------|--------|--------|
| Informatik | INFI | Databases (SQL, ER modelling, BPMN), Business Intelligence |
| SWP Programmieren | SWP/PR | C# (structured → OOP), algorithms, file handling |
| SWP Web | SWP/WEB | HTML, CSS, JavaScript, TypeScript |
| SWP Projektmanagement | SWP/PM | UML, software engineering models, design patterns |
| Multimedia | MUL | Multimedia tools and concepts |
