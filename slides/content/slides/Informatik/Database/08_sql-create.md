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

# Primär- und Fremdschüssel

```sql
CREATE TABLE Course (
  Id INT PRIMARY KEY,
  Title NVARCHAR(100) NOT NULL
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

