---
theme: seriph
routerMode: hash
title: SQL - CREATE
info: SQL CREATE Befehl Übersicht
background: https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true
class: text-center
drawings:
    persist: false
transition: slide-left
mdc: true
layout: cover
hideInToc: true
download: true
export:
    format: pdf
    dark: false
    withClicks: true
    withToc: true
selectable: true
---

# SQL Befehle

## CREATE - Basics


---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Minimaler Befehl

```sql
CREATE TABLE Student (
  Id INT PRIMARY KEY,
  Name NVARCHAR(100) NOT NULL
);
```

- Jede Tabelle braucht einen Primärschlüssel (`PRIMARY KEY`).
- Datentypen: `INT`, `NVARCHAR`, `DATE`, `BIT`, …

---

# Wichtige Datentypen (MS SQL Server)
| Datentyp          | Beschreibung                 | Beispiel/Format            |
|-------------------|------------------------------|----------------------------|
| `INT` / `BIGINT`  | Ganze (große) Zahl           | `0`, `1`, `-10`            |
| `DECIMAL(p,s)`    | Feste Kommazahl              | `DECIMAL(5,2)` → `123,45` |
| `FLOAT`           | Gleitkommazahl               | `3.14`, `-2.7`             |
| `NVARCHAR(n)` | Unicode-Text (Länge  n) | `N'Text'`, `NVARCHAR(100)` |
| `DATE`            | Datum                        | `'2025-09-10'`             |
| `DATETIME2`       | Datum+Zeit (präzise)         | `'2025-09-10 12:30:00'`    |
| `BIT`             | Wahr/Falsch                  | `0` = FALSE, `1` = TRUE    |


**Tipp:** Für Unicode-Strings in SQL Server **N'…'** verwenden (z. B. `N'Alice'`).

---

# Primär- und Fremdschüssel

```sql
CREATE TABLE Course (
  Id INT PRIMARY KEY,
  Title NVARCHAR(100) NOT NULL  -- Pflichtfeld
);

-- Beispiel für Zwischentabellen
CREATE TABLE StudentCourse (
  StudentCourseId INT PRIMARY KEY,
  StudentId INT,
  CourseId INT,
  FOREIGN KEY (StudentId) REFERENCES Student(Id),
  FOREIGN KEY (CourseId)  REFERENCES Course(Id)
);
```

---

# Unique & Default

```sql
CREATE TABLE Users (
  Id INT PRIMARY KEY,
  Email NVARCHAR(255) UNIQUE,
  IsActive BIT NOT NULL DEFAULT (1)
);
```

- `UNIQUE` = kein doppelter Wert erlaubt
- `DEFAULT` = Standardwert

---

# CHECK Constraints

```sql
CREATE TABLE Employee (
  Id INT PRIMARY KEY,
  Age INT NOT NULL,
  CONSTRAINT CK_Employee_Age CHECK (Age >= 15 AND Age <= 120)
);
```

- `CHECK` überprüft Bedingungen

---

# Zusammenfassung Constraints (Einschränkungen)

| Constraint        | Bedeutung                                 | Beispiel                         |
|------------------|--------------------------------------------|----------------------------------|
| `PRIMARY KEY`    | Eindeutiger Schlüssel                      | `Id INT PRIMARY KEY`             |
| `IDENTITY`       | Auto-Zähler                                | `Id INT IDENTITY(1,1)`           |
| `NOT NULL`       | Darf nicht leer sein                       | `Name NVARCHAR(50) NOT NULL`     |
| `UNIQUE`         | Werte müssen eindeutig sein                | `Email NVARCHAR(255) UNIQUE`     |
| `DEFAULT`        | Standardwert                               | `IsActive BIT DEFAULT 1`         |
| `CHECK`          | Bedingung muss erfüllt sein                | `CHECK (Score BETWEEN 1 AND 10)` |
| `FOREIGN KEY`    | Verweis auf andere Tabelle                 | `UserId INT REFERENCES dbo.Users(UserId)` |


