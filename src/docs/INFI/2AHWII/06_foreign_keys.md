## Fremdschüssel – Beziehungen zwischen Tabellen

Ein **Fremdschlüssel (engl. Foreign Key)** ist ein Attribut (Spalte) in einer Tabelle, das auf den **Primärschlüssel einer anderen Tabelle** verweist.

Er stellt sicher, dass **Daten konsistent miteinander verknüpft** werden können.

**Beispiel:**

```text
Tabelle: Movies
film_id | title       | regisseur_id
--------|-------------|--------------
1       | Inception   | 10
2       | Matrix      | 20

Tabelle: Regisseur
regisseur_id | name
-------------|----------------
10           | Christopher Nolan
20           | Lana Wachowski
```

- `regisseur_id` in der Tabelle filme ist ein Fremdschlüssel
- Er verweist auf `regisseur_id` in der Tabelle regisseur

## Warum brauchen wir Fremdschlüssel?

In relationalen Datenbanken werden zusammengehörige Informationen in verschiedenen Tabellen gespeichert.

Ein Fremdschlüssel ist notwendig, um:

- `Daten zu verknüpfen` (z. B. welcher Regisseur hat welchen Film gedreht?)
- `Redundanz zu vermeiden` (Regisseurdaten nur einmal speichern)
- `Referentielle Integrität sicherzustellen` (kein Verweis auf nicht existierende Datensätze)

## Anwendung in SQL

Ein Fremdschlüssel wird typischerweise bei der Tabellenerstellung definiert:

=== "SQLite"

    ```sql
    PRAGMA foreign_keys = ON;

    CREATE TABLE Regisseur (
        regisseur_id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
    );

    CREATE TABLE Movies (
        movie_id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        regisseur_id INTEGER,
        FOREIGN KEY (regisseur_id) REFERENCES regisseur(regisseur_id)
    );

    ```

=== "MS SQL Server"

    ```sql
    CREATE TABLE Regisseur (
        regisseur_id INT PRIMARY KEY,
        name NVARCHAR(100) NOT NULL
    );

    CREATE TABLE Movies (
        movie_id INT PRIMARY KEY,
        title NVARCHAR(200) NOT NULL,
        regisseur_id INT,
        CONSTRAINT fk_regisseur
            FOREIGN KEY (regisseur_id)
            REFERENCES regisseur(regisseur_id)
    );
    ```

!!! tip "Tipp"
    In SQL Server lassen sich Fremdschlüssel auch nachträglich per `ALTER TABLE` hinzufügen oder benennen.


## Zusammenfassung

- Primärschlüssel: Eindeutige Identifikation eines Datensatzes
- Fremdschlüssel: Verweist auf Primärschlüssel in anderer Tabelle
- Referenzielle Integrität: Schutz vor fehlerhaften oder "verwaisten" Verweisen



