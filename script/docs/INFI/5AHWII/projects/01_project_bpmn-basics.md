# BPMN 2.0 – Übungsbeispiele in draw.io

Diese drei Übungsaufgaben sollen helfen, die Grundlagen von **BPMN 2.0** praktisch zu festigen.  
Die Aufgaben werden **schrittweise schwieriger** und sollen jeweils in **draw.io (diagrams.net)** umgesetzt werden.  

---

## Übung 1 – Schulbibliothek

!!! info "Ziel"
    - Ereignisse, Aktivitäten und **XOR-Gateways** anwenden  
    - Mehrere End-Ereignisse richtig darstellen  
    - Sequenzen logisch verbinden  
 

---

### Beschreibung

In der **Schulbibliothek** läuft folgender Prozess ab:

- Start-Ereignis: Schüler kommt in die Bibliothek  
- Aktivität: Schüler sucht nach einem Buch  
- Gateway (XOR): Buch verfügbar?  
  - **Ja:**  
    - Schüler leiht Buch aus  
    - System markiert Buch als *ausgeliehen*  
    - Bibliothekar druckt Quittung  
    - **End-Ereignis:** Buch ausgeliehen  
  - **Nein:**  
    - Schüler fragt nach Reservierung  
    - Gateway (XOR): Reservierung erlaubt?  
      - **Ja:** Buch wird reserviert → Schüler wird benachrichtigt → **End-Ereignis: Buch reserviert**  
      - **Nein:** Schüler verlässt Bibliothek → **End-Ereignis: Keine Aktion**

---

!!! tip "Hinweise"
    - Verwende mindestens **zwei XOR-Gateways**  
    - Achte auf **mehrere End-Ereignisse**  
    - Alle Pfade müssen logisch abgeschlossen sein  

---

## Übung 2 – Online-Bestellung mit parallelen Abläufen

!!! info "Ziel"
    - Parallelisierung verstehen und korrekt modellieren  
    - Entscheidungen kombinieren  
    - Synchronisation am Ende  

---

### Beschreibung

Ein Kunde bestellt in einem Online-Shop ein Produkt:

- **Start-Ereignis:** Kunde klickt auf *„Bestellung absenden“*  
- **Aktivität:** System prüft den Lagerbestand  
- **Gateway** Produkt verfügbar?  
  - **Nein:** System informiert Kunden → **End-Ereignis: Bestellung storniert**  
  - **Ja:** System startet **zwei parallele Abläufe**  
    - **A)** Rechnung erstellen  
    - **B)** Ware verpacken  
- Wenn beide abgeschlossen sind → Lieferung vorbereiten  
- Danach: Zahlung erfolgreich?  
  - **Ja:** Sendung ausliefern → **End-Ereignis: Bestellung abgeschlossen**  
  - **Nein:** Kunde informieren → **End-Ereignis: Zahlung fehlgeschlagen** 

---

## Übung 3 – Bewerbungsprozess (Freitext)

!!! info "Ziel"
    - Komplexe Prozesslogik und Schleifen verstehen  
    - Textinterpretation: BPMN-Struktur aus realem Szenario ableiten  
    - Eigenständige Modellierung ohne Schritt-für-Schritt-Vorgabe  

---

### Aufgabenstellung

> Du bist Teil eines Unternehmens, das Bewerbungen erhält.  
> Der Prozess beginnt, sobald eine Bewerbung eingeht.  
>  
> Die Unterlagen werden zunächst geprüft. Wenn etwas fehlt, wird der Bewerber informiert und gebeten, die fehlenden Dokumente nachzureichen.  
> Danach erfolgt eine erneute Prüfung.  
>  
> Sind die Unterlagen vollständig, wird die Bewerbung an die Fachabteilung weitergeleitet. Diese bewertet die Bewerbung und entscheidet, ob der Bewerber zu einem Vorstellungsgespräch eingeladen wird.  
>  
> Nach dem Gespräch wird entschieden, ob der Bewerber eingestellt wird.  
> Wird er angenommen, folgt die Vertragserstellung und die Aufnahme ins Unternehmen.  
> Wird er abgelehnt, erhält er eine Absage.  
>  
> **Tipp:** Der Prozess kann mehrere Entscheidungen, Schleifen und Enden enthalten.

---

!!! question "Leitfragen"
    - Wo beginnt der Prozess?  
    - Welche Aktivitäten und Entscheidungen gibt es?  
    - Wo kann der Prozess enden?  
    - Gibt es Stellen, an denen der Ablauf wiederholt wird (z. B. Unterlagen nachreichen)?  
