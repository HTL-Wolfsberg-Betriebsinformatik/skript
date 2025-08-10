# Farben in CSS

## Warum das wichtig ist
Farben bestimmen die **Ästhetik**, Einheiten bestimmen die **Größe und Skalierung**. Zusammen ermöglichen sie konsistente, gut lesbare und responsive Gestaltung.

---

## Farbwerte in CSS

### Benannte Farben

Einfach, aber begrenzt.

```css
color: red; 
background: navy;
```

### Hexadecimal

Weit verbreitet, optional mit Alpha (Transparenz).

```css
color: #ff0000;     /* Rot */
color: #f00;        /* Kurzform, Zusammenfassung der 2er Pärchen f = ff, 0 = 00, usw */
```

### RGB / RGBA

RGB steht für **Red-Green-Blue**, A steht für Alpha für Transparenz.

```css
color: rgb(255, 0, 0);
```

### HSL / HSLA

Hue (Farbton), Saturation (Sättigung), Lightness (Helligkeit) – oft intuitiver.

```css
color: hsl(0, 100%, 50%);          /* Rot */
```

## Transparenz

Optional kann Transparenz bei Farben angegeben werden. Dieser Wert wird **Alpha bzw Alpha-Kanal** genannt und liegt zwischen 0 (keine Transparenz) und 1 (volle Transparenz) im **rgba() und hsla()** Farbraum. In Hex liegt der Wert zwischen 00 und FF

```css
/* Rot mit 50% Transparenz */
color: #ff000080;
color: rgba(255,0,0,0.5); 
color: hsla(0, 100%, 50%, 0.5);  
```

!!! tip "Lesbarkeit"
    Hintergrund vs. Vordergrund: Achte auf Kontrast zwischen Textfarbe (inkl Alpha Wert) und Hintergrund.
