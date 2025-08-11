Mit **CSS Transitions** lassen sich **weiche Zustandswechsel** (z. B. Farbe, Größe, Position) animieren – ohne JavaScript.  
Typische Auslöser sind **Hover** (`:hover`), **Fokus** (`:focus`/`:focus-visible`) oder **aktive Zustände** (`:active`).


## CSS-Pseudoklassen für Interaktionen

**Pseudoklassen** in CSS ermöglichen es, Elemente in einem **bestimmten Zustand** anzusprechen, ohne dass im HTML ein zusätzliches Attribut oder eine Klasse nötig ist.  
Sie werden mit einem Doppelpunkt `:` nach dem Selektor geschrieben.

### `:hover`

- Wird aktiviert, **wenn der Mauszeiger über einem Element schwebt**.
- Typischer Einsatz: Farbwechsel, Hervorhebung, Animation starten.

```css
button:hover {
  background-color: royalblue;
}
```

### `:focus`

- Aktiv, wenn ein Element den Eingabefokus hat – z. B. durch Anklicken oder Tab-Navigation.
- Wichtig für Formularelemente und Barrierefreiheit.

```css
input:focus {
  outline: 2px solid orange;
}
```

### `:focus-visible`

- Ähnlich wie :focus, aber nur sichtbar, wenn der Fokus nicht mit der Maus, sondern z. B. mit der Tastatur gesetzt wurde.
- Verhindert unnötige Fokusrahmen bei Mausklicks, bleibt aber zugänglich für Tastaturnutzer.

```css
button:focus-visible {
  outline: 3px solid limegreen;
}
```

!!! tip "Tipp"
    `:focus-visible` ist moderner und nutzerfreundlicher als reines `:focus`.


### `:active`

- Aktiv, während ein Element gedrückt wird (z. B. Maustaste noch nicht losgelassen oder Finger noch auf Touchscreen).
- Wird oft für „Klick-Feedback“ genutzt.

```css
button:active {
  transform: translateY(2px); /* wirkt wie ein gedrückter Button */
}
```

### Zusammenfassung

| Pseudoklasse     | Wann aktiv?                       | Typische Anwendung                          |
| ---------------- | --------------------------------- | ------------------------------------------- |
| `:hover`         | Mauszeiger über Element           | Farbwechsel, Animation starten              |
| `:focus`         | Element hat Eingabefokus          | Fokusrahmen für Eingabe                     |
| `:focus-visible` | Fokus sichtbar für Tastaturnutzer | Zugängliche Navigation ohne störende Ränder |
| `:active`        | Während der Klick/Tap andauert    | Visuelles Klick-Feedback                    |

!!! tip "Tipp"
    Bei Touch-Geräten wird `:hover` oft nur beim Tippen ausgelöst oder gar nicht unterstützt. Deshalb `:focus` und `:active` für Interaktionen mitdenken.

### Beispiele

=== "HTML"
    ```html
    --8<-- "assets/html/effects/pseudo-classes.html"
    ```
=== "CSS"
    ```css
    --8<-- "assets/html/effects/pseudo-classes.css"
    ```
=== "Ausgabe"
    <iframe src="/assets/html/effects/pseudo-classes.html" width="100%" height="700" style="border:1px solid #ccc; border-radius:8px;"></iframe>

---

## Schatteneffekte

Schatten können in CSS verwendet werden, um Elemente **plastischer** wirken zu lassen.  
Es gibt zwei wichtige Eigenschaften:

### `box-shadow` – Schatten für Boxen

Wendet einen oder mehrere **Schatten auf das gesamte Element** (inklusive `padding` und `border`) an.

**Syntax:**

```css
box-shadow: offset-x offset-y blur-radius spread-radius color;
```

| Parameter       | Beschreibung                                                       |
| --------------- | ------------------------------------------------------------------ |
| `offset-x`      | Horizontale Verschiebung (+ nach rechts, – nach links)             |
| `offset-y`      | Vertikale Verschiebung (+ nach unten, – nach oben)                 |
| `blur-radius`   | Weichzeichnungsradius (optional, Standard = 0)                     |
| `spread-radius` | Größe des Schattens ausdehnen/verkleinern (optional, Standard = 0) |
| `color`         | Farbe des Schattens (auch mit Transparenz z. B. `rgba`)            |

=== "HTML"
    ```html
    <div style="width: 200px; height: 50px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);"></div>
    ```
=== "Ausgabe"
    <div style="width: 200px; height: 50px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);"></div>


**Mehrere Schatten kombinieren:**

=== "HTML"
    ```html
    <div style="width: 200px; height: 50px; box-shadow: 0 2px 4px rgba(0,0,0,0.2), 0 6px 12px rgba(0,0,0,0.15);"></div>
    ```
=== "Ausgabe"
    <div style="width: 200px; height: 50px; box-shadow: 0 2px 4px rgba(0,0,0,0.2), 0 6px 12px rgba(0,0,0,0.15);"></div>

> Zwei Schattenebenen erzeugen mehr Tiefe

---

### `text-shadow` - Shatten für Text

Erzeugt einen Schatten hinter Text.

**Syntax:**

```css
text-shadow: offset-x offset-y blur-radius color;
```
> Kein spread-radius wie bei box-shadow.

=== "HTML"
    ```html
    <h3 style="text-shadow: 2px 2px 6px rgba(0,0,0,0.4);">Schattenüberschrift</h3>
    ```
=== "Ausgabe"
    <h3 style="text-shadow: 2px 2px 6px rgba(0,0,0,0.4);">Schattenüberschrift</h3>

> Schwarzer, halbtransparenter Textschatten mit Weichzeichnung

!!! tip "Tipps für den Einsatz"
    - Weniger ist oft mehr – zu starke Schatten wirken schnell unruhig.
    - Transparenz (rgba) sorgt für natürlichere Effekte.
    - Nutzen Sie Hover-Effekte mit Schatten, um interaktive Elemente hervorzuheben

## `transition`

### Einzelwerte

```css
button:hover {
  transition-property: background-color; /* welche Eigenschaft(en) */
  transition-duration: .3s;              /* Dauer */
  transition-timing-function: ease;      /* Verlaufskurve */
  transition-delay: 0s;                  /* Startverzögerung */
}
```

### Kurzschreibweise

```css
button:hover {
  transition: background-color 3s ease .05s;
  /* property   duration   timing   delay */
}
```



### Mehrere Eigenschaften

In diesem Fall wird transformiert und die Durchsichtigkeit geändert

```css
button:hover {
  transition: transform .25s ease, opacity .25s linear;
}
```

### Beispiele

#### `color` und `background-color`

=== "HTML"
    ```html
    --8<-- "assets/html/effects/transition-color.html"
    ```
=== "CSS"
    ```css
    --8<-- "assets/html/effects/transition-color.css"
    ```
=== "Ausgabe"
    <iframe src="/assets/html/effects/transition-color.html" width="100%" height="400" style="border:1px solid #ccc; border-radius:8px;"></iframe>


#### `transform`

**Interactive Buttons:**

=== "HTML"
    ```html
    --8<-- "assets/html/effects/transition-transform.html"
    ```
=== "CSS"
    ```css
    --8<-- "assets/html/effects/transition-transform.css"
    ```
=== "Ausgabe"
    <iframe src="/assets/html/effects/transition-transform.html" width="100%" height="400" style="border:1px solid #ccc; border-radius:8px;"></iframe>

**Unterstreichung animieren:**

=== "HTML"
    ```html
    --8<-- "assets/html/effects/animated-underline.html"
    ```
=== "CSS"
    ```css
    --8<-- "assets/html/effects/animated-underline.css"
    ```
=== "Ausgabe"
    <iframe src="/assets/html/effects/animated-underline.html" width="100%" height="400" style="border:1px solid #ccc; border-radius:8px;"></iframe>

**Hervorgehobene Cards:**

=== "HTML"
    ```html
    --8<-- "assets/html/effects/elevate-card.html"
    ```
=== "CSS"
    ```css
    --8<-- "assets/html/effects/elevate-card.css"
    ```
=== "Ausgabe"
    <iframe src="/assets/html/effects/elevate-card.html" width="100%" height="400" style="border:1px solid #ccc; border-radius:8px;"></iframe>


### Timing Funktionen (Bewegungskurven)

| Wert                        | Verhalten                              |
| --------------------------- | -------------------------------------- |
| `linear`                    | konstant                               |
| `ease`                      | schnell → langsam (Standard)           |
| `ease-in`                   | startet langsam                        |
| `ease-out`                  | endet langsam                          |
| `ease-in-out`               | langsam -> schnell -> langsam          |
| `cubic-bezier(x1,y1,x2,y2)` | eigene Kurve                           |


!!! tip "Tipps für den Einsatz"
    - Nur GPU‑freundliche Eigenschaften animieren: `transform`, `opacity`.
      (Vermeide permanente Animationen von `width`/`height`/`left`/`top` → Layout-Reflow)
    - Start- und Zielzustand definieren: Das Element braucht einen „Ausgangszustand“, sonst sieht man keinen Übergang.
    - Dauer kurz halten: `150–300 ms` für UI‑Reaktionen wirken direkt, aber nicht hektisch.
    - Zugänglichkeit: Auch Tastaturfokus (`:focus-visible`) wie Hover behandeln.