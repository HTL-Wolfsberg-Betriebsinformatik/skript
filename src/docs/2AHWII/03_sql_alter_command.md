## `ALTER TABLE` - Struktur einer Tabelle ändern

Mit dem SQL Befehl `ALTER TABLE` kann z.B.:

- eine **Spalte hinzugefügt** oder entfernt werden
- der **Datentyp** einer Spalte angepasst werden (eingeschränkt in SQLite)
- eine Spalte **umbenannt** werden
- ein **Constraint** (z. B. `NOT NULL`) gesetzt werden


### Anwendungsfälle

#### Spalte hinzufügen

=== "SQLite"

    ```sql
    ALTER TABLE tabellenname
    ADD COLUMN spaltenname DATENTYP [CONSTRAINT];
    ```

=== "MS SQL Server"

    ```sql
    ALTER TABLE tabellenname
    ADD COLUMN spaltenname DATENTYP [CONSTRAINT];
    ```

#### Spalte umbenennen

=== "SQLite"

    ```sql
    ALTER TABLE tabellenname
    RENAME COLUMN alter_name TO neuer_name;
    ```

=== "MS SQL Server"

    ```sql
    EXEC sp_rename 'tabellenname.alter_name', 'neuer_name', 'COLUMN';
    ```

#### Tabelle umbenennen

=== "SQLite"

    ```sql
    ALTER TABLE alter_tabellenname
    RENAME TO neuer_tabellenname;
    ```

=== "MS SQL Server"

    ```sql
    ALTER TABLE alter_tabellenname
    RENAME TO neuer_tabellenname;
    ```

#### Spalte löschen

=== "SQLite"

    ```sql
    ALTER TABLE tabellenname
    DROP COLUMN spaltenname;
    ```

=== "MS SQL Server"

    ```sql
    ALTER TABLE tabellenname
    DROP COLUMN spaltenname;
    ```

### Datentyp einer Spalte ändern

=== "SQLite"

    ```sql
    -- Nicht direkt möglich in SQLite
    -- Workaround:
    --   1. Alte Tabelle umbenennen
    --   2. Neue Tabelle erstellen, mit korrektem Spaltedatentyp
    --   3. Daten von alt nach neu kopieren (unter Berücksichtigung des neuen Datentyps)
    --   4. Alte Tabelle löschen
    ```

=== "MS SQL Server"

    ```sql
    ALTER TABLE tabellenname
    ALTER COLUMN spaltenname NEUER_DATENTYP;
    ```
