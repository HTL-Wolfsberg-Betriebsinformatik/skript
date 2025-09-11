
## Definition

Softwareentwicklungsmodelle sind **standardisierte Vorgehensweisen**, die den **gesamten Lebenszyklus der Softwareentwicklung strukturieren** – von der Analyse über den Entwurf und die Implementierung bis hin zu Test, Betrieb und Wartung.

---

## Klassische Modelle

### Wasserfallmodell

- Ablauf in festen Phasen (Analyse → Entwurf → Implementierung → Test → Betrieb → Wartung)  
- Jede Phase muss abgeschlossen sein, bevor die nächste beginnt.  
- **Vorteile:**  
    - einfache Planung, klare Struktur  
    - gut für kleine Projekte mit stabilen Anforderungen  
- **Nachteile:**  
    - Änderungen schwer möglich  
    - spätes Feedback, Fehler werden oft spät erkannt  


### V-Modell  

- Erweiterung des Wasserfalls, mit Fokus auf Qualitätssicherung.  
- Jeder Entwicklungsphase steht eine Testphase gegenüber (z. B. Entwurf ↔ Integrationstest).  
- **Vorteile:**  
    - Tests sind von Anfang an vorgesehen  
    - hohe Qualität  
- **Nachteile:**  
    - wenig flexibel  
    - hoher Dokumentationsaufwand  

---

## Agile Modelle

### Scrum

- Iteratives Vorgehen in Sprints (meist 2–4 Wochen)  
- **Rollen:**  
    - *Product Owner*: Verantwortlich für Anforderungen und Prioritäten  
    - *Scrum Master*: Achtet auf den Prozess, unterstützt das Team  
    - *Entwicklungsteam*: setzt die Anforderungen um  
- **Artefakte:** Product Backlog, Sprint Backlog, Inkrement  
- **Meetings:** Sprint Planning, Daily Scrum, Sprint Review, Retrospektive  
- **Vorteile:**  
    - flexible Anpassung an Änderungen  
    - ständiges Feedback  
    - hohe Motivation durch Eigenverantwortung  
- **Nachteile:**  
    - funktioniert nur mit diszipliniertem Team  
    - schwer bei sehr großen Projekten

### Kanban

- Fokus auf Visualisierung von Arbeitsschritten mit einem Board (To Do → In Progress → Done)  
- Begrenzung der parallelen Aufgaben (Work in Progress Limits)  
- **Vorteile:**  
    - sehr flexibel, keine festen Iterationen  
    - leicht verständlich und einführbar  
- **Nachteile:**  
    - weniger strukturierte Planung  
    - Risiko von mangelnder Zielorientierung

---

## Vergleich klassische vs. agile Methoden

| Kriterium         | Klassisch (z. B. Wasserfall) | Agil (z. B. Scrum) |
|-------------------|------------------------------|--------------------|
| Anforderungen     | fix                         | flexibel           |
| Planung           | langfristig, upfront        | iterativ, inkrementell |
| Feedback          | spät                        | früh und regelmäßig |
| Risiko            | hoch                        | geringer durch Feedback |
| Kommunikation     | dokumentationsbasiert       | team- und meetingbasiert |