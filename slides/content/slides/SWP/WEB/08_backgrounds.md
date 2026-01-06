---
theme: seriph
routerMode: hash
title: Backgrounds in CSS
info: |
  ## Backgrounds in CSS
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

#  Backgrounds in CSS

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" columns="1" />

---
layout: two-cols
---

# Grundidee

CSS bietet eine Vielzahl an Möglichkeiten, um Hintergründe für Elemente zu gestalten 

- einfache Farben 
- komplexe Muster 
- ein Hintergrundbild
- mehrere Hintergrundbilder

::right::

<style>

.container {
  width: 210px;
  height: 113px;
}

.simple-color {
  background-color: blue;
}

.bg-image {
  background-image: url("https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true");
  background-size: cover;
}

.bg-gradient {
  background: radial-gradient(circle, white, blue);
}

.bg-multi-image {
  background-image: url("./assets/images/htl-logo.png"), url("https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true");
  background-position: top center, left top;
  background-repeat: no-repeat, no-repeat;
  padding: 15px;
  background-size: contain, cover;
}

</style>

<div style="display: flex; gap: 16px; flex-wrap: wrap; height: 100%; align-content: flex-end; justify-content: center;">
  <div class="container simple-color"></div>
  <div class="container bg-gradient"></div>
  <div class="container bg-image"></div>
  <div class="container bg-multi-image"></div>
</div>

---

# Hintegrundfarbe

Legt die **Füllfarbe** eines Elements fest.

- Akzeptiert **benannte Farben** (red), **Hex-Werte** (#ff0000), **RGB**(a) oder **HSL**(a)
- Standardwert: transparent
```css
div {
  background-color: lightblue;
}
```

**Beispiel:**

<style>
.container {
  width: 50%;
  height: 30%;
  background-color: lightblue;
}
</style>
<br>
<div class="container"></div>

---

# Hintergrundbild

Fügt ein Bild als Hintegrund hinzu.

- Pfad kann **relativ** (`images/bg.png`) oder **absolut** (`https://...`) sein.

```css
div {
  background-image: url("hintergrund.jpg");
}
```

**Beispiel:**

<style>
.container {
  width: 40%;
  height: 40%;
  background-image: url("https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true");
  background-size: cover;
}
</style>
<br>
<div class="container"></div>

---

# Wiederholung steuern mit `background-repeat`

Legt fest, ob und wie sich das Hintergrundbild wiederholt.

<br>

![Tile](./assets/images/doodad.png)


```css
div {
    background-repeat: repeat; /* default, ansonst `no-repeat` setzen */
}
```
<br>

<style>
.container {
  width: 80%;
  height: 40%;
  background-image: url("./assets/images/doodad.png");
  background-repeat: repeat;
}
</style>

<div class="container"></div>

---

# Positionieren mit `background-position`

Steuert die Position des Hintergrundbilds.

```css
div {
  background-position: center; /* zentriert */
  background-position: top left;
  background-position: 40% 20%; /* horizontal vertikal */
}
```

**Mögliche Werte:**

- Schlüsselwörter: `left`, `center`, `right`, `top`, `bottom`
- Pixelangaben: `20px 50px`
- Prozente: `50% 100%` (relativ zur Elementgröße)
- Gemischt: `20% left`

<style>
.image {
  width: 40%;
  height: 25%;
  background-image: url("./assets/images/doodad.png");
  background-repeat: no-repeat;
  background-color: lightblue;
  text-align: center;
  font-family: monospace;
}

.pos-center-center {
  background-position: center center;
}

.pos-top-left {
  background-position: top left;
}

.pos-bottom-right {
  background-position: bottom right;
}
</style>

<div style="display: flex; gap: 16px; height: 100%;">
  <div class="image pos-top-left"> top left</div>
  <div class="image pos-center-center">center center</div>
  <div class="image pos-bottom-right">bottom right</div>
</div>

---

# Größe mit `background-size`

Bestimmt, wie groß das Hintergrundbild angezeigt wird.

```css
div {
  background-size: cover;
}
```

<style>
.bg {
  width: 30%;
  height: 40%;
  background-image: url("https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true");
  background-repeat: no-repeat;
  background-color: red;
  text-align: center;
  font-family: monospace;
  color: white;
}

.bg-size-cover {
  background-size: cover;
}

.bg-size-contain {
  background-size: contain;
}

.bg-size-percentage {
  background-size: 50% 75%;
}

</style>
<br>
<div style="display: flex; gap: 16px; height: 100%;">
  <div class="bg bg-size-contain">contain</div>
  <div class="bg bg-size-cover">cover</div>
  <div class="bg bg-size-percentage">50% 75%</div>
</div>

---

# CSS Gradienten

Hintergründe müssen nicht immer Bilder sein – CSS bietet Verläufe ohne externe Dateien:

```css
.linear {
  background: linear-gradient(to right, red, orange, yellow);
}
.radial {
  background: radial-gradient(circle, white, blue);
}
.repeat {
  background: repeating-linear-gradient(45deg, cyan, black 10%, cyan 20%);
}
```

<style>
.bg {
  width: 30%;
  text-align: center;
  font-family: monospace;
  color: white;
}

.linear {
  background: linear-gradient(to right, red, orange, yellow);
}

.radial {
  background: radial-gradient(circle, white, blue);
}

.repeat {
  background: repeating-linear-gradient(45deg, cyan, black 10%, cyan 20%);
}

</style>
<br>
<div style="display: flex; gap: 16px; height: 80px;">
  <div class="bg linear">linear</div>
  <div class="bg radial">radial</div>
  <div class="bg repeat">repeating linear</div>
</div>

<br>

> Einen **CSS Gradient Generator** gibt es hier: https://cssgradient.io/ 

---

# Mehrere Hintegrundbilder

Mehrere Bilder sind durch Komma getrennt → Vordergrund-Bild zuerst, dann darunter liegende

```css
div {
  background-image: url("logo.png"), url("hintergrund.jpg");
  background-position: top right, left top;
  background-repeat: no-repeat, no-repeat;
  background-size: 80px, cover;
}
```

<style>
.container {
  width: 410px;
  height: 226px;
  margin-top: 40px;
}

.bg-multi-image {
  background-image: url("./assets/images/htl-logo.png"), url("https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true");
  background-position: top right, left top;
  background-repeat: no-repeat, no-repeat;
  background-size: 80px, cover;
}
</style>
<div class="container bg-multi-image"></div>

---

# Links

- Lizenzfreie Bilder: https://unsplash.com/de/images/stock/royalty-free
- Pattern Generator, Gradient Generator: https://doodad.dev/
- Gradient Generator: https://cssgradient.io/
