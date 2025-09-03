# Einheiten in CSS

## Absolute Einheiten

|          Einheit | Bedeutung                             | Beispiel        | Praxis            |
| ---------------: | ------------------------------------- | --------------- | ----------------- |
|             `px` | Pixel (Geräte-unabhängig im CSS-Sinn) | `width: 200px;` | Standard fürs Web |
| `cm`, `mm`, `in` | physikalisch                          | selten im Web   | Print             |
|       `pt`, `pc` | typografisch                          | selten im Web   | Print             |


## Relative Einheiten (empfohlen fürs Web)

In CSS können Größen (z. B. Schriftgrößen, Abstände, Breiten) **absolut** oder **relativ** angegeben werden.  
**Relative Einheiten** passen sich an den Kontext oder andere Werte an – ideal für **responsives Design**.

**Vorteile relativer Einheiten:**

- **Flexibel** – passen sich automatisch an unterschiedliche Geräte und Bildschirmgrößen an.
- **Zukunftssicher** – Änderungen an einem Basiswert wirken sich automatisch auf abhängige Elemente aus.
- **Barrierefrei** – besser für Nutzer, die im Browser eigene Zoom- oder Schriftgrößeneinstellungen verwenden.

### `em` – Relativ zur **Schriftgröße des Elternelements**

- `1em` = 100 % der Schriftgröße des Elements, auf das es angewendet wird.

Beispiel:
```css
body { font-size: 16px; }
p { font-size: 1.5em; } /* = 24px */
```
!!! danger "Achtung"
    Verschachtelte em-Werte können sich multiplizieren und schnell sehr groß oder klein werden.


### `rem` – Relativ zur Schriftgröße des `<html>`-Elements

- `1rem` = 100 % der Schriftgröße des Wurzelelements (html), egal wie tief verschachtelt.

Beispiel:
```css
html { font-size: 16px; }
p { font-size: 1.5rem; } /* = 24px */
```

!!! success "Vorteil"
    Konsistenter als em, weil unabhängig von verschachtelten Elementen.

### `%` - Relativ zur Größe des Elternelements

- Wird oft bei **Breiten, Höhen und Abständen** genutzt

Beispiel:
```css
div {
  width: 50%; /* halbe Breite des übergeordneten Elements */
}
```

### `vw` & `vh` – Relativ zur Viewport-Größe

- 1vw = 1 % der Breite des Browserfensters (Viewport).
- 1vh = 1 % der Höhe des Browserfensters.

Beispiel:

```css
div {
  height: 100vh; /* volle Höhe des Fensters */
}
```

### `vmin` & `vmax`

- vmin = kleinerer Wert aus vw und vh.
- vmax = größerer Wert aus vw und vh.

Beispiel:

```css
h1 {
  font-size: 5vmin; /* passt sich kleinster Viewport-Seite an */
}
```

### `ch`

- `1ch` = Breite eines Buchstabens (Character). 

Beispiel:

```css
p {
  width: 60ch; 
}
```

!!! hint "Hinweis"
    - Wenn die Buchstaben der Schriftart unterschiedliche Breite haben, wird die "0" als Referenzbreite genommen.
    - 60 Buchstaben pro Zeile verbessern die Lesbarkeit laut Studien deutlich. 

### Zusammenfassung

|        Einheit | Relativ zu                     | Beispiel             | Nutzung                          |
| -------------: | ------------------------------ | -------------------- | -------------------------------- |
|            `%` | Elternelement                  | `width: 100%;`       | Flexible Breite/Höhe             |
|           `em` | Schriftgrad des Elternelements | `padding: 1.5em;`    | Abstände **relativ** zur Schrift |
|          `rem` | Root-Schriftgrad (`html`)      | `font-size: 1rem;`   | Konsistente Typo/Spacing         |
|           `vw` | 1% der Viewportbreite          | `width: 50vw;`       | Vollbreite-Bereiche              |
|           `vh` | 1% der Viewporthöhe            | `min-height: 100vh;` | Vollhöhe-Abschnitte              |
| `vmin`, `vmax` | min/max(vw, vh)                | `font-size: 3vmin;`  | Skalen an Viewport               |
|           `ch` | Breite der “0” der Schrift     | `max-width: 60ch;`   | Zeilenlänge steuern              |


## Zeit, Winkel & Auflösung

| Typ       | Einheit(en)          | Beispiel                   |
| --------- | -------------------- | -------------------------- |
| Zeit      | `s`, `ms`            | `transition: 300ms;`       |
| Winkel    | `deg`, `rad`, `turn` | `rotate: 0.5turn;`         |
| Auflösung | `dpi`, `dppx`        | `image-resolution: 2dppx;` |


## Best Practices & Pattern

```css
html { font-size: 16px; }     /* Baseline */
body { font-size: 1rem; }     /* 16px */
h1   { font-size: 2rem; }     /* 16px * 2 = 32px */
p    { line-height: 1.6; }    /* Zeilenabstand: 16px × 1.6 = 25,6px */
```

