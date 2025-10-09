---
theme: seriph

title: MINT Thymio Einführung
info: |
  ## MINT Thymio Einführung
background: https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true
class: text-center
drawings:
    persist: false
transition: slide-left
mdc: true
layout: cover
hideInToc: true
download: true
export:
    format: pdf
    dark: false
    withClicks: true
    withToc: true
selectable: true
---

# Thymio

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Aufgabe: Need for Speed

- Steuere den Thymio über die Tasten. Teste verschiedene Geschwindigkeiten. 
- Kurven fahren bis hin zum Drehen auf der Stelle ist ebenfalls möglich.
- Auch Rückwärtsfahren ist erlaubt!

---

# Aufgabe: Lichtspiele

- Lass den Thymio farbig leuchten, wenn du klatschst.
- Probiere verschiedene Farben aus. 
- Man kann Farben auch selber "mischen".

---

# Aufgabe: Notbremse

- Der Thymio fährt auf die Tischkante zu und droht abzustürzen.
- Programmiere den Roboter so, dass er nicht in die Tiefe stürzt.

<br>

**Tipp zur Umsetzung:**
Du brauchst die *Bodendistanz-Sensoren*. Lasse den Roboter auf eine Tischkante zufahren, oder benutze einen weissen Untergrund mit dicker schwarzer Linie als Tischkante.

---

# Aufgabe: Rotlicht

- Vor einem Hindernis stoppt der Thymio und leuchtet rot. 
- Wenn der Stoppbutton gedrückt wird, soll der Thymio wieder weiss werden.

**Tipp zur Umsetzung:**
Bei diesen Ereignissen braucht es mehrere Aktionen.
Du kannst den Thymio oben und unten rot leuchten lassen!

---

# Aufgabe: Linien zeichnen

- Du steuerst den Thymio mit den Pfeiltasten.
- Lass den Roboter ein Bild aus geraden Linien zeichnen.
- Für Richtungswechsel soll der Thymio auf der Stelle drehen.

**Tipp zur Umsetzung:**
Je langsamer der Thymio fährt, desto besser fährt er geradeaus. Beim Drehen auf der Stelle drückst du im richtigen Moment wieder die Vorwärts-Taste zum Weiterzeichnen.

---

# Aufgabe: Ausweichen

- Wenn der Roboter auf ein Hindernis trifft, soll er rückwärts mit einer Kurve ausweichen. 
- Wenn er beim Rückwärtsfahren ein Hindernis trifft, dann soll er wieder geradeaus vorwärts fahren.

**Tipp zur Umsetzung:**
Weiche mit einer Rechts- oder Linkskurve rückwärts aus. Programmiere also die Sensoren vorne rechts und vorne links unterschiedlich.

---

# Aufgabe: Einer Linie folgen

- Der Thymio soll auf Knopfdruck vorwärts losfahren und selbständig einer schwarzen Linie (mindestens 3cm breit!) folgen. 
- Dabei leuchtet er unten, wenn er nach rechts fährt und er leuchtet oben, wenn er nach links fährt.

**Tipps zur Umsetzung:**
Du brauchst die Bodensensoren, die erkennen, wenn du die Linie links oder rechts verlässt. Der Thymio soll dann zurück auf die Linie fahren.
Linie: Schwarzes Klebband (mindestens 3cm breit!)
auf einer hellen Unterlage.

---

# Aufgabe: Verfolgungsjagd

Der Thymio verfolgt deine Hand. Programmiere ihn so, dass er
der Hand geradeaus, links und rechts folgen kann.

**Tipps zur Umsetzung:**

Je langsamer der Thymio fährt, desto besser folgt er der Hand.
Programmiere mindestens drei vordere Sensoren. Vergiss den Stoppknopf nicht!