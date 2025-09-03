
CSS bietet eine Vielzahl an Möglichkeiten, um **Hintergründe** für Elemente zu gestalten – von einfachen Farben bis zu komplexen Mustern und mehreren Hintergrundbildern.

## Hintergrundfarbe (`background-color`)

Legt die **Füllfarbe** eines Elements fest.

```css
div {
  background-color: lightblue;
}
```

- Akzeptiert Farbnamen (red), Hex-Werte (#ff0000), RGB(a) oder HSL(a)
- Standardwert: transparent

## Hintergrundbilder (`background-image`)

Fügt ein oder mehrere Bilder als Hintergrund hinzu.

```css
div {
  background-image: url("hintergrund.jpg");
}
```

- Pfad kann relativ (images/bg.png) oder absolut (https://...) sein.
- Mehrere Bilder: durch Komma getrennt → Vordergrund-Bild zuerst, dann darunter liegende:

```css
div {
  background-image: url("muster.png"), url("hintergrund.jpg");
}
```

## Wiederholung steuern (`background-repeat`)

Legt fest, ob und wie sich das Hintergrundbild wiederholt.

| Wert        | Bedeutung                                  |
| ----------- | ------------------------------------------ |
| `repeat`    | Wiederholt in X- und Y-Richtung (Standard) |
| `repeat-x`  | Nur horizontal wiederholen                 |
| `repeat-y`  | Nur vertikal wiederholen                   |
| `no-repeat` | Keine Wiederholung                         |

```css
div {
    background-repeat: no-repeat;
}
```

## Positionieren (`background-position`)

Steuert die Startposition des Hintergrundbilds.

```css
div {
  background-position: center center; /* horizontal / vertikal */
}
```

Mögliche Werte:

- Schlüsselwörter: left, center, right, top, bottom
- Pixelangaben: 20px 50px
- Prozente: 50% 100% (relativ zur Elementgröße)


## Hintergrundgröße (`background-size`)

Bestimmt, wie groß das Hintergrundbild angezeigt wird.

| Wert          | Bedeutung                                                     |
| ------------- | ------------------------------------------------------------- |
| `auto`        | Originalgröße (Standard)                                      |
| `cover`       | Bild füllt gesamten Bereich, Seitenverhältnis bleibt erhalten |
| `contain`     | Bild wird so groß wie möglich, ohne beschnitten zu werden     |
| `Breite Höhe` | Feste Werte in `px`, `%`, etc.                                |

```css
div {
  background-size: cover;
}
```


## Fixieren oder mitscrollen (`background-attachment`)

Legt fest, ob der Hintergrund beim Scrollen fixiert bleibt.

| Wert     | Bedeutung                               |
| -------- | --------------------------------------- |
| `scroll` | Scrollt mit dem Inhalt (Standard)       |
| `fixed`  | Bleibt an der Viewport-Position fixiert |
| `local`  | Scrollt mit dem Inhalt **des Elements** |

```css
div {
  background-attachment: fixed;
}
```

## CSS-Gradienten

Hintergründe müssen nicht immer Bilder sein – CSS bietet Verläufe ohne externe Dateien:

**Linearer Verlauf:**

```css
div {
  background: linear-gradient(to right, red, orange, yellow);
}
```

**Radialer Verlauf:**

```css
div {
  background: radial-gradient(circle, white, blue);
}
```

**Wiederholender Verlauf:**

```css
div {
  background: repeating-linear-gradient(45deg, #ccc, #ccc 10px, #fff 10px, #fff 20px);
}
```