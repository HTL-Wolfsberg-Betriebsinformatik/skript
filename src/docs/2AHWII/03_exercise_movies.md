## SQLite-Übung: Filme verwalten

Die Firma `Nitflex` hat eine große Liste aller Filme in einer .csv-Datei gespeichert.
Jedes Mal, wenn Nutzer:innen nach einem Film suchen oder neue Filme laden wollen, ist das System langsam, unübersichtlich und es gibt Probleme mit gleichzeitigen Zugriffen.

**Ziel**: `Nitflex` möchte ihre Filme effizienter verwalten. 

**Die Lösung:** eine relationale Datenbank.

## Einstieg: CSV-Datei als Schwachstelle

- Was ist eine CSV-Datei?
- Warum ist das keine gute Lösung bei vielen Daten?
- Was passiert, wenn zwei gleichzeitig schreiben?
- Wie kann man Abfragen wie "alle Filme ab 2015 mit Genre `Action` schnell machen?


## Lernziele

Die Schülerinnen und Schüler sollen:

- eine SQLite-Datenbank erstellen  
- Tabellen mit `CREATE TABLE` anlegen  
- Datensätze mit `INSERT INTO` einfügen  
- einfache SQL-Abfragen mit `SELECT`, `WHERE`, `ORDER BY` durchführen  

## Voraussetzungen

- SQLite CLI ist installiert  
- Optional: visuelle Tools wie [DB Browser for SQLite](https://sqlitebrowser.org/)  


## Schritt-für-Schritt-Anleitung

### SQLite-Datenbank erstellen

Erstellt und/oder öffnet die Datei netflix.db.
Im Prompt `sqlite>` können **SQL-Befehle** eingegeben werden.

```bash
sqlite3 netflix.db
``` 

!!! info
    Zum Verlassen des Prompt den Befehl `.quit` eingeben.

### Tabelle `Movies` erstellen

```sql
CREATE TABLE Movies (
    movie_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    published_year INTEGER,
    genre TEXT,
    duration_in_minutes INTEGER
);
```

!!! info
    Um zu erfahren, welche Tabellen du angelegt wurdne, kann der Befehl `.tables` ausgeführt werden.

    ```sql
    .tables
    -- Zeigt die Namen aller angelegten Tabellen
    Movies
    ```

    Um das Schema der Tabelle aufzurufen, kann der Befehl `schema <TabellenName>`

    ```sql
    .schema Movies
    -- Output
    CREATE TABLE Movies (
        movie_id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        published_year INTEGER,
        genre TEXT,
        duration_in_minutes INTEGER
    );
    ``` 

### Daten einfügen

```sql
INSERT INTO Movies (title, published_year, genre, duration_in_minutes)
VALUES ('Inception', 2010, 'Science Fiction', 148);

INSERT INTO Movies (title, published_year, genre, duration_in_minutes)
VALUES ('The Matrix', 1999, 'Action', 136);

INSERT INTO Movies (title, published_year, genre, duration_in_minutes)
VALUES ('Interstellar', 2014, 'Science Fiction', 169);
```

### Daten abfragen

```sql
-- Nur Science-Fiction-Filme anzeigen
SELECT * FROM Movies WHERE genre = 'Science Fiction';

-- Nur Science-Fiction-Filme anzeigen, davon nur Titel und Erscheinungsjahr
SELECT title, published_year FROM Movies WHERE genre = 'Science Fiction';

-- Filme nach Jahr absteigend sortieren
SELECT * FROM Movies ORDER BY published_year DESC;

-- Filme nach Jahr aufsteigend sortieren
SELECT * FROM Movies ORDER BY published_year ASC;

```