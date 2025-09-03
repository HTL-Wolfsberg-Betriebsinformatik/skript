
- **Gruppierung** fasst Zeilen zu Gruppen zusammen (`GROUP BY`).
- **Aggregatfunktionen** berechnen je Gruppe: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` (+ String-Aggregat).

**Beispiele:**

> Abfrage: Anzahl Filme je Genre (nur Genres mit ≥ 5 Filmen).






## `GROUP_BY`

- Was? Bildet Gruppen von Zeilen, die in den angegebenen Spalten denselben Wert haben.
- Regel: In der SELECT-Liste dürfen nur Aggregatfunktionen und Group-By-Spalten stehen.
- Typisch: „Anzahl Filme je Genre“, „Ø-Laufzeit je Jahr“.

> Abfrage: Durchschnittliche Filmlänge je Jahr

=== "SQLite"

    ```sql
    SELECT substr(release_date,1,4) AS Year, AVG(runtime_min) AS AvgMin
    FROM Movie
    WHERE release_date IS NOT NULL
    GROUP BY substr(release_date,1,4)
    ORDER BY Year;
    ```
=== "MS SQL Server"

    ```sql
    SELECT YEAR(ReleaseDate) AS [Year], AVG(RuntimeMin*1.0) AS AvgMin
    FROM dbo.Movie
    WHERE ReleaseDate IS NOT NULL
    GROUP BY YEAR(ReleaseDate)
    ORDER BY [Year];
    ```

## `HAVING`

- Was? Filtert Gruppen nach der Aggregation (z. B. "nur Gruppen mit `COUNT(*) ≥ 5`").
- Unterschied zu `WHERE`: `WHERE` filtert Zeilen vorher, `HAVING` Gruppen nachher.
- Logische Reihenfolge: `FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`

=== "SQLite"

    ```sql
    SELECT g.name AS Genre, COUNT(*) AS Filmanzahl
    FROM Genre g
    JOIN MovieGenre mg ON mg.genre_id = g.genre_id
    GROUP BY g.name
    HAVING COUNT(*) >= 5
    ORDER BY Filmanzahl DESC;
    ```
=== "MS SQL Server"

    ```sql
    SELECT g.Name AS Genre, COUNT(*) AS Filmanzahl
    FROM dbo.Genre g
    JOIN dbo.MovieGenre mg ON mg.GenreID = g.GenreID
    GROUP BY g.Name
    HAVING COUNT(*) >= 5
    ORDER BY Filmanzahl DESC;
    ```