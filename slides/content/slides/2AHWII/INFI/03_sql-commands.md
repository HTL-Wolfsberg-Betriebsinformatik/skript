---
theme: seriph

title: SQL (MS SQL Server) – Erste Schritte
info: Grundlagen & erste Befehle in T-SQL
background: https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true
class: text-center
drawings:
    persist: false
transition: slide-left
mdc: true
layout: cover
hideInToc: true
---

# SQL

## Was & Wofür?

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Definition

**SQL** = *Structured Query Language*

Standardisierte Sprache zur **Kommunikation mit relationalen Datenbanken**.

- **Erstellen:** Erstelle eine Tabelle
- **Einfügen:** Füge Daten in meine Tabelle ein
- **Abfragen:** Welche Daten sind in meiner Tabelle?
- **Ändern:** Ändere einige Daten in meiner Tabelle 
- **Löschen:** Lösche einige Daten aus meiner Tabelle  
- **...**

---

# Warum SQL?

Relationale Datenbanken speichern Daten in **Tabellen**. 
<br/> Mit SQL verwaltest du diese gezielt.

**Typische Aufgaben:**
- gezielte Suche nach Datensätzen
- Eingabe & Aktualisierung von Informationen
- Erstellung/Änderung von Tabellenstrukturen
- Verbinden von Tabellen

---

# Eigenschaften von SQL
- **Nicht case-sensitiv:** `SELECT` = `select`
- **Standardisiert**, aber je DBMS leicht unterschiedlich (hier: **MS SQL Server / T-SQL**)
- Befehle folgen einer **klaren Struktur** mit Schlüsselwörtern

<br/>

> **Merke:** SQL ist das zentrale Werkzeug für Webshops, Verwaltungssoftware, Schul- und Bank-Systeme.

---

# Erste Schritte in T-SQL (MS SQL Server)

Datenbank anlegen und verwenden:

```sql
 CREATE DATABASE School;
```

---

# CREATE TABLE – Tabellen erstellen
Mit `CREATE TABLE` legst du Spalten, Datentypen und Constraints fest.

Allgemeines Muster (vereinfacht):

```sql
CREATE TABLE dbo.Tabellenname (
  spalte1 DATENTYP [CONSTRAINTS],
  spalte2 DATENTYP [CONSTRAINTS]
  -- ...
);
```

---

# Wichtige Datentypen (MS SQL Server)
| Datentyp          | Beschreibung                 | Beispiel/Format            |
|-------------------|------------------------------|----------------------------|
| `INT` / `BIGINT`  | Ganze (große) Zahl           | `0`, `1`, `-10`            |
| `DECIMAL(p,s)`    | Feste Kommazahl              | `DECIMAL(10,2)` → `123,45` |
| `FLOAT`           | Gleitkommazahl               | `3.14`, `-2.7`             |
| `NVARCHAR(n)` | Unicode-Text (Länge  n) | `N'Text'`, `NVARCHAR(100)` |
| `DATE`            | Datum                        | `'2025-09-10'`             |
| `DATETIME2`       | Datum+Zeit (präzise)         | `'2025-09-10 12:30:00'`    |
| `BIT`             | Wahr/Falsch                  | `0` = FALSE, `1` = TRUE    |


**Tipp:** Für Unicode-Strings in SQL Server **N'…'** verwenden (z. B. `N'Alice'`).

---

# Wichtige Constraints (Einschränkungen)
| Constraint        | Bedeutung                                 | Beispiel                         |
|------------------|--------------------------------------------|----------------------------------|
| `PRIMARY KEY`    | Eindeutiger Schlüssel                      | `Id INT PRIMARY KEY`             |
| `IDENTITY`       | Auto-Zähler                                | `Id INT IDENTITY(1,1)`           |
| `NOT NULL`       | Darf nicht leer sein                       | `Name NVARCHAR(50) NOT NULL`     |
| `UNIQUE`         | Werte müssen eindeutig sein                | `Email NVARCHAR(255) UNIQUE`     |
| `DEFAULT`        | Standardwert                               | `IsActive BIT DEFAULT 1`         |
| `CHECK`          | Bedingung muss erfüllt sein                | `CHECK (Score BETWEEN 1 AND 10)` |
| `FOREIGN KEY`    | Verweis auf andere Tabelle                 | `UserId INT REFERENCES dbo.Users(UserId)` |

---

# Beispiel: Tabelle „Movies“

Mit dem Befehl `CREATE` können **Tabellen erstellt** werden

```sql
CREATE TABLE Movies (
  movie_id INT IDENTITY(1,1) PRIMARY KEY,   -- Automatische IDs
  title NVARCHAR(100) NOT NULL,             -- Pflichtfeld
  genre NVARCHAR(50),
  duration_in_minutes INT,
  published DATE,
  has_oscar BIT,
  rating DECIMAL(3,1)
);
```

---

# INSERT – Datensätze einfügen

Mit dem Befehl `INSERT` können **Datensätze** in Tabellen **eingefügt** werden

```sql
INSERT INTO Movies (title, genre, duration_in_minutes, published, has_oscar, rating)
VALUES
  (N'The Matrix', N'Sci-Fi', 136, '1999-03-31', 1, 9.0),
  (N'Inception',  N'Thriller', 148, '2010-07-16', 1, 8.8);
```

---

# SELECT – Daten abfragen

Mit dem Befehl `SELECT` können **Datensätze abgefragt** werden

```sql
-- alle Spalten
SELECT * FROM Movies;

-- bestimmte Spalten, sortiert
SELECT title, rating
FROM Movies
ORDER BY rating DESC;

-- gefiltert
SELECT title, genre, rating
FROM Movies
WHERE genre = N'Sci-Fi' AND rating >= 8.5;
```

---

# UPDATE – Daten ändern

Mit dem Befehl `UPDATE` können **Datensätze geändert** werden

```sql
UPDATE Movies
SET rating = 9.1
WHERE title = N'The Matrix';
```
<br/>

# DELETE – Daten löschen

Mit dem Befehl `DELETE` können **Datensätze gelöscht** werden

```sql
DELETE FROM Movies
WHERE title = N'Inception';
```

---

# DROP TABLE – Tabelle entfernen

Mit dem Befehl `DROP TABLE` wird die Tabelle mit ihren Daten gelöscht

```sql
DROP TABLE Movies;
```