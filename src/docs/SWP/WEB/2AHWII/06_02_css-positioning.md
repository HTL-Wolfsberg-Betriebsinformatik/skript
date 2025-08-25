
## Grundidee
Mit CSS-Positionierung wird festgelegt, **wo** ein Element auf der Webseite angezeigt wird.  
Das Verhalten hängt vom Wert der **`position`**-Eigenschaft ab.

---

## Arten der Positionierung

| Wert         | Beschreibung |
|--------------|--------------|
| `static`     | **Standard**. Elemente erscheinen in der normalen Reihenfolge des HTML-Dokuments. Keine spezielle Positionierung. |
| `relative`   | Positionierung **relativ zur ursprünglichen Position**. Ermöglicht kleine Verschiebungen. |
| `absolute`   | Positionierung **relativ zum nächsten positionierten Vorfahren** (nicht zum gesamten Dokument, außer wenn kein Vorfahre positioniert ist). |
| `fixed`      | Positionierung **relativ zum Browserfenster**. Bleibt beim Scrollen an derselben Stelle. |
| `sticky`     | Mischung aus `relative` und `fixed`. Bewegt sich normal, bleibt aber an einer Position „kleben“, sobald sie erreicht ist. |

---

## Wichtige Positions-Attribute
Diese Werte funktionieren nur, wenn `position` ≠ `static` ist:

- `top` – Abstand von der oberen Kante
- `left` – Abstand von der linken Kante
- `right` – Abstand von der rechten Kante
- `bottom` – Abstand von der unteren Kante

---

## Beispiele der Positionierungsarten

### Static (Standard)
```css
.box {
  position: static; /* Standardwert */
}
```

> Element bleibt im normalen Seitenfluss.


### Relative 

```css
.box {
  position: relative;
  top: 10px;
  left: 20px;
}
```
> Verschiebt das Element von seiner ursprünglichen Position.

### Absolute

```css
.container {
  position: relative; /* Bezugspunkt für absolute Kinder */
}

.box {
  position: absolute;
  top: 0;
  right: 0;
}
```
> Platziert .box in der oberen rechten Ecke des Containers.

### Fixed

```css
.menu {
  position: fixed;
  top: 0;
  left: 0;
}
```
> Bleibt immer oben links im Fenster – auch beim Scrollen.

### Sticky

```css
.header {
  position: sticky;
  top: 0;
}
```
> Scrollt normal, bis die obere Position erreicht ist, und bleibt dann dort „kleben“.

!!! hint "Hinweis"
    - `absolute` immer in einem positionierten Container verwenden, um ungewollte Platzierung zu vermeiden.
    - `fixed` für Navigationsleisten oder Buttons, die immer sichtbar bleiben sollen.
    - `sticky` ideal für Tabellenköpfe oder fixierte Überschriften beim Scrollen.

## Komplettes Beispiel

=== "HTML Code"
    ```html
    --8<-- "assets/html/positioning-css.html"
    ```

=== "Ausgabe"
    <iframe src="../../../../assets/html/positioning-css.html" width="100%" height="500" style="border:1px solid #ccc;"></iframe>
