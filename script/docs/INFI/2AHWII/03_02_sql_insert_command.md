## `INSERT INTO` - Datensätze einfügen

Mit dem SQL-Befehl `INSERT INTO` werden **neue Datensätze** in eine bestehende Tabelle eingefügt.

```sql
INSERT INTO tabellenname (spalte1, spalte2, ...)
VALUES (wert1, wert2, ...);
```

!!! info
    - Die **Spaltennamen** werden in der Klammer angegeben.
    - Die **Werte** müssen zur Reihenfolge und zu den Datentypen passen.
    - **Textwerte werden in einfache Anführungszeichen** gesetzt ('Text'), Zahlen nicht.


**Beispiel:** 

=== "SQLite"

    ```sql
    INSERT INTO Movies (title, genre, duration_in_minutes, published, has_oscar, rating)
    VALUES ('The Matrix', 'Action', 136, '1999-03-31', FALSE, 8.7);
    ```

=== "MS SQL Server"

    ```sql
    INSERT INTO Movies (title, genre, duration_in_minutes, published, has_oscar, rating)
    VALUES (N'The Matrix', N'Action', 136, '1999-03-31', 0, 8.7);
    -- N'...' für Unicode-Zeichenkette
    -- rating: 1 = TRUE, 0 = FALSE 
    ```

    !!! info "Unicode-Zeichenkette"
        In Microsoft SQL Server werden Texte standardmäßig im **ASCII-Zeichensatz** gespeichert – das bedeutet:  
        Nur Zeichen des englischen Alphabets (ohne Umlaute, Sonderzeichen oder andere Sprachen) sind ohne Weiteres garantiert darstellbar.

        **Unicode** ist ein internationaler Standard zur Darstellung von Schriftzeichen aus praktisch **allen Sprachen der Welt** – z. B.:
        - 🇩🇪 Deutsch: `ä`, `ö`, `ü`, `ß`
        - 🇷🇺 Kyrillisch: `привет`
        - 🇯🇵 Japanisch: `こんにちは`
        - 🇹🇷 Türkisch: `ş`, `ğ`
        - Symbole & Emojis: `✓`, `⚠️`

        Wenn man in SQL Server **Texte mit Sonderzeichen oder internationalen Zeichen** speichern möchte, muss man vor der Zeichenkette **ein `N` setzen**.

## `UPDATE` – Datensätze ändern

Der Befehl `UPDATE` verändert **bestehende Werte** in einer oder mehreren Spalten.

```sql
UPDATE tabellenname
SET spalte1 = wert1, spalte2 = wert2, ...
WHERE bedingung;
```

!!! danger "Achtung"
    - Ohne WHERE-Klausel werden alle Zeilen geändert!
    - SET gibt die neuen Werte für bestimmte Spalten an.

**Beispiel:**

=== "SQLite"

    ```sql
    UPDATE Movies
    SET genre = 'Science Fiction'
    WHERE title = 'Inception';
    ```

=== "MS SQL Server"

    ```sql
    UPDATE Movies
    SET genre = 'Science Fiction'
    WHERE title = 'Inception';
    ```


## `DELETE` - Datensätze löschen

Der Befehl `DELETE` entfernt eine oder mehrere Zeilen aus einer Tabelle.

```sql
DELETE FROM tabellenname
WHERE bedingung;
```

!!! danger "Achtung"
    - Auch hier gilt: Ohne WHERE werden alle Daten gelöscht!

**Beispiel:**

=== "SQLite"

    ```sql
    DELETE FROM Movies WHERE rating < 5.0;
    ```

=== "MS SQL Server"

    ```sql
    DELETE FROM filme WHERE rating < 5.0;
    ```
