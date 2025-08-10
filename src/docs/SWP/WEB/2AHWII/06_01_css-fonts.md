# Schriftgestaltung in CSS

## Grundidee
CSS erlaubt es, **Schriftarten**, **Größen**, **Farben** und weitere typografische Eigenschaften einer Webseite festzulegen.  
So lässt sich das Aussehen von Text an das gewünschte Design und die Lesbarkeit anpassen.

---

## Schriftarten: Serif vs. Sans-Serif

### Serif-Schriftarten
- **Merkmale:** kleine Linien („Füßchen“) an den Buchstabenenden  
- **Wirkung:** traditionell, seriös, gut lesbar im Druck  
- **Beispiele:** Times New Roman, Georgia

```css
p {
  font-family: "Times New Roman", serif;
}
```

### Sans-Serif-Schriftarten

- **Merkmale:** keine Linien an den Buchstabenenden
- **Wirkung:** modern, klar, gut lesbar am Bildschirm

- **Beispiele:** Arial, Helvetica, Verdana

```css
p {
  font-family: Arial, sans-serif;
}
```

!!! hint "Hinweis"
    Am Bildschirm wirken Sans-Serif-Schriften oft klarer, im Druck sind Serif-Schriften angenehmer zu lesen.


## Fallback-Schriften

Man gibt mehrere Schriften an, getrennt durch Kommas.
Der Browser nimmt die erste verfügbare.

```css
body {
  font-family: "Segoe UI", Arial, sans-serif;
}
```

## Einheiten

- px → feste Pixelgröße (z. B. 16px)
- em → relativ zur Schriftgröße des Elternelements (z. B. 1.2em)
- rem → relativ zur Schriftgröße des <html>-Elements (z. B. 1rem)
- % → prozentual relativ (z. B. 120%)

## Beispiel

=== "HTML"
    ```html
    <p style="font-family: Georgia, serif; font-size: 18px;">Dies ist ein Serif-Text</p>
    <p style="font-family: Arial, sans-serif; font-size: 24px;">Dies ist ein Sans-Serif-Text</p>
    ```
=== "Ausgabe"
    <p style="font-family: Georgia, serif; font-size: 18px;">Dies ist ein Serif-Text</p>
    <p style="font-family: Arial, sans-serif; font-size: 24px;">Dies ist ein Sans-Serif-Text</p>

## Wichtige CSS-Eigenschaften für Text

| Eigenschaft       | Beschreibung                                      | Beispiel |
|------------------|---------------------------------------------------|----------|
| `font-family`    | Schriftart                                         | `font-family: Arial, sans-serif;` |
| `font-size`      | Schriftgröße                                       | `font-size: 16px;` |
| `font-weight`    | Schriftstärke (`normal`, `bold`, Zahlen 100–900)   | `font-weight: bold;` |
| `font-style`     | Schriftstil (`normal`, `italic`, `oblique`)        | `font-style: italic;` |
| `color`          | Textfarbe                                          | `color: #333;` |
| `line-height`    | Zeilenhöhe (Abstand zwischen Zeilen)               | `line-height: 1.5;` |
| `text-align`     | Ausrichtung (`left`, `center`, `right`, `justify`) | `text-align: center;` |
| `text-decoration`| Verzierung (`none`, `underline`, `line-through`)   | `text-decoration: underline;` |
| `letter-spacing` | Abstand zwischen Buchstaben                        | `letter-spacing: 2px;` |
| `word-spacing`   | Abstand zwischen Wörtern                           | `word-spacing: 4px;` |