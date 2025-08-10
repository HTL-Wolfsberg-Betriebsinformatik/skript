Das Web lebt nicht nur von Text, sondern auch von **Bildern, Audio und Video**.  
HTML bietet dafür eigene Elemente, um Medien **einfach und standardkonform** einzubetten.

## Bilder (`<img>`)

=== "HTML"
    ```html
    <img src="/assets/images/god-of-html.png" alt="God of Html" width="200px" height="auto">
    ```
=== "Ausgabe"
    <img src="/assets/images/god-of-html.png" alt="God of Html" width="200px" height="auto">

| Attribut           | Bedeutung                                                                     |
| ------------------ | ----------------------------------------------------------------------------- |
| `src`              | Dateipfad oder URL des Bildes                                                 |
| `alt`              | Alternativtext für Screenreader oder falls das Bild nicht geladen werden kann |
| `width` / `height` | Größe in Pixel (oder per CSS)                                                 |


!!! tip "Tipp"
    Immer einen sinnvollen alt-Text verwenden – wichtig für Barrierefreiheit und SEO.

## Audio (`<audio>`)

=== "HTML"
    ```html
    <audio src="/assets/audio/audio-example.mp3" controls></audio>
    ```
=== "Ausgabe"
    <audio src="/assets/audio/audio-example.mp3" controls></audio>

| Attribut           | Bedeutung                                                                     |
| ------------------ | ----------------------------------------------------------------------------- |
| `controls`         | zeigt Play/Pause/Lautstärke                                                   |
| `autoplay`         | startet automatisch (kann störend sein)                                       |
| `loop`             | wiederholt sich automatisch                                                   |

## Video (`<video>`)

=== "HTML"
    ```html
    <video src="/assets/videos/video-example.mp4" controls width="500" poster="vorschaubild.jpg"></video>
    ```
=== "Ausgabe"
    <video src="/assets/videos/video-example.mp4" controls width="500" poster="/assets/images/vorschaubild_video-example.png"></video>

| Attribut   | Bedeutung                                      |
| ---------- | ---------------------------------------------- |
| `controls` | Steuerelemente einblenden                      |
| `poster`   | Vorschaubild anzeigen, bevor das Video startet |
| `autoplay` | Automatisch abspielen                          |
| `loop`     | Endlosschleife                                 |
| `muted`    | Start ohne Ton                                 |


## Externe Inhalte (`<iframe>`)

Ein `iframe` kann eine externe Webseite oder Anwendung direkt einbetten.

**Beispiel: YouTube-Video**

=== "HTML"
    ```html
    <iframe width="560" height="315" 
        src="https://www.youtube.com/embed/eBSLUbpJvwA?si=nvFTCVmW9MtNiVQH" 
        title="Bill Gates and David Letterman" 
        frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        referrerpolicy="strict-origin-when-cross-origin" 
        allowfullscreen>
    </iframe>
    ```
=== "Ausgabe"
    <iframe width="560" height="315" 
        src="https://www.youtube.com/embed/eBSLUbpJvwA?si=nvFTCVmW9MtNiVQH" 
        title="Bill Gates and David Letterman" 
        frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        referrerpolicy="strict-origin-when-cross-origin" 
        allowfullscreen>
    </iframe>

**Weitere Verwendungsmöglichkeiten:**

- Karten (Google Maps)
- Dokumente (z. B. PDF-Viewer)
- Interaktive Tools