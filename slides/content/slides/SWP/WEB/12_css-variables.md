---
theme: seriph
routerMode: hash
title: CSS-Variablen & Theming
info: |
  ## CSS-Variablen & Theming
background: https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true
class: text-center
drawings:
    persist: false
transition: slide-left
mdc: true
layout: cover
hideInToc: true
download: true
export:
    format: pdf
    dark: false
    withClicks: true
    withToc: true
selectable: true
---

# CSS-Variablen & Theming
## Moderne, flexible und wartbare Gestaltung

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" columns="1" />

---

# Was sind CSS-Variablen?

- Benutzerdefinierte Werte, die überall im CSS genutzt werden können  
- Werden mit `--` und Variablenname definiert (e.g. `--my-favorite-color`) 
- Werden mit `var(--my-favorite-color)` verwendet  
- Können vererbt werden (inheritance)

**Beispiel:**

```css
:root {
  --primary-color: #4e8cff;
  --padding: 1rem;
}

button {
  background: var(--primary-color);
  padding: var(--padding);
}
```
---

# Warum CSS-Variablen nutzen?

<br>

✔ Wiederverwendbare Werte

✔ Einfaches globales Styling

✔ Dunkel/Hell-Themes

✔ Weniger Wiederholungen → sauberer Code

---

# Syntax
***

**Variablen definieren:**

```css
:root {
  --bg: white;
  --fg: black;
}
```

- `:root` = höchste Ebene (`html`-Element) → ideal für **globale** Variablen
- Variablen beginnen **immer mit zwei Bindestrichen**

<br>

**Variablen verwenden:**

```css
body {
  background-color: var(--bg);
  color: var(--fg, red); /* mit Fallback */
}
```

---
layout: two-cols
layoutClass: gap-16
---

# Theming: Dark vs. Light Mode

```css
:root {
  --bg: white;
  --text: black;
}

.dark {
  --bg: #1e1e1e;
  --text: #fafafa;
}

body {
  background: var(--bg);
  color: var(--text);
}
```

Aufruf: 
```html
<body class="dark">
  <p>This is a text in dark mode</p>
</body>
```

::right::

<style>
:root {
  --bg: white;
  --text: black;
}

.dark {
  --bg: #1e1e1e;
  --text: #fafafa;
}

div {
  background: var(--bg) !important;
  color: var(--text) !important;
  height: 100%;
}
</style>
<div class="dark">
  <p>This is a text in dark mode</p>
</div>

---

# Automatischer Dark Mode

Wechselt je nach Betriebssystem-Theme.

```css
:root {
  --bg: white;
  --text: black;
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg: #121212;
    --text: #eeeeee;
  }
}
```

---

# Typische Einsatzgebiete

<br>

🎨 Farben (`--primary`, `--bg`, `--text`)

📏 Abstände (`--padding`, `--gap`, `--space-xl`)

🔠 Typografie (`--font-size`, `--line-height`, `--font-main`)

🧱 Layout (`--width`, `--max-width`, `--radius`)

🌈 Themes (Dark/Light/Branding)

---
 
# Gruppieren von Variablen nach Kategorie

Einer der häufigsten Methoden.

```css
:root {
  /* 🎨 Farben */
  --color-primary: #4e8cff;
  --color-secondary: #ffb84e;
  --color-bg: #ffffff;
  --color-text: #1a1a1a;

  /* 🔠 Typografie */
  --font-size-base: 16px;
  --font-size-lg: 20px;
  --font-weight-bold: 700;

  /* 📏 Abstände */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;

  /* 🧱 Layout */
  --radius: 12px;
  --max-width: 800px;
}
```

---

# Gruppieren von Variablen nach Komponenten

Sinnvoll, wenn du große Projekte hast.

```css
:root {
  /* Button Component */
  --button-bg: #4e8cff;
  --button-color: white;
  --button-radius: 8px;
  --button-padding: 0.5rem 1rem;

  /* Card Component */
  --card-bg: white;
  --card-shadow: 0 2px 6px rgba(0,0,0,0.15);
  --card-radius: 12px;
}

```

<br>

**Vorteil:** Komponenten werden schnell anpassbar.

---


# Best Practice

- Verwende :root für globale Variablen
- Gruppiere Variablen logisch
- Benutze sprechende Namen statt Farben:
  - ❌ `--blue`
  - ✔ `--primary-color`
- Nutze Variablen auch für Abstände
- Vermeide *hardcoded* Werte in CSS Klassen








