## `SELECT` - Daten abfragen

Mit dem SQL-Befehl `SELECT` können **bestehende Daten** aus einer oder mehreren Tabellen **abgerufen** werden.  
Er ist einer der wichtigsten Befehle zur **Analyse, Auswertung und Darstellung** von Daten in relationalen Datenbanken.

```sql
SELECT spalte1, spalte2, ...
FROM tabellenname
[WHERE bedingung]
[ORDER BY spalte ASC|DESC]
```

!!! info
    - Es können alle oder ausgewählte Spalten abgefragt werden
    - Mit `WHERE` wird die Abfrage auf bestimmte Datensätze eingeschränkt
    - Mit `ORDER BY` wird das Ergebnis sortiert


**Beispiel: Alle Datensätze anzeigen** 

=== "SQLite"

    ```sql
    SELECT * FROM Movies;
    
    ```

=== "MS SQL Server"

    ```sql
    SELECT * FROM Movies;

    ```

---
**Beispiel: Nur bestimmte Spalten anzeigen** 

=== "SQLite"

    ```sql
    SELECT title, genre FROM Movies;
    ```

=== "MS SQL Server"

    ```sql
    SELECT title, genre FROM Movies;
    ```

---
**Beispiel: Nur bestimmte Filme anzeigen** 

=== "SQLite"

    ```sql
    -- Zeige nur Filme mit dem Genre "Drama"
    SELECT * FROM Movies WHERE genre = 'Drama';

    -- Zeige nur Filme mit einer Bewertung von mindestens 8.5
    SELECT title, rating FROM Movies WHERE rating >= 8.5;
    ```

=== "MS SQL Server"

    ```sql
    -- Zeige nur Filme mit dem Genre "Drama"
    SELECT * FROM Movies WHERE genre = 'Drama';

    -- Zeige nur Filme mit einer Bewertung von mindestens 8.5
    SELECT title, rating FROM Movies WHERE rating >= 8.5;
    ```

---
**Beispiel: Filme sortieren** 

=== "SQLite"

    ```sql
    -- Gib die Filme absteigend nach Erscheinungsjahr aus
    SELECT title, published FROM Movies ORDER BY published DESC;    
    ```

=== "MS SQL Server"

    ```sql
    -- Gib die Filme absteigend nach Erscheinungsjahr aus
    SELECT title, published FROM Movies ORDER BY published DESC; 
    ```

---
**Beispiel: Kombination von Bedingungen (AND, OR)** 

=== "SQLite"

    ```sql
    -- Gib die Filme mit dem Genre "Drama" und einer Mindestbewertung von 8.0 aus
    SELECT title, genre, rating FROM filme WHERE genre = 'Drama' AND rating > 8.0;

    -- Gib die Filme mit einem Oscar oder einer Mindestbewertung von 8.0 aus
    SELECT title, genre, rating FROM filme WHERE has_oscar = TRUE OR rating > 8.0;
    ```

=== "MS SQL Server"

    ```sql
    -- Gib die Filme mit dem Genre "Drama" und einer Mindestbewertung von 8.0 aus
    SELECT title, genre, rating FROM filme WHERE genre = 'Drama' AND rating > 8.0;

    -- Gib die Filme mit einem Oscar oder einer Mindestbewertung von 8.0 aus
    SELECT title, genre, rating FROM filme WHERE has_oscar = 1 OR rating > 8.0;
    ```

