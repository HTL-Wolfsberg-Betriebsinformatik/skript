# Einführung in CSS (Cascading Style Sheets)

## Warum brauchen wir CSS?

Mit HTML können Inhalte strukturiert werden, aber ohne CSS sehen alle Webseiten gleich aus. **CSS ist für das Design zuständig**: Farben, Schriftarten, Abstände, Layouts und vieles mehr.

## Einbindungsmöglichkeiten von CSS

### 1. Inline-Stil
```html
<p style="color: red;">Roter Text</p>
```

### 2. Im `<style>`-Tag im `<head>`
```html
<head>
  <style>
    body { background-color: lightyellow; }
    h1 { color: blue; }
  </style>
</head>
```

### 3. Externe CSS-Datei (empfohlen)
```html
<link rel="stylesheet" href="style.css">
```
Inhalt von `style.css`:
```css
body {
  font-family: Arial, sans-serif;
  background-color: #f0f0f0;
}
h1 {
  color: darkgreen;
}
```

## Grundsyntax von CSS

```css
selektor {
  eigenschaft: wert;
}
```
Beispiel:
```css
p {
  color: gray;
  font-size: 16px;
}
```

## Wichtige CSS-Eigenschaften

| Eigenschaft        | Beschreibung                  |
|-------------------|-------------------------------|
| `color`           | Textfarbe                     |
| `background-color`| Hintergrundfarbe              |
| `font-size`       | Schriftgröße                  |
| `padding`         | Innenabstand                  |
| `margin`          | Außenabstand                  |
| `border`          | Rahmen                        |
| `text-align`      | Textausrichtung               |

## CSS-Selektoren

CSS-Selektoren bestimmen, **welche HTML-Elemente** von einer Style-Regel betroffen sind. Es gibt verschiedene Typen von Selektoren mit unterschiedlicher Genauigkeit und Verwendung:

### Elementselektor
Wendet Styles auf **alle Elemente eines bestimmten Typs** an.

```css
p {
  color: gray;
}
```
> Gilt für alle `<p>`-Elemente

### Klassenselektor
Wendet Styles auf alle Elemente mit einem bestimmten **class**-Attribut an.

```css
.info {
  background-color: #e0f7fa;
  padding: 10px;
}
```
```html
<p class="info">Hinweistext</p>
```
> Klassennamen beginnen in CSS mit einem Punkt `.`

### ID-Selektor
Wendet Styles auf **ein einzelnes Element** mit einer bestimmten `id` an.

```css
#hauptbereich {
  border: 2px solid black;
}
```

```html
<p id="hauptbereich">Startinhalt</p>
```
> IDs beginnen mit `#` und dürfen nur einmal pro Seite vergeben werden

### Verschachtelte Selektoren
Selektoren können **kombiniert** werden:

```css
p span {
  color: darkblue;
}
```
> Gilt für `<span>`-Tags **innerhalb** eines `<p>`-Elements

!!! info "`<span>` Tag"

    Der <span>-Tag in HTML ist ein generisches Inline-Element, das keine eigene Bedeutung oder Darstellung hat – er dient ausschließlich dazu, einen Teil eines Textes oder Inhaltes zu markieren, damit man ihn mit z.B. CSS gezielt gestalten oder verarbeiten kann.

### Mehrfachselektor
Eine Regel für **mehrere Elemente** gleichzeitig:

```css
h1, h2, h3 {
  font-family: 'Verdana';
}
```
> Gilt für alle drei Überschriftstypen

### Pseudoklassen
Erlauben Style-Verhalten für bestimmte Zustände:

```css
a:hover {
  color: red;
  text-decoration: underline;
}
```
> Gilt, wenn Mauszeiger über einem Link ist

## Beispiel: HTML mit externer CSS-Datei

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Mit CSS gestalten</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <h1>Hallo!</h1>
    <p>Diese Seite ist mit CSS gestaltet.</p>
  </body>
</html>
```
