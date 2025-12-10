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

## CREATE TABLE


---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# `CREATE TABLE` - Befehl

Erstellt eine Tabelle. In der Tabelle werden Spalten angebeben, welche aus einem Spaltennamen, einem Datentyp und optional Einschränkungen (=Constraints)

```sql
CREATE TABLE Student (
  Id INT PRIMARY KEY,
  StudentName VARCHAR(100) NOT NULL
);
```

**Erklärung:**

- Eine Tabelle namens `Student` wird angelegt
- Die Tabelle hat **2 Spalten**:
  - `Id` ist der **Name** der ersten Spalte, mit dem Datentyp `INT` (=ganze Zahl) und dem Constraint, dass es sich um einen **Primary Key** handelt
  - `StudentName` ist der **Name** der zweiten Spalte, mit dem Datentyp `VARCHAR(100)` (=Text mit maximaler Länge von 100 Zeichen) und mit dem Constraint, dass die Spalte **nie leer** (=`NOT NULL`) sein darf 


---

# Wichtige Datentypen (MS SQL Server)
| Datentyp          | Beschreibung                 | Beispiel/Format            |
|-------------------|------------------------------|----------------------------|
| `INT` / `BIGINT`  | Ganze (große) Zahl           | `0`, `1`, `-10`            |
| `DECIMAL(p,s)`    | Feste Kommazahl              | `DECIMAL(5,2)` → `123,45` |
| `FLOAT`           | Gleitkommazahl               | `3.14`, `-2.7`             |
| `VARCHAR(n)`      | Text (Länge  n)              |   `VARCHAR(100)`  → `'Hello World'`|
| `DATE`            | Datum                        | `'2025-09-10'`             |
| `DATETIME2`       | Datum+Zeit (präzise)         | `'2025-09-10 12:30:00'`    |
| `BIT`             | Wahr/Falsch                  | `0` = FALSE, `1` = TRUE    |

---
layout: two-cols-header
layoutClass: gap-8
---

# Primärschüssel

Jede Tabelle braucht einen Primärschlüssel. Es gibt unterschiedliche Varianten von Primärschlüsseln.

::left::

1. Einfache Zahl

<div style="border: 2px solid green;">

```sql
CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  ...
);
```
</div>

2. Automatisch steigende Zahl

```sql
CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ...
);
```

3. GUID / UUID

```sql
CREATE TABLE Session (
    SessionID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ...
);
```
::right::

4. Text

```sql
CREATE TABLE Country (
    CountryCode CHAR(2) PRIMARY KEY, -- 'AT', 'DE', 'CH'
    ...
);
```

5. Zusammengesetzt (Composite Key)

```sql
CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID)
);
```

---

# Fremdschlüssel

Es gibt 2 Varianten einen Fremdschlüssel zu definieren: Inline oder als Constraint

1. Inline (direkt in der Spalte)

```sql
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    ...
);
```

2. Separat (als Table Constraint)

```sql
CREATE TABLE Order (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ...
    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
```

---

# Unique

Ein bestimmter Wert in einer Spalte darf nur einmal vorkommen. (=*Eindeutig*)

1. Inline (direkt in der Spalte)

```sql
CREATE TABLE UserAccount (
    UserID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE -- Fehler, wenn ein zweiter User sich mit einer bestehenden Email registiert
);
```

2. Separat (als Table Constraint)

```sql
CREATE TABLE UserAccount (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    CONSTRAINT UQ_User_Username UNIQUE (Username)
);
```

3. Gemeinsame UNIQUE-Spalten (*Composite* UNIQUE)

```sql
CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    CONSTRAINT UQ_Student_Course UNIQUE (StudentID, CourseID) -- Kombination nur einmal erlaubt
);
```

---

# Fremdschlüssel + Unique

Eine 1:1-Beziehung entsteht, wenn der Foreign Key gleichzeitig `UNIQUE` ist.

**Beispiel: Jeder Mitarbeiter hat genau eine Mitarbeiterkarte.**

```sql
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE EmployeeCard (
    CardID INT PRIMARY KEY,
    EmployeeID INT UNIQUE, -- verhindert 1:n
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
```

**Warum ist das 1:1?**
- Der `FOREIGN KEY` zwingt: jede Karte gehört zu einem Mitarbeiter.
- Das `UNIQUE` zwingt: ein Mitarbeiter kann nur eine Karte haben.


---

# Default

```sql
CREATE TABLE Users (
  Id INT PRIMARY KEY,
  IsActive BIT NOT NULL DEFAULT (1)
);
```

- `DEFAULT` = Standardwert

---

# CHECK

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

| Constraint        | Bedeutung                                 | Umsetzung                        |
|------------------|--------------------------------------------|----------------------------------|
| `PRIMARY KEY`    | Eindeutiger Schlüssel                      | `Id INT PRIMARY KEY`             |
| `FOREIGN KEY`    | Verweis auf andere Tabelle                 | Inline oder Constraint           |
| `NOT NULL`       | Darf nicht leer sein                       | `Name VARCHAR(50) NOT NULL`      |
| `UNIQUE`         | Werte müssen eindeutig sein                | Inline oder Constraint           |
| `DEFAULT`        | Standardwert                               | `IsActive BIT DEFAULT 1`         |
| `CHECK`          | Bedingung muss erfüllt sein                | `CHECK (Score BETWEEN 1 AND 10)` |


