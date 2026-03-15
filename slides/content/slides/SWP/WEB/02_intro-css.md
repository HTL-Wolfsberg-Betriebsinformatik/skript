---
theme: seriph
routerMode: hash
title: Einführung CSS
info: |
  ## Intro CSS, Farben, Einheiten
background: https://raw.githubusercontent.com/HTL-Wolfsberg-Betriebsinformatik/skript/refs/heads/main/slides/content/slides/background-cover-16-9.webp
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

# Einführung in CSS

## Cascading Style Sheets
---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Warum brauchen wir CSS?

<hr>

<br>

- HTML = Struktur der Inhalte  
- **CSS = Design**  
  👉 Farben, Schriftarten, Abstände, Layouts  
- **Ohne CSS:** alle Seiten sehen gleich aus  
- **Mit CSS:** moderne, ansprechende Webseiten

---

# CSS Game: Turn off the Styles

<br>

**Aufgabe:**

- Besuche eine beliebige Website, die du kennst (z. B. Nachrichten, Shop, Social Media).

- Öffne die **DevTools Console** (`F12` → Tab „Console“).

- Gib folgenden Befehl ein:

```js
Array.from(document.styleSheets).forEach(s => s.disabled = true);
// falls eine Warnung kommt, folgenden Befehl eingeben: allow pasting
```
<br>

- Wie sieht die Seite ohne CSS aus?
- Ist sie noch verständlich oder chaotisch?
- Vergleiche mit der normalen Version (CSS wieder aktivieren):

```js
Array.from(document.styleSheets).forEach(s => s.disabled = false);
```



---
layout: two-cols-header
layoutClass: gap-16
---

# Einbindung von CSS

<hr>

::left::

1. **Inline**  
```html
<p style="color:red;">Roter Text</p>
```

<br>

2. **Im `<style>`-Tag**

```html
<style>
  body { background: lightyellow; }
</style>
```

::right::

3. **Externe Datei <span v-mark.red="1">(empfohlen)</span>**

```html [index.html]
<head>
  <link rel="stylesheet" href="style.css">
</head>
```

```css [style.css]

body {
  background: lightyellow;
}

```

---

# CSS Syntax

```css
selektor {
  eigenschaft: wert;
}
```

| **Wichtige Eigenschaften**        | **Beschreibung**     |
| ------------------ | ---------------- |
| `color`            | Textfarbe        |
| `background-color` | Hintergrundfarbe |
| `font-size`        | Schriftgröße     |
| `padding`, `margin`| Innenabstand, Außenabstand     |
| `border`           | Rahmen           |
| `text-align`       | Textausrichtung  |

---

# Beispiel - CSS Eigenschaften

1. Färbt alle `p` tags grau und setzt die Schriftgröße auf 16px.

```css
p {
  color: gray;
  font-size: 16px;
}
```

<br>

2. Setzt für alle `p` tags einen grünen Hintergrund und ändert den Innenabstand

```css
p {
  background-color: green;
  padding: 32px;
}
```

<br>

3. Umrahmt alle `h1` tags und zentriert den Text

```css
h1 {
  border: 4px solid black;
  text-align: center;
}
```
---


# CSS Selektoren

<hr>

- **Element:** `p { color: gray; }`

- **Klasse:** `.info { background: lightblue; }`

- **ID:** `#haupt { border: 1px solid black; }`

- **Verschachtelt:** `p span { color: blue; }`

- **Mehrfach:** `h1, h2, h3 { font-family: Verdana; }`

- **Pseudoklassen:** `a:hover { color: red; }`

---

# Farben in CSS

<hr>

- **Benannte Farben:** `color: red;`

- **Hex:**  `color: #ff0000;` oder `color: #f00;`

- **RGB / RGBA:** `color: rgb(255,0,0)`, `color: rgba(255,0,0,0.5)`

- **HSL / HSLA:** `color: hsl(0,100%,50%)`

<br>

> 👉 Mit Alpha-Wert Transparenz steuern

---

# Einheiten in CSS

<hr>

**Absolute Einheiten:**

- `px` (Pixel) – Standard fürs Web
- `cm`, `mm`, `pt` – eher für Print

<br>

**Relative Enheiten (empfohlen):**

- `em` – relativ zur Schriftgröße des Elternelements
- `rem` – relativ zur Schriftgröße des html-Elements
- `%` – relativ zum Elternelement
- `vw`, `vh` – relativ zum Viewport
- `vmin`, `vmax` – relativ zur kleineren / größeren Seite
- `ch` – Breite der „0“ einer Schrift

---

# Beispiel - Relative Einheiten

```css
html { font-size: 16px; }
p { font-size: 1.5em; }  /* = 24px */
p { font-size: 1.5rem; } /* = 24px */
div { width: 50%; }      /* halbe Breite */
h1  { font-size: 5vmin; } /* skaliert mit Fenstergröße */
```

<br>

**Best Practices:**

```css
html { font-size: 16px; }   /* Basiswert */
body { font-size: 1rem; }   /* 16px */
h1   { font-size: 2rem; }   /* 32px */
p    { line-height: 1.6; }  /* bessere Lesbarkeit */
```

✅ **relative Einheiten** bevorzugen

✅ Lesbarkeit (**Zeilenhöhe**) beachten

✅ CSS in **externe Datei** auslagern