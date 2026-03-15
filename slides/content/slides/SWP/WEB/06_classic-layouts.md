---
theme: seriph
routerMode: hash
title: Klassische Layouts in CSS
info: |
  ## Klassische Layouts in CSS
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

# Klassische Layouts in CSS

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" columns="1" />

---

# Das Problem

HTML legt nur die Inhalte und deren Bedeutung fest – nicht, **wie sie angeordnet** werden.
Ohne CSS würden alle Elemente einfach **untereinander stehen**

<div style="background-color: lightblue; width: 200px; border-radius: 8px; padding: 8px; font-family: Verdana, sans-serif; margin: 8px;">
  <div>
    <h3>Learn HTML</h3>
  </div>
  <div>
    <p style="font-size: 12px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <a style="font-size: 14px; text-decoration: none; border-bottom-width: 0; background-color: white; padding: 4px; border-radius: 4px" href="#">Mehr lesen</a>
  </div>
</div>
<div style="background-color: lightblue; width: 200px; border-radius: 8px; padding: 8px; font-family: Verdana, sans-serif; margin: 8px;">
  <div>
    <h3>Learn CSS</h3>
  </div>
  <div>
    <p style="font-size: 12px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <a style="font-size: 14px; text-decoration: none; border-bottom-width: 0; background-color: white; padding: 4px; border-radius: 4px" href="#">Mehr lesen</a>
  </div>
</div>
<div style="background-color: lightblue; width: 200px; border-radius: 8px; padding: 8px; font-family: Verdana, sans-serif; margin: 8px;">
  <div>
    <h3>Learn JS</h3>
  </div>
  <div>
    <p style="font-size: 12px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <a style="font-size: 14px; text-decoration: none; border-bottom-width: 0; background-color: white; padding: 4px; border-radius: 4px" href="#">Mehr lesen</a>
  </div>
</div>

---

# Die Lösung: CSS Layouts

CSS-Layouts steuern die visuelle Anordnung von HTML-Elementen auf einer Seite.
Sie bestimmen, wie Elemente nebeneinander, untereinander oder überlagert dargestellt werden.

<br>

💡Dazu nutzt man vor allem das `display`-Attribut, das das Darstellungsverhalten eines Elements festlegt:

  <div style="display: inline-block; background-color: lightblue; width: 200px; border-radius: 8px; padding: 8px; font-family: Verdana, sans-serif; margin: 8px;">
    <div>
      <h3>Learn HTML</h3>
    </div>
    <div>
      <p style="font-size: 12px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      <a style="font-size: 14px; text-decoration: none; border-bottom-width: 0; background-color: white; padding: 4px; border-radius: 4px" href="#">Mehr lesen</a>
    </div>
  </div>
  <div style="display: inline-block; background-color: lightblue; width: 200px; border-radius: 8px; padding: 8px; font-family: Verdana, sans-serif; margin: 8px;">
    <div>
      <h3>Learn CSS</h3>
    </div>
    <div>
      <p style="font-size: 12px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      <a style="font-size: 14px; text-decoration: none; border-bottom-width: 0; background-color: white; padding: 4px; border-radius: 4px" href="#">Mehr lesen</a>
    </div>
  </div>
  <div style="display: inline-block; background-color: lightblue; width: 200px; border-radius: 8px; padding: 8px; font-family: Verdana, sans-serif; margin: 8px;">
    <div>
      <h3>Learn JS</h3>
    </div>
    <div>
      <p style="font-size: 12px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      <a style="font-size: 14px; text-decoration: none; border-bottom-width: 0; background-color: white; padding: 4px; border-radius: 4px" href="#">Mehr lesen</a>
    </div>
  </div>

<br>
<br>

> Hier wurde `display: inline-block` verwendet um eine horizontale Anordnung zu erzielen.

---

# Typische Werte für `display`

<Toc minDepth="2" maxDepth="2" columns="1" />



---

## `block`

<br>

- Das Element nimmt die **gesamte verfügbare Breite** ein.
- Beginnt **immer** in einer **neuen Zeile**.
- Höhe ergibt sich aus dem Inhalt.
- Breite und Höhe können mit CSS gesetzt werden (`width`, `height`).

<br>

**Beispiel:**  `<div>`, `<p>`, `<header>`, `<footer>`

```html
<div style="background-color: lightblue;"> <!-- display: block; ist der default Wert für ein div oder einem p Tag -->
 Das ist ein div mit einem Text
</div>
```

<br>
<div style="background-color: lightblue;">
 Das ist ein div mit einem Text
</div>

---

## `inline`

<br>

- Läuft **im Textfluss** mit — **kein Zeilenumbruch** davor oder danach.
- Nur so breit wie der Inhalt.
- `width`, `height`, `margin-top` und `margin-bottom` **wirken nicht**.

<br>

**Beispiele:** `<span>`, `<a>`, `<strong>`

```html
<p style="background-color: lightblue;"> 
  Das ist ein Paragraph <span style="color: red;">mit einem roten span Element</span> darin. 
</p>
```

<br>
<p style="background-color: lightblue;"> Das ist ein Paragraph <span style="color: red;">mit einem roten span Element</span> darin. </p>

---
layout: two-cols-header
layoutClass: gap-8
---

## `inline-block`

::left::

- **Kombiniert** Eigenschaften von `inline` und `block`.
- Steht **im Textfluss** (wie `inline`), aber **Breite und Höhe sind veränderbar** (wie `block`).
- Auch **Abstände** (`padding` und `margin`) **werden berücksichtigt**

**Beispiele:** Buttons oder Menüelemente nebeneinander


<style>
nav a {
  display: inline-block;
  padding: 8px 16px; /* funktioniert bei `inline` nicht */
  background: #3498db;
  color: white;
  text-decoration: none;
  border-radius: 6px;
  border-bottom-width: 0;
  margin: 20px 6px 0 0; /* funktioniert bei `inline` nicht */
  min-width: 100px;
  text-align: center;
}

nav a:hover {
  background: #2176bd;
  color: white;
}
</style>
<nav>
  <a href="#">Home</a>
  <a href="#">Über uns</a>
  <a href="#">Kontakt</a>
</nav>


::right::

```html
<style>
  nav a {
    display: inline-block;
    padding: 8px 16px; /* funktioniert */
    background: #3498db;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    margin: 20px 6px 0 0; /* funktioniert */
    min-width: 100px; /* funktioniert */
    text-align: center;
  }
  nav a:hover {
    background: #2176bd;
  }
</style>
<nav>
  <a href="#">Home</a>
  <a href="#">Über uns</a>
  <a href="#">Kontakt</a>
</nav>
```
---

## `none`

<br>

- Das Element wird **komplett ausgeblendet** – es belegt keinen Platz im Layout.
- Wird oft für Menüs oder modale Fenster verwendet, die per Javascript eingeblendet werden.

---

# Zusammenfassung

| Wert           | Beschreibung                                     | Beispiel               |
| -------------- | ------------------------------------------------ | ---------------------- |
| `block`        | Neues Blockelement, nimmt ganze Zeile ein        | `<div>`, `<p>`         |
| `inline`       | Läuft im Textfluss mit, kein Zeilenumbruch       | `<span>`, `<a>`        |
| `inline-block` | Kombination: inline + feste Größe                | Buttons, Icons         |
| `none`         | Unsichtbar, wird nicht gerendert                 | Elemente ausblenden    |

