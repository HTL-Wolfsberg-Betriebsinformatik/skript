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

### Geschichte der Browser

| Year | Browser             | Details                                                                 |
|------|---------------------|-------------------------------------------------------------------------|
| 1990 | WorldWideWeb (Nexus)| Created by Tim Berners-Lee, the first web browser was later renamed Nexus. |
| 1992 | Lynx                | A text-based browser with no graphical content support.                 |
| 1993 | NCSA Mosaic         | The first graphical web browser, widely popular and accessible.         |
| 1994 | Netscape Navigator  | Developed from Mosaic, becoming the most commonly used browser of its time. |
| 1995 | Internet Explorer   | Microsoft’s first browser, bundled with Windows.                        |
| 1996 | Opera               | Initially a research project, it was later released publicly.           |
| 2003 | Safari              | Apple’s browser was released exclusively for Macintosh computers.       |
| 2004 | Mozilla Firefox     | Launched as an open-source alternative, continuing from Netscape Navigator. |
| 2007 | Mobile Safari       | Apple’s web browser for mobile devices introduced with the iPhone.      |
| 2008 | Google Chrome       | A fast and minimalistic browser that quickly gained popularity.         |
| 2011 | Opera Mini          | A lightweight mobile browser designed for faster web access on smartphones. |
| 2015 | Microsoft Edge      | Microsoft’s modern browser, replacing Internet Explorer.                |

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

Speichern Sie diese Datei z. B. als `index.html` und öffnen Sie sie im Browser per Doppelklick oder klicken Sie [hier](../../../assets/html/hello-world.html).

!!! info
    HTML-Dateien sind reine Textdateien mit der Endung `.html` und können mit jedem Texteditor erstellt werden:
    
    - Editor 
    - Notepad++
    - Visual Studio Code (VS Code)
