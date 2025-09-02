## Definition

Ein Index ist eine zusätzliche Datenstruktur, die das schnelle Auffinden von Zeilen anhand von Spaltenwerten ermöglicht – ähnlich einem Buchverzeichnis.

**Wirkung:**
- `SELECT`/`JOIN`/`ORDER BY` wird schneller
- Mehr Speicher und zeitlicher Overhead bei INSERT/UPDATE/DELETE (Index muss mitgepflegt werden).

!!! tip "Merke"
    Indexe lohnen sich besonders bei selektiven Spalten (viele unterschiedliche Werte) und bei Join- & Filterspalten (`WHERE`/`JOIN`/`ORDER BY`).

## Arten von Indizes

- **Single-Column**
- **Composite (mehrspaltig)**
    - **Leftmost-Prefix-Regel:** Ein Index (`A, B, C`) unterstützt Suchen nach `A`, `A,B`, `A,B,C` – aber nicht nach B allein.
- **UNIQUE-Index:** Erzwingt Eindeutigkeit (fachliche Integrität + Performance).
- **Covering Index:** Abfrage kann komplett aus dem Index beantwortet werden (alle benötigten Spalten sind im Index enthalten) → vermeidet Lookup.
- **Clustered/Nicht-clustered (SQL Server):** Der clustered Index bestimmt die physische Sortierung der Tabelle (pro Tabelle max. 1).

## Typische Einsatzfälle

- **Join/FK-Spalten:** FK-Spalten indexieren!
- **Häufige Filter:** WHERE status = 'open' AND created_at >= ... → Index (status, created_at).
- **Sortierung:** ORDER BY created_at DESC → Index auf created_at (ggf. unterschiedliche Sortierstrategien).
- **Eindeutigkeit:** E-Mail/Kürzel/ISBN → UNIQUE.

## Beispiele und Syntax

### Index anlegen / löschen

=== "SQLite"

    ```sql
    -- Einspaltig: schneller Suchen/Sortieren nach Buchtitel
    CREATE INDEX idx_Book_Title ON "Book"(Title);

    -- Mehrspaltig (Composite): häufige Filterkombination
    CREATE INDEX idx_Order_Status_CreatedAt ON "Order"(Status, CreatedAt);

    -- UNIQUE: fachliche Eindeutigkeit + schneller Lookup
    CREATE UNIQUE INDEX ux_User_Email ON "User"(Email);

    -- Löschen
    DROP INDEX IF EXISTS idx_Book_Title;
    ```
=== "MS SQL Server"

    ```sql
    -- Einspaltig
    CREATE INDEX IX_Book_Title ON dbo.Book(Title);

    -- Mehrspaltig (Leftmost-Prefix beachten)
    CREATE INDEX IX_Order_Status_CreatedAt ON dbo.[Order](Status, CreatedAt);

    -- UNIQUE
    CREATE UNIQUE INDEX UX_User_Email ON dbo.[User](Email);

    -- Löschen
    DROP INDEX IX_Book_Title ON dbo.[Order];
    ```
    
