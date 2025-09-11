

## Definition
  
Schätzverfahren dienen dazu, den **Aufwand**, die **Dauer** und die **Kosten** von Softwareprojekten oder einzelnen Arbeitspaketen abzuschätzen.

Sie sind ein wichtiges Hilfsmittel im **Projektmanagement**, da ohne realistische Schätzung weder Budget noch Zeitplan eingehalten werden können.


## Problematik beim Schätzen

- Anforderungen sind zu Beginn oft unklar oder ändern sich.  
- Entwickler neigen dazu, zu optimistisch zu schätzen.  
- Unerwartete Risiken (z. B. technische Probleme, Personalausfälle) können den Aufwand erhöhen.  
- Einmalige Aufgaben sind schwerer einzuschätzen als wiederkehrende Tätigkeiten.

!!! tip "Merksatz"
    Schätzen bedeutet *Annäherung an die Realität*, nicht exakte Vorhersage.  

---

## Arten von Schätzverfahren

### Expertenschätzung

Einzelpersonen oder Gruppen mit Erfahrung geben eine Aufwandsschätzung ab

**Methoden:**

- *Delphi-Methode*: Mehrere Experten schätzen anonym, Ergebnisse werden gemittelt und in mehreren Runden verfeinert.
- *Top-Down*: Gesamtes Projekt wird grob geschätzt, danach auf Teilaufgaben heruntergebrochen.
- *Bottom-Up*: Einzelne Arbeitspakete werden geschätzt und dann summiert.

**Vorteil:** nutzt Erfahrung; schnell verfügbar.  

**Nachteil:** subjektiv, Gefahr von Fehleinschätzungen.  

### Analogie-Schätzung

- Vergleich mit ähnlichen, bereits durchgeführten Projekten.  
- „Das Modul X ist so komplex wie Modul Y aus Projekt Z – Aufwand war 10 Stunden.“  

**Vorteil:** einfach, wenn Vergleichsdaten vorliegen.  

**Nachteil:** unbrauchbar, wenn keine Referenzprojekte vorhanden sind.

### Algorithmische Verfahren

- Schätzung anhand mathematischer Modelle.  
- **Function Point Analyse:**  
    - Zerlegung des Systems in Funktionen (Eingaben, Ausgaben, Dateien, Schnittstellen).  
    - Jede Funktion bekommt einen Gewichtungsfaktor.  
    - Summe ergibt die Function Points → werden in Aufwand umgerechnet.  
- **COCOMO-Modell (Constructive Cost Model):**  
    - Basierend auf der Größe des Codes (Lines of Code, LOC).  
    - Formel berücksichtigt Projektart (organisch, semi-detached, embedded) und liefert Aufwandsschätzung in Personenmonaten.  

**Vorteil:** objektiver, nachvollziehbar.  

**Nachteil:** aufwendig, oft schwer anwendbar bei kleinen Projekten.

### Agile Schätzverfahren

- Geeignet für Projekte mit unsicheren oder dynamischen Anforderungen.  
- **Planning Poker:**  
    - Jedes Teammitglied erhält Karten mit Zahlen (z. B. Fibonacci-Reihe: 1, 2, 3, 5, 8, 13, …).  
    - Eine User Story wird diskutiert, alle wählen gleichzeitig eine Karte.  
    - Bei großen Abweichungen: Diskussion, bis sich das Team einigt.  
- **Story Points:**  
    - Bewertung der Komplexität einer Aufgabe im Verhältnis zu anderen.  
    - Kein direkter Zeitwert, sondern relative Schätzung („Story A ist doppelt so aufwendig wie Story B“).  
- **Velocity:**  
    - Misst, wie viele Story Points ein Team pro Sprint tatsächlich schafft.  
    - Dient der Vorhersage zukünftiger Sprints.

**Vorteil:** realistisch durch Teamarbeit, fördert Diskussion.  

**Nachteil:** schwer in klassische Projektpläne zu übersetzen. 

### Vergleich der Methoden

| Verfahren            | Genauigkeit | Aufwand zur Durchführung | Eignung |
|----------------------|-------------|--------------------------|---------|
| Expertenschätzung    | mittel      | gering                   | Kleine Projekte, erste Planung |
| Analogie-Schätzung   | mittel      | gering                   | Wenn Vergleichsprojekte existieren |
| Function Points / COCOMO | hoch    | hoch                     | Große Projekte, professionelle Planung |
| Agile Methoden       | variabel    | mittel                   | Iterative, dynamische Projekte |


### Praktische Tipps für die Schätzung

- Immer **Pufferzeiten** (z. B. 20–30 %) für unerwartete Probleme einplanen.  
- Schätzungen regelmäßig **überprüfen und anpassen**.  
- Kombination mehrerer Methoden ist oft sinnvoll (z. B. Expertenschätzung + Planning Poker).  
- Wichtig: Schätzungen sind **keine Zusagen**, sondern Annäherungen.