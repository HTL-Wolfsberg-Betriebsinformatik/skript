Mit **CSS Transitions** lassen sich **weiche Zustandswechsel** (z. B. Farbe, Größe, Position) animieren – ohne JavaScript.  
Typische Auslöser sind **Hover** (`:hover`), **Fokus** (`:focus`/`:focus-visible`) oder **aktive Zustände** (`:active`).

## 1) Grundlagen: `transition`

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

Beispiel: Hover Effekte für Button und Links:

=== "HTML"
    ```html
    --8<-- "assets/html/effects/button-hover.html"
    ```
=== "CSS"
    ```css
    --8<-- "assets/html/effects/button-hover.css"
    ```
=== "Ausgabe"
    <iframe src="/assets/html/effects/button-hover.html" width="100%" height="700" style="border:1px solid #ccc; border-radius:8px;"></iframe>


