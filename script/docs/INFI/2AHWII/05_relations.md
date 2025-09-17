
Nachdem grundlegende SQL-Befehle wie `CREATE`, `INSERT`, `SELECT`, `ALTER` oder `DROP` bekannt sind, ist es sinnvoll, die **strukturelle Grundlage relationaler Datenbanken** zu verstehen: das **Relationenmodell**.


## Was ist eine Relation?

In der Datenbanktheorie ist eine **Relation** eine **Tabelle**, bestehend aus:

- **Zeilen (Tupel)** → einzelne Datensätze
- **Spalten (Attribute)** → Felder mit bestimmten Datentypen

> Eine **Relation** beschreibt also eine **Menge gleich strukturierter Daten** – zum Beispiel alle Filme, alle Kunden oder alle Rechnungen.

Beispiel einer Relation `Filme`:

| movie_id | title        | genre    | jahr |
|----------|--------------|----------|------|
| 1        | Inception    | Sci-Fi   | 2010 |
| 2        | Parasite     | Drama    | 2019 |
| 3        | Matrix       | Action   | 1999 |

---

## RDBMS – Relationale Datenbankmanagementsysteme

Ein **RDBMS** (Relationales Datenbankmanagementsystem) ist eine Software zur **Verwaltung relationaler Datenbanken**.

Beispiele:

- **SQLite** (einfach, lokal, dateibasiert)
- **Microsoft SQL Server**
- **MySQL**
- **PostgreSQL**

Alle basieren auf dem **Relationalen Modell** nach Edgar F. Codd.

---

## Wie stehen Relationen zueinander?

Einzelne Relationen können miteinander in Beziehung stehen – z. B.:

- Ein Kunde hat mehrere Bestellungen
- Ein Film kann in mehreren Kinos gezeigt werden
- Ein Lehrer unterrichtet mehrere Klassen

Solche **Beziehungen zwischen Tabellen** werden über Schlüssel (**Primärschlüssel** und **Fremdschlüssel**) hergestellt.
