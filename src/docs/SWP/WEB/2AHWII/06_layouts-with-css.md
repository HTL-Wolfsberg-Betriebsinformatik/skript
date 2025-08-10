Die `display`-Eigenschaft legt fest, **wie ein HTML-Element dargestellt wird**. Sie ist entscheidend für das Layout.

**Häufige Werte:**

| Wert             | Beschreibung                                                                 |
|------------------|------------------------------------------------------------------------------|
| `block`          | Element belegt die gesamte Breite (z. B. `<div>`, `<p>`)                      |
| `inline`         | Element im Fließtext, ohne Zeilenumbruch (z. B. `<span>`, `<a>`)              |
| `inline-block`   | Wie `inline`, aber mit definierbarer Breite und Höhe                         |
| `none`           | Element wird **nicht angezeigt** (aus dem Layout entfernt)                    |
| `flex`           | Aktiviert **Flexbox-Layout** (nur mit Container sinnvoll)                     |
| `grid`           | Aktiviert **CSS Grid Layout**                                                 |


## `inline`
- Element **fügt sich in den Textfluss ein**
- **Breite/Höhe nicht direkt änderbar**

=== "HTML Code"
    ```html
    <span style="display: inline; width: 200px; background: lightblue;">Inline</span>
    ```
    
=== "Ausgabe"
    <span style="display: inline; width: 200px; background: lightblue;">Inline</span>

> `width` wird **ignoriert**, weil `inline`-Elemente sich dem Inhalt anpassen.

## `inline-block`
- Bleibt **im Textfluss**, aber erlaubt **Breite und Höhe**

=== "HTML Code"
    ```html
    <span style="display: inline-block; width: 200px; background: lightblue;">Inline</span>
    ```

=== "Ausgabe"
    <span style="display: inline-block; width: 200px; background: lightblue;">Inline</span>
> Jetzt wird die feste Breite berücksichtigt, obwohl es inline steht.


## Flexbox (Flexible Box Layout)

Flexbox ist ideal, um **einzelne Zeilen oder Spalten** flexibel zu gestalten.

**Beispiel:**

=== "HTML Code"
    ```html
    <div style="display: flex;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: flex;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>


### Eigenschaften von Flexbox:

Flexbox ist besonders nützlich für einzeilige oder einspaltige Layouts. Hier sind die wichtigsten Eigenschaften, die man kennen sollte:

### `display: flex`
Aktiviert den Flexbox-Modus für das Container-Element.

### `flex-direction`
Legt fest, ob die Flex-Items in einer **Zeile** oder **Spalte** angeordnet werden:
```css
flex-direction: row;      /* horizontal, Standard */
flex-direction: column;   /* vertikal */
```

=== "HTML Code"
    ```html
    <div style="display: flex; flex-direction: column;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: flex; flex-direction: column;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>

### `justify-content`
Bestimmt die **horizontale Ausrichtung** der Flex-Items innerhalb des Containers:
```css
justify-content: flex-start;    /* linksbündig */
justify-content: center;        /* zentriert */
justify-content: space-between; /* gleichmäßiger Abstand */
```

=== "HTML Code"
    ```html
    <div style="display: flex; justify-content: center;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>
    <div style="display: flex; justify-content: space-between;">
      <div style="background-color: green">Box 4</div>
      <div style="background-color: purple">Box 5</div>
      <div style="background-color: pink">Box 6</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: flex; justify-content: center;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>
    <div style="display: flex; justify-content: space-between;">
      <div style="background-color: green">Box 4</div>
      <div style="background-color: purple">Box 5</div>
      <div style="background-color: pink">Box 6</div>
    </div>


### `align-items`
Bestimmt die **vertikale Ausrichtung** (bei `flex-direction: row`):
```css
align-items: stretch;     /* Standard: füllt Höhe aus */
align-items: center;       /* vertikal zentriert */
align-items: flex-start;   /* obenbündig */
```

=== "HTML Code"
    ```html
    <div style="display: flex; align-items: stretch; width: 100%; height: 100px; border:2px solid;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>
    <div style="display: flex; align-items: center; width: 100%; height: 100px; border:2px solid;">
      <div style="background-color: green">Box 4</div>
      <div style="background-color: purple">Box 5</div>
      <div style="background-color: pink">Box 6</div>
    </div>
    <div style="display: flex; align-items: flex-start; width: 100%; height: 100px; border:2px solid;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: flex; align-items: stretch; width: 100%; height: 100px; border:2px solid;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>
    <div style="display: flex; align-items: center; width: 100%; height: 100px; border:2px solid;">
      <div style="background-color: green">Box 4</div>
      <div style="background-color: purple">Box 5</div>
      <div style="background-color: pink">Box 6</div>
    </div>
    <div style="display: flex; align-items: flex-start; width: 100%; height: 100px; border:2px solid;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>

### `gap`
Abstand zwischen den Flex-Items:
```css
gap: 10px;
```
> Fügt gleichmäßigen Zwischenraum zwischen den Elementen ein.

=== "HTML Code"
    ```html
    <div style="display: flex; gap: 10px;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: flex; gap: 10px;">
      <div style="background-color: red">Box 1</div>
      <div style="background-color: blue">Box 2</div>
      <div style="background-color: yellow">Box 3</div>
    </div>

### `flex-wrap`
Erlaubt das Umbrechen der Items, wenn der Platz nicht reicht:
```css
flex-wrap: wrap;
```
=== "HTML Code"
    ```html
    <div style="display: flex;">
      <div style="background-color: red">Very long content of Box 1</div>
      <div style="background-color: blue">Very long content of Box 2</div>
      <div style="background-color: yellow">Very long content of Box 3</div>
      <div style="background-color: green">Very long content of Box 4</div>
      <div style="background-color: cyan">Very long content of Box 5</div>
      <div style="background-color: purple">Very long content of Box 6</div>
    </div>
    <br />
    <div style="display: flex; flex-wrap: wrap;">
      <div style="background-color: red">Very long content of Box 1</div>
      <div style="background-color: blue">Very long content of Box 2</div>
      <div style="background-color: yellow">Very long content of Box 3</div>
      <div style="background-color: green">Very long content of Box 4</div>
      <div style="background-color: cyan">Very long content of Box 5</div>
      <div style="background-color: purple">Very long content of Box 6</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: flex;">
      <div style="background-color: red">Very long content of Box 1</div>
      <div style="background-color: blue">Very long content of Box 2</div>
      <div style="background-color: yellow">Very long content of Box 3</div>
      <div style="background-color: green">Very long content of Box 4</div>
      <div style="background-color: cyan">Very long content of Box 5</div>
      <div style="background-color: purple">Very long content of Box 6</div>
    </div>
    <br />
    <div style="display: flex; flex-wrap: wrap;">
      <div style="background-color: red">Very long content of Box 1</div>
      <div style="background-color: blue">Very long content of Box 2</div>
      <div style="background-color: yellow">Very long content of Box 3</div>
      <div style="background-color: green">Very long content of Box 4</div>
      <div style="background-color: cyan">Very long content of Box 5</div>
      <div style="background-color: purple">Very long content of Box 6</div>
    </div>


### Zusammenfassung

| Eigenschaft         | Wirkung                             |
|---------------------|--------------------------------------|
| `display: flex`     | Aktiviert Flexbox                   |
| `flex-direction`    | Richtung: `row` oder `column`       |
| `justify-content`   | Horizontale Ausrichtung             |
| `align-items`       | Vertikale Ausrichtung               |
| `gap`               | Abstand zwischen Elementen          |

---

## Grid Layout

CSS Grid ist ein leistungsfähiges System für **zweidimensionale Layouts** (Zeilen + Spalten).

**Beispiel:**

=== "HTML"
    ```html
    <div style="display: grid; grid-template-columns: 1fr 1fr;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: grid; grid-template-columns: 1fr 1fr;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>

### Eigenschaften von Grid

#### `grid-template-columns`

Das wichtigste Attribut für das Grid-Layout ist `grid-template-columns`. Es definiert, wie viele **Spalten** vorhanden sind und **wie breit** sie sein sollen.

```css
display: grid;
grid-template-columns: 200px 1fr 2fr;
```

- `200px`: fixe Breite für die erste Spalte
- `1fr`: eine „flexible Einheit“ (1 Teil vom verbleibenden Platz)
- `2fr`: doppelt so viel Platz wie `1fr`

**Beispiele `grid-template-columns`:**

**Drei gleich breite Spalten:**

=== "HTML"
    ```html
    <div style="display: grid; grid-template-columns: 1fr 1fr 1fr;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: grid; grid-template-columns: 1fr 1fr 1fr;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>

!!! info "Kurzschreibweise"
    ```css
    grid-template-columns: repeat(3, 1fr);
    ```

**Erste Spalte 1/3 und Zweite Spalte 2/3:**

=== "HTML"
    ```html
    <div style="display: grid; grid-template-columns: 1fr 2fr;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: grid; grid-template-columns: 1fr 2fr;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>


**`auto`: Spalte so breit wie der Inhalt:**

=== "HTML"
    ```html
    <div style="display: grid; grid-template-columns: 1fr 2fr auto;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: grid; grid-template-columns: 1fr 2fr auto;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>


**Erste Spalte fix, zweite so breit wie Inhalt, dritte nimmt restlichen Platz:**

=== "HTML"
    ```html
    <div style="display: grid; grid-template-columns: 100px auto 2fr;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
      <div style="background-color: purple">5 longer content</div>
      <div style="background-color: pink">6</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: grid; grid-template-columns: 100px auto 2fr;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
      <div style="background-color: purple">5 longer content</div>
      <div style="background-color: pink">6</div>
    </div>

**Weitere Einheiten:**

- `px`: fixe Pixelgröße
- `%`: Prozent des Containers
- `fr`: Bruchteil des verbleibenden Platzes
- `auto`: so groß wie nötig

| Eigenschaft                  | Wirkung                                 |
|------------------------------|------------------------------------------|
| `display: grid`              | Aktiviert Grid Layout                    |
| `grid-template-columns`      | Spaltenanzahl und -breite                |
| `grid-template-rows`         | Zeilenanzahl (optional)                 |
| `gap`                        | Abstand zwischen Zellen                  |
| `grid-column` / `grid-row`   | Platzierung einzelner Elemente          |

#### `gap`

Bestimmt den **Abstand zwischen den Zellen** in einem Grid (Spalten und Zeilen).


```css
gap: 20px; /* Fügt einen gleichmäßigen Abstand zwischen allen Grid-Zellen ein */
gap: 10px 30px; /* 10 px Zeilenabstand, 30 px Spaltenabstand: */
```

=== "HTML"
    ```html
    <div style="display: grid; grid-template-columns: 100px auto 2fr; gap: 20px;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px;">
      <div style="background-color: red">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow">3</div>
      <div style="background-color: green">4</div>
    </div>

#### `grid-template-rows`
Definiert die **Höhen der Zeilen** analog zu `grid-template-columns`:

```css
grid-template-rows: 100px auto 1fr;
```

- `100px`: fixe Höhe für erste Zeile
- `auto`: so hoch wie der Inhalt
- `1fr`: nimmt restliche Höhe ein

#### `grid-column` und `grid-row`
Bestimmt, wo sich ein Element im Raster befindet – z. B. über mehrere Spalten:

```css
.item1 {
  /* Das Element nimmt Spalte 1 und 2 ein (bis aber exklusive 3) */
  grid-column: 1 / 3;
  
  /* Das Element nimmt Zeile 1 ein (bis aber exklusive 2) */
  grid-row: 1 / 2;
}
```

=== "HTML"
    ```html
    <div style="display: grid; grid-template-columns: repeat(3, 1fr);">
      <div style="background-color: red; grid-column: 1 / 3;">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow; grid-column: 2 / 4;">3</div>
      <div style="background-color: green; grid-row: 3 / 5;">4</div>
      <div style="background-color: purple; grid-column: 3 / 4;">5</div>
      <div style="background-color: pink; grid-column: 2 / 3;">6</div>
    </div>
    ```
=== "Ausgabe"
    <div style="display: grid; grid-template-columns: repeat(3, 1fr);">
      <div style="background-color: red; grid-column: 1 / 3;">1</div>
      <div style="background-color: blue">2</div>
      <div style="background-color: yellow; grid-column: 2 / 4;">3</div>
      <div style="background-color: green; grid-row: 3 / 5;">4</div>
      <div style="background-color: purple; grid-column: 3 / 4;">5</div>
      <div style="background-color: pink; grid-column: 2 / 3;">6</div>
    </div>