# Webentwicklung: Einstieg in HTML

## Was ist das Web?

Das World Wide Web (WWW) ist ein weltweites Informationssystem, das auf dem Internet basiert. Webseiten werden mit Hilfe von **HTML** strukturiert, im **Browser** dargestellt und durch **Hyperlinks** verbunden.

## Warum HTML?

**HTML (HyperText Markup Language)** ist die Sprache, mit der Webseiten erstellt werden. Sie beschreibt den **Inhalt und die Struktur** einer Seite:

- Text (Absätze, Überschriften)
- Links
- Bilder
- Listen und Tabellen
- Formulare und Eingabefelder

!!! info
    HTML ist keine Programmiersprache, sondern eine **Auszeichnungssprache**.

## Was macht ein Browser?

Ein **Webbrowser** (z. B. Chrome, Firefox, Edge) ist ein Programm, das **HTML-Dateien interpretiert** und daraus eine grafische Benutzeroberfläche rendert.

### Ablauf beim Laden einer Website:
1. Der Browser fordert eine `.html`-Datei vom Server an
2. Er **analysiert** den HTML-Code (Parsing)
3. Er stellt die Inhalte auf dem Bildschirm dar

## Beispiel: Einfache HTML-Datei

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Meine erste Webseite</title>
  </head>
  <body>
    <h1>Hallo Welt!</h1>
    <p>Dies ist meine erste HTML-Seite.</p>
  </body>
</html>
```

Speichern Sie diese Datei z. B. als `index.html` und öffnen Sie sie im Browser per Doppelklick oder klicken Sie [hier](/assets/html/hello-world.html).

!!! info
    HTML-Dateien sind reine Textdateien mit der Endung `.html` und können mit jedem Texteditor erstellt werden:
    
    - Editor 
    - Notepad++
    - Visual Studio Code (VS Code)
