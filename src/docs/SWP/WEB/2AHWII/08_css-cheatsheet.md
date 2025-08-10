# 🎨 CSS Cheatsheet – Häufig verwendete Eigenschaften

## Box-Modell & Layout
| Eigenschaft        | Beschreibung                                  | Beispiel |
|-------------------|-----------------------------------------------|----------|
| `display`         | Anzeigeart (`block`, `inline`, `flex`, `grid`) | `display: flex;` |
| `width` / `height`| Breite/Höhe des Elements                       | `width: 200px;` |
| `max-width` / `min-width` | Begrenzung der Breite                  | `max-width: 800px;` |
| `margin`          | Außenabstand                                  | `margin: 20px;` |
| `padding`         | Innenabstand                                  | `padding: 10px;` |
| `border`          | Rahmen                                        | `border: 1px solid #000;` |
| `box-sizing`      | Berechnung von Breite/Höhe                     | `box-sizing: border-box;` |

---

## Farben & Hintergründe
| Eigenschaft          | Beschreibung                  | Beispiel |
|---------------------|-------------------------------|----------|
| `color`             | Textfarbe                     | `color: red;` |
| `background-color`  | Hintergrundfarbe               | `background-color: #f0f0f0;` |
| `background-image`  | Hintergrundbild                | `background-image: url(bg.png);` |
| `opacity`           | Transparenz (0–1)              | `opacity: 0.5;` |

---

## Schriftgestaltung
| Eigenschaft         | Beschreibung                  | Beispiel |
|--------------------|-------------------------------|----------|
| `font-family`      | Schriftart                    | `font-family: Arial, sans-serif;` |
| `font-size`        | Schriftgröße                  | `font-size: 16px;` |
| `font-weight`      | Schriftstärke                  | `font-weight: bold;` |
| `text-align`       | Textausrichtung                | `text-align: center;` |
| `line-height`      | Zeilenhöhe                     | `line-height: 1.5;` |
| `text-decoration`  | Textverzierung                 | `text-decoration: underline;` |

---

## Positionierung
| Eigenschaft     | Beschreibung                      | Beispiel |
|----------------|-----------------------------------|----------|
| `position`     | Positionierungsart (`static`, `relative`, `absolute`, `fixed`, `sticky`) | `position: absolute;` |
| `top` / `left` / `right` / `bottom` | Abstand vom jeweiligen Rand | `top: 10px; left: 20px;` |
| `z-index`      | Stapelreihenfolge                  | `z-index: 10;` |
| `float`        | Element links/rechts fließen lassen| `float: right;` |

---

## Flexbox
| Eigenschaft         | Beschreibung                 | Beispiel |
|--------------------|------------------------------|----------|
| `display: flex`    | Aktiviert Flexbox             | `display: flex;` |
| `flex-direction`   | Anordnung (Zeile/Spalte)      | `flex-direction: column;` |
| `justify-content`  | Horizontale Ausrichtung       | `justify-content: center;` |
| `align-items`      | Vertikale Ausrichtung         | `align-items: flex-start;` |
| `gap`              | Abstand zwischen Items        | `gap: 10px;` |

---

## Grid
| Eigenschaft                  | Beschreibung                        | Beispiel |
|------------------------------|-------------------------------------|----------|
| `display: grid`              | Aktiviert Grid Layout               | `display: grid;` |
| `grid-template-columns`      | Spaltenaufteilung                   | `grid-template-columns: 1fr 1fr;` |
| `grid-template-rows`         | Zeilenaufteilung                    | `grid-template-rows: auto 100px;` |
| `gap`                        | Abstand zwischen Zellen             | `gap: 20px;` |
| `grid-column` / `grid-row`   | Element-Position im Grid            | `grid-column: 1 / 3;` |

---

## Sonstiges
| Eigenschaft        | Beschreibung                  | Beispiel |
|-------------------|-------------------------------|----------|
| `cursor`          | Mauszeiger-Stil                | `cursor: pointer;` |
| `overflow`        | Verhalten bei Überlauf         | `overflow: hidden;` |
| `visibility`      | Sichtbarkeit                   | `visibility: hidden;` |
| `transition`      | Animations-Übergang            | `transition: all 0.3s ease;` |
| `transform`       | Transformation (Drehung, Skalierung) | `transform: rotate(45deg);` |