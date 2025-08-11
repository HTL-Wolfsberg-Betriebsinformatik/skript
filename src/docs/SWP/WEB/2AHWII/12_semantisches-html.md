**Semantisches HTML** bedeutet, dass HTML-Elemente so verwendet werden, dass ihre **Bedeutung** (Semantik) für Menschen und Maschinen klar ist.  
Anstatt alles in `<div>` oder `<span>` zu packen, werden **spezielle Tags** genutzt, die den **Inhaltstyp** beschreiben.

## Wichtige semantische Elemente

| Tag          | Bedeutung / Zweck |
|--------------|------------------|
| `<header>`   | Kopfbereich einer Seite oder eines Abschnitts – oft mit Logo, Titel, Navigation |
| `<nav>`      | Haupt- oder Nebennavigation mit Links |
| `<section>`  | Thematisch zusammenhängender Bereich (z. B. "News", "Produkte") |
| `<article>`  | In sich geschlossener Inhalt, der eigenständig stehen kann (z. B. Blogartikel, Forenbeitrag) |
| `<aside>`    | Zusatzinformationen, Randnotizen, Werbung, Seitenleisten |
| `<footer>`   | Fußbereich einer Seite oder eines Abschnitts – oft mit Copyright, Kontakt, Links |

## Beispiel

=== "HTML"
    ```html
    --8<-- "assets/html/semantic-demo.html"
    ```
=== "Ausgabe"
    <iframe src="/assets/html/semantic-demo.html" width="100%" height="700" style="border:1px solid #ccc; border-radius:8px;"></iframe>

## Vorteile

- **Bessere Struktur:** Der Quellcode ist leichter zu lesen und zu pflegen.

- **Suchmaschinenoptimierung (SEO):** Suchmaschinen erkennen wichtige Inhalte und deren Bedeutung besser.

- **Barrierefreiheit (Accessibility):** Screenreader können den Inhalt sinnvoll gliedern und Nutzern vorlesen.

- **Einheitliche Standards:** Alle Entwickler:innen verstehen sofort den Aufbau.

!!! info
    Semantische Elemente können mit CSS wie normale `<div>`-Elemente gestaltet werden – der Unterschied liegt in der Bedeutung im HTML.
    ```html
    <!-- Nicht semantisch -->
    <div class="news-item">
    <h2>Artikel 1</h2>
    <p>Inhalt...</p>
    </div>
    <!-- Semantisch -->
    <article>
    <h2>Artikel 1</h2>
    <p>Inhalt...</p>
    </article>
    ```
    Beide sehen gleich aus, aber nur das zweite Beispiel sagt Maschinen: „Das ist ein eigenständiger Artikel.“

