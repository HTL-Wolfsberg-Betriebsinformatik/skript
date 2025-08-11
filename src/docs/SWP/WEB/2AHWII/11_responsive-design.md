Responsive Design sorgt dafür, dass Webseiten **auf allen Geräten** (Smartphone, Tablet, Desktop) **gut aussehen und benutzbar** sind.

## Das `<meta name="viewport">`-Tag

Standardmäßig rendern mobile Browser Seiten so, als wären sie **breiter** (meist 980px) und skalieren sie dann herunter.  
Damit die Darstellung sich **am echten Bildschirmmaß** orientiert, braucht man im `<head>` folgendes Tag:

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

- `width=device-width` → passt die Seitenbreite an die Bildschirmbreite an
- `initial-scale=1.0` → Start-Zoomstufe (kein automatisches Hinein-/Herauszoomen)

!!! info "Info"
    Ohne dieses Tag sehen viele Layouts auf Smartphones zu klein oder verzerrt aus.


## Media Queries (`@media`)

Media Queries ermöglichen es, CSS-Regeln nur für bestimmte Bildschirmgrößen oder Gerätearten anzuwenden.

**Beispiel: Styles nur für schmale Bildschirme**

```css
@media (max-width: 600px) {
  body {
    background-color: lightyellow;
  }
}
```
> Gilt nur, wenn die **Viewport-Breite ≤ 600px** ist.

**Häufig genutzte Bedingungen:**

| Abfrage                    | Bedeutung                                                                    |
| -------------------------- | ---------------------------------------------------------------------------- |
| `(max-width: 768px)`       | Geräte mit **maximal 768px Breite** (Tablets & Smartphones)                  |
| `(min-width: 1024px)`      | Geräte mit **mindestens 1024px Breite** (größere Tablets, Laptops, Desktops) |
| `(orientation: portrait)`  | Hochformat                                                                   |
| `(orientation: landscape)` | Querformat                                                                   |


## Mobile-first vs. Desktop-first

### Mobile-first

- Standard-CSS für kleine Bildschirme schreiben → dann mit min-width größere Layouts anpassen.
- Vorteile: schnelleres Laden auf mobilen Geräten, zukunftssicher.

**Beispiel:**
```css
/* Basis: Mobile */
body { font-size: 14px; }

/* Größere Geräte */
@media (min-width: 768px) {
  body { font-size: 16px; }
}
```

### Desktop-first

- Standard-CSS für große Bildschirme schreiben → dann mit max-width für kleinere anpassen.
- Vorteil: für Desktop-Seiten einfacher, aber oft mehr Anpassungen für Mobile nötig.

**Beispiel:**
```css
/* Basis: Desktop */
body { font-size: 16px; }

/* Kleinere Geräte */
@media (max-width: 768px) {
  body { font-size: 14px; }
}
```

## Flexible Bilder und Containergrößen

- Starre Pixelwerte funktionieren auf unterschiedlichen Bildschirmgrößen oft schlecht.
- Verwenden Sie relative Einheiten und flexible Bilder.

**Beispiel: Bild skaliert mit Container**
```css
img {
  max-width: 100%;
  height: auto;
}
```
> Bild passt sich der Breite des Containers an, bleibt aber im Seitenverhältnis.

**Beispiel: Container in Prozentbreite**

```css
.container {
  width: 90%;
  max-width: 1200px;
  margin: auto;
}
```
> Container ist flexibel, aber nicht breiter als 1200px.
