# HTML Aufbau und wichtige Tags

## Was sind HTML-Tags?

HTML verwendet sogenannte **Tags** (deutsch: „Auszeichnungen“), um Inhalte zu kennzeichnen und zu strukturieren.

Ein Tag besteht meist aus:

- einem **Start-Tag** (`<tagname>`),
- einem **Inhalt**,
- und einem **End-Tag** (`</tagname>`).

Beispiel:
```html
<p>Dies ist ein Absatz.</p>
```

Einige Tags sind **selbstschließend**, z. B. `<br>` oder `<img>`.

Tags können auch **Attribute** enthalten:
```html
<img src="bild.jpg" alt="Beschreibung">
```

HTML unterstützt auch **Kommentare**. Diese werden im Browser nicht angezeigt und dienen lediglich den Entwicklern:

```html
<!-- Überschrift der Seite -->
<h1>Willkommen auf meiner Seite</h1>
```

## Wichtige Tags

### Überschriften

```html
<h1>Größte Überschrift</h1>
<h2>Etwas kleiner</h2>
<h3>...</h3>
<h6>Kleinste Überschrift</h6>
```

### Absätze und Zeilenumbrüche

```html
<p>Dies ist ein Absatz.</p> <!-- <p> steht für `parapraph`> -->
<br> <!-- <br> steht für `break`> -->
<p>Neuer Absatz mit <br> Zeilenumbruch.</p>
```

### Listen

#### Geordnete Liste:
```html
<ol> <!-- <ol> steht für `ordered list` -->
  <li>Erster Punkt</li> <!-- <li> steht für `list item` -->
  <li>Zweiter Punkt</li>
</ol>
```

#### Ungeordnete Liste:
```html
<ul> <!-- <ul> steht für `unordered list` -->
  <li>Eintrag A</li>
  <li>Eintrag B</li>
</ul>
```

### Links

```html
<a href="https://www.example.com">Zur Webseite</a> <!-- <a> steht für anchor -->
```

> Der `<a>` tag wird benutzt um zu internen oder externen Seiten zu navigieren.

**Absolute URLs**

- Enthalten das vollständige Protokoll (e.g. `https`) und die Domain (e.g. `www.example.com`).

```html
<a href="https://www.example.com/about">Über uns</a>
```
> Als Voraussetzung gilt hier, dass eine `about.html` existiert.

**Relative URLs**

- Beziehen sich relativ zum Speicherort der aktuellen HTML-Datei.
- Vorteil: keine festen Domains – gut für lokale Entwicklung oder innerhalb derselben Website.

**Beispiel: Gleicher Ordner**
```html
<a href="kontakt.html">Kontakt</a>
```
> `kontakt.html` liegt im gleichen Ordner wie die aktuelle Seite.

**Beispiel: Unterordner**

```html
<a href="produkte/liste.html">Produkte</a>
```
>  Geht in den Unterordner `produkte/`.

**Beispiel: Übergeordneter Ordner**

```html
<a href="../index.html">Startseite</a>
```
>  Geht einen Ordner nach oben.

!!! tip "Tipp"
    Relative URLs sind vor allem nützlich, wenn das Projekt später auf verschiedenen Servern oder Domains laufen soll, ohne die Links anpassen zu müssen.

### Bilder

```html
<img src="bild.jpg" alt="Beschreibung" width="300" height="auto">
```

### Tabellen

```html
<table>
    <tr> <!-- <tr> steht für table row -->
        <th>Name</th> <!-- <th> steht für table header -->
        <th>Alter</th>
    </tr>
    <tr>
        <td>Anna</td> <!-- <td> steht für table data -->
        <td>17</td>
    </tr>
    <tr>
        <td>Joe</td>
        <td>18</td>
    </tr>
</table>
```

### Beispiel

=== "HTML Code"
    ```html
    --8<-- "assets/html/tag-example.html"
    ```
=== "Ausgabe"
    <iframe src="../../../../assets/html/tag-example.html" width="100%" height="850px" style="border:1px solid #ccc;"></iframe>

!!! hint "Hinweis"
    Diese Beispiel ist auch [hier](../../../assets/html/tag-example.html) verfügbar.