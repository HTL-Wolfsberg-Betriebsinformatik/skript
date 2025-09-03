# Tabellen verbinden mit `JOIN`

In relationalen Datenbanken liegen zusammengehörige Daten oft in **verschiedenen Tabellen**.  
Um diese Daten **gemeinsam abzufragen**, wird der SQL-Befehl `JOIN` verwendet.

---

## Warum braucht man `JOIN`?

Einzelne Tabellen enthalten **nur einen Teil der Information**:

- Die Tabelle `Movies` kennt die `regisseur_id`, aber nicht den Namen des Regisseurs.
- Die Tabelle `Regisseur` kennt den Namen, aber nicht die Filme in die er/sie Regie geführt hat.

Um diese Informationen zu kombinieren, braucht man eine **Verknüpfung über den Fremdschlüssel**.

---

## Grundsyntax: `INNER JOIN`

```sql
SELECT tab1.spalte1, tab2.spalte2
FROM tabelle1 AS tab1
JOIN tabelle2 AS tab2
ON tab1.fk = tab2.pk;
```

- `JOIN` bedeutet standardmäßig `INNER JOIN`
- `ON` gibt die Verbindungsbedingung an (meist über Primär- und Fremdschlüssel)
- Tabellen können mit Aliassen (`AS`) abgekürzt werden

---

## Beispiel: Filme und Regisseure

```bash
Movies(movie_id, title, regisseur_id)
Regisseur(regisseur_id, name)
```

=== "SQLite"

    ```sql
    SELECT m.titel, r.name
    FROM Movie AS m
    JOIN Regisseur AS r
    ON m.regisseur_id = r.regisseur_id;
    ```

=== "MS SQL Server"

    ```sql
    SELECT m.titel, r.name
    FROM Movie AS m
    JOIN Regisseur AS r
    ON m.regisseur_id = r.regisseur_id;
    ```

!!! info "Ausgabe"
    Gibt eine Liste aller Filme mit den zugehörigen Namen der Regisseure aus.


## Weitere JOIN-Typen

### `LEFT JOIN` (oder `LEFT OUTER JOIN`)
- Gibt alle Datensätze aus der linken Tabelle zurück.
- Falls es keine Übereinstimmung in der rechten Tabelle gibt, werden die Werte dort als NULL angezeigt.

=== "SQLite"

    ```sql
    SELECT m.titel, r.name
    FROM Movies AS m
    LEFT JOIN regisseur AS r
    ON m.regisseur_id = r.regisseur_id;
    ```

=== "MS SQL Server"

    ```sql
    SELECT m.titel, r.name
    FROM Movies AS m
    LEFT JOIN regisseur AS r
    ON m.regisseur_id = r.regisseur_id;
    ```


### `RIGHT JOIN` (nur in SQL Server, nicht SQLite)
- Gibt alle Datensätze aus der rechten Tabelle zurück.

### `FULL OUTER JOIN` (nur in SQL Server, nicht SQLite)
- Gibt alle Datensätze beider Tabellen zurück, auch wenn es keine Übereinstimmungen gibt.