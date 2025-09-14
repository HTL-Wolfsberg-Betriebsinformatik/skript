## Arten von Modellierungssprachen?

- Es gibt mehrere Ansätze, um Prozesse zu modellieren.  
- Sie unterscheiden sich in Herkunft, Zielgruppe und Einsatzgebiet.  


### UML-Aktivitätsdiagramme

- **UML = Unified Modeling Language**  
- Ursprünglich für die **Softwareentwicklung** gedacht.  
- Aktivitätsdiagramme zeigen Abläufe als Aktivitäten und Entscheidungen.  
- Vorteil: einfach und leicht verständlich.  
- Nachteil: zu allgemein für Geschäftsprozesse, oft fehlen Rollen, Ereignisse, Kommunikation.

### EPC – Ereignisgesteuerte Prozesskette

- Entwickelt in den 1990er Jahren im **ARIS-Modell**.  
- Nutzt **Ereignisse** (Zustände) und **Funktionen** (Tätigkeiten).  
- Vorteil: stark in der Wirtschaftsinformatik, gut für den Einstieg.  
- Nachteil: weniger internationaler Standard, Simulation/Automatisierung schwierig. 

!!! info "Was ist ARIS?"
    - **ARIS = Architecture of Integrated Information Systems**  
    - Entwickelt von Prof. August-Wilhelm Scheer (1990er).  
    - Ziel: Unternehmen ganzheitlich modellieren (Prozesse, Daten, Organisation, IT-Systeme).  
    - Enthält u. a. die **EPCs** als Methode.  
    - Bekanntes Tool: **ARIS-Software (Software AG)**.  

### BPMN 2.0 – Business Process Model and Notation
- Seit 2011 internationaler Standard (OMG).  
- Speziell für **Geschäftsprozesse** entwickelt.  
- Wird weltweit von Unternehmen und Software-Tools unterstützt. 

!!! info "Was ist OMG?"
    - **OMG = Object Management Group**  
    - Internationale Organisation, gegründet 1989 in den USA.  
    - Entwickelt und pflegt Standards für IT und Modellierung.  
    - Bekannte Standards:  
      - UML (Unified Modeling Language)  
      - BPMN (Business Process Model and Notation)  
      - SysML (Systems Modeling Language)  
    - Vorteil: Standards sind **weltweit anerkannt** und schaffen eine gemeinsame Sprache zwischen Business und IT.  

## Vergleich

| Aspekt              | UML-Aktivitätsdiagramm      | EPC                        | BPMN 2.0                 |
|---------------------|-----------------------------|----------------------------|--------------------------|
| Ursprung            | Softwareentwicklung         | Wirtschaftsinformatik (ARIS)| Internationaler Standard |
| Zielgruppe          | Entwickler                  | Betriebswirtschaftler      | Business & IT gemeinsam  |
| Hauptfokus          | Ablauflogik                 | Ereignisse + Funktionen    | Geschäftsprozesse        |
| Standardisierung    | Ja (OMG)                    | Teil von ARIS, weniger Standard | Ja (OMG, weltweit)  |
| Automatisierung     | kaum                       | kaum                       | sehr gut möglich         |

!!! tip "Info"
    Wir arbeiten mit **BPMN 2.0**, da es internationaler Standard und praxisnah ist.

