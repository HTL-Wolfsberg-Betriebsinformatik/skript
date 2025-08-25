CSS-Variablen – auch **Custom Properties** genannt – ermöglichen es, **Werte zentral zu definieren** und mehrfach im Stylesheet zu verwenden.  
Das sorgt für **einheitliches Design** und erleichtert Änderungen.

## Definition von CSS-Variablen

CSS-Variablen werden mit `--` vor dem Namen erstellt und **innerhalb eines Selektors** definiert.  
Oft nutzt man `:root`, um sie **global** für die gesamte Seite verfügbar zu machen.

```css
:root {
  --hauptfarbe: #3498db;
  --sekundärfarbe: #2ecc71;
  --standard-padding: 1rem;
}
```

## Nutzung von CSS-Variablen

```css
h1 {
  color: var(--hauptfarbe);
}

button {
  background-color: var(--sekundärfarbe);
  padding: var(--standard-padding);
}
```

## Vorteile

- **Konsistenz:** Farben, Abstände und Schriftgrößen sind überall gleich.
- **Einfache Änderungen:** Wird der Wert an einer Stelle geändert, aktualisieren sich alle betroffenen Elemente automatisch.
- **Weniger Code-Duplikate:** Kein mehrfaches Schreiben derselben Werte.
- **Theming:** Einfaches Umschalten von Farbpaletten (z. B. Dark Mode).

## Beispiel: Farbthema

=== "CSS"
    ```css
    --8<-- "assets/html/css-variablen/css-variablen.css"
    ```
=== "HTML Light Mode"
    ```html
    --8<-- "assets/html/css-variablen/css-variablen-light-mode.html"
    ```
=== "HTML Dark Mode"
    ```html
    --8<-- "assets/html/css-variablen/css-variablen-dark-mode.html"
    ```
=== "Ausgabe Light Mode"
    <iframe src="../../../../assets/html/css-variablen/css-variablen-light-mode.html" width="100%" height="400" style="border:1px solid #ccc; border-radius:8px;"></iframe>
=== "Ausgabe Dark Mode"
    <iframe src="../../../../assets/html/css-variablen/css-variablen-dark-mode.html" width="100%" height="400" style="border:1px solid #ccc; border-radius:8px;"></iframe>
