---
theme: seriph
routerMode: hash
title: Interaktion & Effekte
info: |
  ## Interaktion & Effekte
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

# Interaktion & Effekte

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" columns="1" />

---

# Überblick

Mit CSS lassen sich auch **Reaktionen auf Benutzerinteraktionen**  
und **visuelle Übergänge** gestalten. Dadurch entsteht ein **dynamisches Erscheinungsbild**,  
das Inhalte hervorhebt und Bedienung erleichtert.

<style>
.card {
  cursor: pointer;
  height: auto;
  width: 250px;
  border-radius: 8px;
  padding: 16px;
  font-family: Noto, sans-serif;
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  transform: translateY(0) scale(1);
  transition: transform .25s ease, box-shadow .25s ease;
}

.card:hover {
  transform: translateY(-4px) scale(1.01);
  box-shadow: 0 10px 30px rgba(0,0,0,.12);
}

.card-image {
  background-image: url("./assets/images/flexbox/flex-wrap.svg");
  background-repeat: no-repeat;
  background-size: contain;
  height: 150px;
}

.card-image img {
  height: inherit;
}
</style>

<div style="display: flex; justify-content: center; width: 100%;">
  <div class="card">
    <div class="card-image">
    </div>
    <div class="card-header">
      <h3> Learn Flexbox </h3>
    </div>
    <div class="card-body">
      <p> Modernes Layout gestalten mit Flexbox. Erfahre mehr in diesem Beitrag </p>
    </div>
  </div>
</div>

---

# Themenbereiche

| Thema | Beschreibung | Beispiel |
|:--|:--|:--|
| **Pseudoklassen** | Zustände von Elementen, z. B. beim Bewegen der Maus oder bei Fokus | `:hover` |
| **Schatteneffekte** | Erzeugen von Tiefe und Kontrast | `box-shadow`  |
| **Transform** | Vreschieben, drehen, skalieren oder verzerren von Elementen | `translate`  |
| **Transition** | Sanfte Übergänge zwischen Zuständen | z. B. Farbwechsel beim Hover |

---

# Pseudoklasse `:hover`

Pseudoklassen werden verwendet, um **Zustände von Elementen** zu gestalten.  
Sie beschreiben, **wie ein Element aussieht**, wenn sich sein Zustand verändert –  
zum Beispiel beim Überfahren mit der Maus (*=Hovereffekt*).

**Beispiel:**

```html
<style>
a {
  color: steelblue;
  text-decoration: none;
}

a:hover {
  color: orange;
  text-decoration: underline;
}
</style>

<a href="#">Link</a>
```

<style>
a {
  color: steelblue;
  text-decoration: none;
  border-bottom-width: 0;
}

a:hover {
  color: orange;
  text-decoration: underline;
}
</style>

<a href="#">Link</a>

---
layout: two-cols-header
layoutClass: gap-8
---

# Schatteneffekte

Schatten verleihen Elementen Tiefe und Kontrast. Sie können Texte oder Boxen vom Hintergrund abheben und Lesbarkeit verbessern.

```css
box-shadow: x-Verschiebung y-Verschiebung Weichzeichnung Farbe;
```

<br>

**Beispiel:**

::left::

```html
<style>
.card {
  width: 180px;
  height: 100px;
  box-shadow: 4px 4px 12px rgba(0,0,0,0.3);
}
</style>

<div class="card"></div>
```

::right::

<style>
.card {
  width: 180px;
  height: 180px;
  box-shadow: 4px 4px 12px rgba(0,0,0,0.3);
}
</style>

<br>

<div class="card"></div>

---
layout: two-cols
layoutClass: gap-8
---

# Transformieren

Mit der Eigenschaft `transform` können HTML-Elemente **verschoben**, **gedreht**, **skaliert** oder **verzerrt** werden – ohne das Layout zu verändern. 

```css
transform: <funktion1>(wert) <funktion2>(wert);
```

<br>

<style>
.item {
  height: 180px;
  width: 180px;
  background-color: lightblue;
}
.item:hover {
  transform: translateY(10px) scale(1.1);
}
</style>

<div class="item"></div> 

::right::
**Beispiel:**

```css
div {
  /* Beispiel mit mehreren Transformationen */
  transform: translateY(10px) scale(1.1);

  /* Weitere mögliche Funktionen */
  transform: translateX(20px);   /* Verschieben auf der X-Achse */
  transform: translateY(10px);   /* Verschieben auf der Y-Achse */
  transform: scale(1.2);         /* Vergrößern */
  transform: rotate(15deg);      /* Drehen */
  transform: skew(10deg, 5deg);  /* Schrägstellen */

  /* Kombinationen sind erlaubt */
  transform: translateX(10px) rotate(10deg) scale(1.1);
}

```

---
layout: two-cols-header
layoutClass: gap-8
---

# Transition

Mit `transition` lassen sich **sanfte Übergänge** zwischen **zwei Zuständen** erstellen.
Dadurch wirken Farb- oder Größenänderungen **fließend**, statt abrupt.

```css
transition: [Eigenschaft] [Dauer] [Timing] [Verzögerung];
```

**Beispiel:**

::left::

```html
<style>
.box {
  width: 150px;
  height: 80px;
  background-color: lightblue;
  transition: background-color 0.5s;
}

.box:hover {
  background-color: steelblue;
}
</style>
<div class="box"></div>
```

::right::

<style>
.box {
  width: 150px;
  height: 80px;
  background-color: lightblue;
  transition: background-color 0.5s;
}

.box:hover {
  background-color: steelblue;
}
</style>
<div class="box"></div>

---
layout: two-cols
layoutClass: gap-16
---

# Bringing all together

Some text

```html
<style>
.card {
  ...
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  transform: translateY(0) scale(1);
  transition: transform .25s ease, box-shadow .25s ease;
}

.card:hover {
  transform: translateY(-4px) scale(1.01);
  box-shadow: 0 10px 30px rgba(0,0,0,.12);
}
</style>
```


::right::

<style>
.card {
  cursor: pointer;
  height: auto;
  width: 250px;
  border-radius: 8px;
  padding: 16px;
  font-family: Noto, sans-serif;
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  transform: translateY(0) scale(1);
  transition: transform .25s ease, box-shadow .25s ease;
}

.card:hover {
  transform: translateY(-4px) scale(1.01);
  box-shadow: 0 10px 30px rgba(0,0,0,.12);
}

.card-image {
  background-image: url("./assets/images/flexbox/flex-wrap.svg");
  background-repeat: no-repeat;
  background-size: contain;
  height: 150px;
}

.card-image img {
  height: inherit;
}
</style>

<div style="display: flex; justify-content: center; width: 100%;">
  <div class="card">
    <div class="card-image">
    </div>
    <div class="card-header">
      <h3> Learn Flexbox </h3>
    </div>
    <div class="card-body">
      <p> Modernes Layout gestalten mit Flexbox. Erfahre mehr in diesem Beitrag </p>
    </div>
  </div>
</div>

