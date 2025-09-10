## `CREATE TABLE` - Tabellen erstellen

Mit dem SQL-Befehl `CREATE TABLE` wird eine **neue Tabelle in einer Datenbank angelegt**. Dabei werden die Spaltennamen, Datentypen und ggf. Einschränkungen (Constraints) definiert.


```sql
CREATE TABLE tabellenname (
    spalte1 DATENTYP [CONSTRAINT],
    spalte2 DATENTYP [CONSTRAINT],
    ...
);
```

### Datentypen

Ein **Datentyp** legt fest, welche Art von Daten in einer Spalte gespeichert werden darf.

| Datentyp          | Beschreibung                             | Beispiele                      |
|-------------------|------------------------------------------|--------------------------------|
| `INTEGER`, `INT`  | Ganze Zahl                               | `1`, `-10`, `0`                |
| `REAL`, `FLOAT`   | Kommazahl / Gleitkommazahl               | `3.14`, `-2.7`                 |
| `TEXT`            | Zeichenkette (Text, z. B. bei SQLite)    | `'Matrix'`                     |
| `VARCHAR(n)`      | Text mit maximaler Länge `n`             | `'Test'`, `VARCHAR(100)`       |
| `DATE`            | Datum (je nach DBMS-Format)              | `'2023-09-01'`                 |
| `BOOLEAN`, `BIT`  | Wahr/Falsch-Wert (DB-abhängig)           | `TRUE`, `FALSE` oder `1`, `0`  |


### Constraints (Einschränkungen)

**Constraints** sorgen dafür, dass nur **gültige und konsistente Daten** gespeichert werden.

| Constraint         | Bedeutung                                            | Beispiel                                |
|--------------------|-----------------------------------------------------|-----------------------------------------|
| `PRIMARY KEY`      | Eindeutiger Schlüssel der Tabelle                   | `film_id INTEGER PRIMARY KEY`           |
| `NOT NULL`         | Spalte darf nicht leer bleiben                      | `titel TEXT NOT NULL`                   |
| `UNIQUE`           | Jeder Wert muss eindeutig sein                      | `email TEXT UNIQUE`                     |
| `DEFAULT`          | Vorgabewert, wenn kein Wert eingegeben wird         | `genre TEXT DEFAULT 'Unbekannt'`        |
| `CHECK (Bedingung)`| Wert muss Bedingung erfüllen                        | `dauer INTEGER CHECK (dauer > 0)`       |
| `FOREIGN KEY`      | Verweist auf Schlüssel einer anderen Tabelle        | `film_id INTEGER REFERENCES filme(film_id)` |


**Beispiel:** 

=== "SQLite"

    ```sql
    CREATE TABLE Movies (
        movie_id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        genre TEXT DEFAULT 'Unbekannt',
        duration_in_minutes INTEGER CHECK (duration_in_minutes > 0)
        published DATE,
        has_oscar BOOLEAN DEFAULT FALSE,
        rating REAL CHECK (rating BETWEEN 1 AND 10)
    );
    ```

=== "MS SQL Server"

    ```sql
    CREATE TABLE Movies (
        movie_id INT PRIMARY KEY IDENTITY(1,1), -- IDENTITY(1, 1) vergibt ID automatisch
        title NVARCHAR(100) NOT NULL,
        genre NVARCHAR(50) DEFAULT 'Unbekannt',
        duration_in_minutes INT CHECK (duration_in_minutes > 0),
        published DATE,
        has_oscar BIT DEFAULT 0,
        rating FLOAT CHECK (rating BETWEEN 1 AND 10)
    );
    ```

**Erklärung:**

- `movie_id` ist Primärschlüssel → eindeutig
- `title` ist Pflichtfeld
- `genre` hat 'Unbekannt' als Standardwert
- `duration_in_minutes` muss größer als 0 sein
- `published` muss ein gültiges Datum sein
- `has_oscar` ist ein Wert ist der nur 2 Werte beinhalten kann (WAHR (1), FALSCH (0) → Standardwert)
- `rating` ist eine Gleitkommazahl und muss zwischen 1 und 10 sein



## `DROP TABLE` - Tabellen löschen

Mit `DROP TABLE` wird eine ganze Tabelle vollständig gelöscht, inklusive aller Daten und Strukturen.

```sql
DROP TABLE tabellenname;
```

!!! danger "Unwiderruflich"
    Der Befehl `DROP TABLE` löscht sofort und ohne Rückfrage die gesamte Tabelle und deren Inhalte.
    Vor dem Löschen sollte unbedingt ein Backup erstellt werden.

**Beispiel:** 

=== "SQLite"

    ```sql
    DROP TABLE Movies;
    ```

=== "MS SQL Server"

    ```sql
    DROP TABLE Movies;
    ```

!!! tip "Tipp zur Praxis"
    Wenn Tabellen versehentlich gelöscht oder geändert wurden, hilft nur ein vorher angelegtes Backup.
    In Entwicklungsumgebungen ist es sinnvoll, Änderungen zuerst auf einer **Testkopie** der Datenbank auszuprobieren.