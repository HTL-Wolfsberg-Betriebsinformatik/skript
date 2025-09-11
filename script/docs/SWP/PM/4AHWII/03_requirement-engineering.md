## Definition

Die Anforderungsanalyse ist der Prozess des **Ermittelns**, **Dokumentierens** und **Prüfens** von Anforderungen an ein Softwaresystem.  
Ziel ist es, ein gemeinsames Verständnis zwischen Auftraggeber (Kunde, Anwender) und Auftragnehmer (Entwickler, Projektteam) zu schaffen.

## Wichtigkeit von Anforderungsanalyse

- **Fehler in den Anforderungen** sind die häufigste Ursache für gescheiterte Projekte.  
- Je später ein Fehler entdeckt wird, desto teurer wird seine Behebung.  
- Missverständnisse zwischen Kunde und Entwickler können frühzeitig erkannt und reduziert werden.  

**Beispiel:**  
Der Kunde will „ein schnelles System“ – was bedeutet das? 

- Antwort A: Antwortzeit < 1 Sekunde.  
- Antwort B: Ladezeit < 3 Sekunden.  
→ Ohne präzise Definition entstehen Missverständnisse.  

## Arten von Anforderungen

### Funktionale Anforderungen

- Beschreiben, **was** das System tun soll.  
- Beispiele:  
    - „Das System muss Benutzerregistrierung ermöglichen.“  
    - „Das System generiert monatliche Reports.“

### Nicht-funktionale Anforderungen

- Auch **Qualitätsanforderungen** genannt
- Beispiele:
    - Performance: Antwortzeit < 1 Sekunde
    - Sicherheit: Benutzer müssen sich mit 2FA anmelden
    - Barrierefreiheit: System unterstützt Screenreader
    - Benutzerfreundlichkeit: System ist für mobile Endgeräte optimiert

### Randbedingungen (Constraints)

- Rahmenbedingungen, die das Projekt einschränken.
- Beispiel:
    - "Muss mit einer MS SQL Server Datenbank laufen
    - "Budget max. 100.000 €"


## Vorgehen in der Anforderungsanalyse

### Anforderungserhebung

**Methoden:**

- Interviews mit Anwendern / Kunden  
- Workshops  
- Fragebögen  
- Beobachtung am Arbeitsplatz  
- Analyse bestehender Systeme  
- Prototyping

### Anforderungsdokumentation

- Alle Ergebnisse werden schriftlich festgehalten.  
- Typische Dokumente: 
    - **Lastenheft:** Was der Kunde will (aus Sicht des Auftraggebers).  
    - **Pflichtenheft:** Wie es umgesetzt wird (aus Sicht des Auftragnehmers).
- Modelle zur Dokumentation:
    - **Use Cases (Anwendungsfälle)**  
       - Beschreiben Interaktionen zwischen Akteuren (Benutzer, externe Systeme) und dem System.  
       - Beispiel: "Benutzer meldet sich im System an."
       - Siehe [Use-Case Diagramme](../3AHWII/03_use-case-diagram.md)
    - **User Stories (agile Methode)**  
       - Kurze Sätze im Format:  
         > "Als [Rolle] möchte ich [Funktion], um [Nutzen]."
       - Beispiel: "Als Kunde möchte ich meine Bestellung online verfolgen, um jederzeit den Status zu kennen." 

### Anforderungsprüfung

- Anforderungen werden auf **Vollständigkeit, Widerspruchsfreiheit und Machbarkeit** geprüft.  
- Typische Fragen:  
    - Sind die Anforderungen verständlich formuliert?  
    - Gibt es Konflikte zwischen Anforderungen?  
    - Sind alle Stakeholder berücksichtigt?  
    - Lassen sich die Anforderungen testen?  

Werkzeuge zur Anforderungsanalyse

- **Klassisch:** Word, Excel, UML-Tools (z. B. drawio), ...  
- **Agil:** Jira, Trello, Azure DevOps, ...
- **Prototyping:** Figma, Balsamiq, ...

### Beispiel einer Anforderungsanalyse

**Projekt - "Bibliotheksverwaltungssystem**

- Funktionale Anforderungen:  
    - Benutzer können Bücher suchen, ausleihen und zurückgeben.  
    - Bibliothekare können neue Medien anlegen und löschen.  

- Nicht-funktionale Anforderungen:  
    - Antwortzeit der Suchfunktion max. 2 Sekunden.  
    - System muss 24/7 verfügbar sein.  

- Randbedingungen:  
    - Datenbank: PostgreSQL  
    - Budget: 20.000 €

- User Story:  
    - „Als Student möchte ich Bücher online verlängern, damit ich keine Mahngebühren zahlen muss.“  

- Use Case:  
    - Akteur: Student  
    - Ziel: Buch verlängern  
    - Szenario: Student wählt Buch → klickt auf „verlängern“ → System prüft Verfügbarkeit → Verlängerung wird bestätigt.  

