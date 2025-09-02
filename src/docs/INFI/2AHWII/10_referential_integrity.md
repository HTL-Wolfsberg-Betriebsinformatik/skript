
## Definition

- **Referentielle Integrität (RI)** stellt sicher, dass **Fremdschlüssel (FK)** nur auf **existierende** Datensätze der Elterntabelle zeigen – und dass Änderungen/Löschungen dort keine **„Waisen“** erzeugen.
- **Formale Regel:** Jeder **nicht-NULL** FK-Wert in der Kindtabelle muss auf einen existierenden **Kandidatenschlüssel** (meist PK) der Elterntabelle verweisen.

!!! example "Typische Fehler ohne RI"
    - Buch zeigt auf author_id=42, Autor mit ID 42 existiert nicht → Waisenzeile.
    - Autor wird gelöscht, Bücher bleiben mit verwaister author_id zurück.

## Bausteine

- Elterntabelle: enthält den referenzierten Schlüssel (PK/UNIQUE).
- Kindtabelle: besitzt den Fremdschlüssel (gleicher Datentyp/Länge!).
- Optionalität: 
    - `NULL` im FK erlaubt → Beziehung optional; 
    - `NOT NULL` → obligatorisch.
- Referentielle Aktionen (bei UPDATE/DELETE am Elternsatz):
    - `CASCADE` – Kindzeilen werden mitgeändert/gelöscht.
    - `SET NULL` – FK wird auf NULL gesetzt (FK muss NULL erlauben).
    - `SET DEFAULT` – FK bekommt Defaultwert (SQL Server).
    - `RESTRICT / NO ACTION` – Operation verboten, wenn abhängige Kindzeilen existieren.

**Beispiel: Autor - Buch:**

=== "SQLite"

    ```sql
    PRAGMA foreign_keys = ON;

    CREATE TABLE author (
        author_id INTEGER PRIMARY KEY,
        name      TEXT NOT NULL UNIQUE
    );

    CREATE TABLE book (
        book_id   INTEGER PRIMARY KEY,
        title     TEXT NOT NULL,
        author_id INTEGER NOT NULL,
        FOREIGN KEY (author_id) REFERENCES author(author_id)
            ON DELETE NO ACTION     -- Löschen eines Autors mit Büchern verbieten
            ON UPDATE CASCADE       -- Änderung der author_id (selten) durchreichen
    );
    ```
=== "MS SQL Server"

    ```sql
    CREATE TABLE Author (
        AuthorID INT IDENTITY(1,1) CONSTRAINT PK_Author PRIMARY KEY,
        Name     NVARCHAR(100) NOT NULL UNIQUE
    );

    CREATE TABLE Book (
        BookID   INT IDENTITY(1,1) CONSTRAINT PK_Book PRIMARY KEY,
        Title    NVARCHAR(200) NOT NULL,
        AuthorID INT NOT NULL,
        CONSTRAINT FK_Book_Author FOREIGN KEY (AuthorID)
            REFERENCES Author(AuthorID)
            ON DELETE NO ACTION     -- Standard: verbieten
            ON UPDATE CASCADE       -- Änderung der AuthorID (selten) durchreichen
    );
    ```

## Lösch-/Update Strategien

**RESTRICT / NO ACTION (verbieten):**

- **Sinnvoll**, wenn Kinder **nicht ohne Eltern** existieren dürfen (Datenqualität).
- Beispiel: `Book` darf nicht ohne `Author`.

**CASCADE (mitlöschen/mitändern):**

- Praktisch bei rein **abhängigen** Daten (z. B. Order → OrderItem).
- Vorsicht bei **großen Kaskaden** (viele Kindtabellen/Zeilen).

**SET NULL / SET DEFAULT (entkoppeln):**

- Für **optionale** Beziehungen, wenn Kinder ohne Eltern existieren dürfen.
- FK-Spalte muss `NULL` bzw. Default zulassen.

!!! hint "Defaultstrategien"
    - In MS SQL Server und SQLite: Standard ist `ON DELETE NO ACTION` und `ON UPDATE NO ACTION`
    - **Achtung:** In SQLite ist die FK-Prüfung ist standardmäßig AUS und muss pro Verbindung aktiviert werden: `PRAGMA foreign_keys = ON;` 