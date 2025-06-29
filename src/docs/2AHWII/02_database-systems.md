
Datenbanksysteme unterscheiden sich je nach **Datenmodell**, **Einsatzzweck** und **technischer Ausprägung**. Grundsätzlich lassen sich zwei große Gruppen unterscheiden:

- **Relationale Datenbanksysteme (RDBMS)**
- **Nicht-relationale Datenbanksysteme (NoSQL)**


## Relationale Datenbanksysteme (RDBMS)

> Relationale Datenbanken speichern Daten in **Tabellen**, die über Schlüssel miteinander verknüpft sind. Die Abfragesprache ist standardmäßig **SQL** (Structured Query Language).


### Merkmale

| Merkmal     | Beschreibung                                     |
|-------------|--------------------------------------------------|
| Struktur    | Tabellen mit Zeilen und Spalten                 |
| Sprache     | SQL                                              |
| Vorteile    | Standardisiert, bewährt, konsistent              |
| Einsatz     | Geschäftsprozesse, Webanwendungen, ERP, Schulen |


### Beispiele

| System                | Beschreibung                                           |
|-----------------------|--------------------------------------------------------|
| **MySQL**             | Open Source, weit verbreitet im Web (z. B. mit PHP)   |
| **PostgreSQL**        | Leistungsfähig, für komplexe Anforderungen            |
| **Microsoft SQL Server** | In Unternehmen sehr verbreitet, gute .NET-Integration |
| **Oracle Database**   | Hochperformant, für große Unternehmensumgebungen      |
| **SQLite**            | Kompakt, serverlos, dateibasiert – ideal für Apps oder lokale Tests |


## Nicht-relationale Datenbanksysteme (NoSQL)

> NoSQL-Datenbanken wurden für spezielle Einsatzzwecke entwickelt, z. B. hohe Skalierbarkeit, große Flexibilität oder spezielle Datenformen. Sie sind meist **schemafrei** und **nicht tabellenbasiert**.


### Typen

- **Dokumentenorientiert** (z. B. JSON-Dokumente)
- **Key-Value-Stores**
- **Graphdatenbanken**
- **Zeitreihendatenbanken**


### Beispiele

| System         | Typ                 | Anwendung                          |
|----------------|---------------------|-------------------------------------|
| **MongoDB**    | Dokumentenorientiert| Web-Apps, dynamische Datenmodelle   |
| **Redis**      | Key-Value Store     | Caching, Session-Management         |
| **Neo4j**      | Graphdatenbank      | Netzwerke, Beziehungen, Routenplanung |
| **InfluxDB**   | Zeitreihendatenbank | Sensorik, IoT, Monitoring           |


## Vergleich: RDBMS vs. NoSQL

| Kriterium         | Relationale DB (SQL)             | NoSQL-Datenbanken                |
|-------------------|----------------------------------|----------------------------------|
| Struktur          | Tabellenbasiert                  | Flexibel (z. B. JSON, Schlüssel) |
| Abfragesprache    | SQL                              | Unterschiedlich (z. B. JSON-Query)|
| Konsistenz        | Hoch (ACID)                      | Häufig eventual consistency      |
| Skalierbarkeit    | Vertikal (größerer Server)       | Horizontal (mehrere Server)      |
| Einsatzbeispiel   | ERP, Onlineshop, Schulverwaltung | Big Data, Web-Apps, mobile Systeme |


!!! info "Hinweis zum Lehrplan"
    Laut dem Lehrplan für die Höheren Technischen Lehranstalten (HTL) ist der Schwerpunkt im Bereich Datenbanken auf **relationale Datenbanksysteme (RDBMS)** gelegt.  
    Nicht-relationale Datenbanksysteme (NoSQL) werden im Unterricht **nicht verpflichtend behandelt**, können jedoch ergänzend zur Vertiefung oder im Rahmen von Projekten angesprochen werden.

