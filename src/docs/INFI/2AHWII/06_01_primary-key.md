# Primary Keys (Primärschlüssel)

Ein **Primary Key (PK) identifiziert jede Zeile eindeutig**. Er

- ist **eindeutig** (no duplicates)
- ist **NOT NULL** (darf nie leer sein)
- ist **stabil** (ändert sich im Normalfall nicht)

!!! tip "Warum ist das wichtig?"
    Ohne eindeutige Identifikation können Relationen nicht sicher miteinander verknüpft werden, Werte können doppelt vorkommen und Abfragen liefern inkonsistente Ergebnisse.

## Varianten

### Surrogatschlüssel

Künstlicher, bedeutungsloser Schlüssel (z. B. laufende Nummer, GUID).

- **Pro:** kurz, stabil, unabhängig von Fachlogik.
- **Contra:** zusätzliche Spalte, Fachlichkeit steckt nicht im Schlüssel.


### Natürlicher Schlüssel

Ein Schlüssel aus fachlichen Attributen (z. B. `ISBN`, `SVNR`, `IBAN`).

- **Pro:** Fachlichkeit steckt im Schlüssel, keine zusätzliche Spalte
- **Contra:** ändert sich ggf. doch (Fehlerkorrektur, Formatwechsel), kann lang sein


### Zusammengesetzte Schlüssel (Composite Key)

PK besteht aus mehreren Spalten, z. B. student_id + course_id.

- **Typischer Einsatz:** m:n Beziehungen


## Primary Keys definieren

**Beim Erstellen der Tabelle:**

=== "SQLite"

    ```sql
    -- Natürlicher PK
    CREATE TABLE buch (
    isbn TEXT PRIMARY KEY,
    titel TEXT NOT NULL,
    autor TEXT NOT NULL
    );

    -- Surrogat-PK
    CREATE TABLE schueler (
    schueler_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    nachname    TEXT NOT NULL,
    vorname     TEXT NOT NULL
    );

    -- Zusammengesetzter PK
    CREATE TABLE belegung (
    schueler_id INTEGER NOT NULL,
    fach_id     INTEGER NOT NULL,
    semester    INTEGER NOT NULL,
    PRIMARY KEY (schueler_id, fach_id)  -- composite
    );
    ```
=== "MS SQL Server"

    ```sql
    -- Natürlicher PK
    CREATE TABLE Buch (
    ISBN  CHAR(13) PRIMARY KEY,
    Titel NVARCHAR(200) NOT NULL,
    Autor NVARCHAR(100) NOT NULL
    );

    -- Surrogat-PK mit IDENTITY (startet bei 1, Schrittweite 1)
    CREATE TABLE Schueler (
    SchuelerID INT IDENTITY(1,1) PRIMARY KEY,
    Nachname NVARCHAR(50) NOT NULL,
    Vorname NVARCHAR(50) NOT NULL
    );
    
    -- Zusammengesetzter PK
    CREATE TABLE Belegung (
    SchuelerID INT NOT NULL,
    FachID     INT NOT NULL,
    Semester   TINYINT NOT NULL,
    CONSTRAINT PK_Belegung PRIMARY KEY (SchuelerID, FachID)
    );
    ```



