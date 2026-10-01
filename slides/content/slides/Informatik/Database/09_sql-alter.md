---
theme: seriph
routerMode: hash
title: SQL - ALTER
info: SQL ALTER TABLE Befehl Übersicht
background: https://raw.githubusercontent.com/HTL-Wolfsberg-Betriebsinformatik/skript/refs/heads/main/slides/content/slides/background-cover-16-9.webp
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

## ALTER TABLE


---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# `ALTER TABLE` - Befehl

Ändert die **Struktur** einer bestehenden Tabelle – die Daten in der Tabelle bleiben erhalten.

Mit `ALTER TABLE` kann man z.B.:

- eine **Spalte hinzufügen** oder **löschen**
- den **Datentyp** einer Spalte ändern
- einen **Constraint** (z.B. `UNIQUE`, `FOREIGN KEY`, `CHECK`) hinzufügen oder entfernen

<br>

> **Wichtig:** `ALTER` ändert die **Struktur** (DDL), nicht die **Daten**.<br>
> Daten werden mit `INSERT`, `UPDATE` und `DELETE` geändert.

---

# Spalte hinzufügen

```sql
ALTER TABLE Student
ADD Email VARCHAR(100);
```

- Die neue Spalte wird **am Ende** der Tabelle angefügt
- Bestehende Zeilen erhalten den Wert `NULL`

Mit `NOT NULL` braucht man einen **Standardwert**, damit bestehende Zeilen befüllt werden können:

```sql
ALTER TABLE Student
ADD IsActive BIT NOT NULL DEFAULT (1);
```

---

# Spalte löschen

```sql
ALTER TABLE Student
DROP COLUMN Email;
```

- Die Spalte wird **inklusive aller Daten** gelöscht ⚠️
- Ist die Spalte Teil eines Constraints (z.B. `DEFAULT`, `FOREIGN KEY`), muss zuerst der **Constraint gelöscht** werden

---

# Datentyp ändern

```sql
ALTER TABLE Student
ALTER COLUMN StudentName VARCHAR(200) NOT NULL;
```

- Funktioniert nur, wenn die **bestehenden Daten** in den neuen Datentyp passen
  - `VARCHAR(50)` → `VARCHAR(200)` ✅
  - `VARCHAR(200)` → `INT` ❌ (wenn Text wie `'Max'` vorhanden ist)
- `NULL` / `NOT NULL` sollte immer mit angegeben werden

---

# Constraints hinzufügen

Constraints werden mit `ADD CONSTRAINT` und einem **Namen** hinzugefügt:

```sql
-- Fremdschlüssel
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customer
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

-- Eindeutigkeit
ALTER TABLE UserAccount
ADD CONSTRAINT UQ_UserAccount_Email UNIQUE (Email);

-- Bedingung
ALTER TABLE Employee
ADD CONSTRAINT CK_Employee_Age CHECK (Age >= 15);
```

- Bestehende Daten müssen den Constraint **bereits erfüllen**, sonst gibt es einen Fehler

---

# Constraints löschen

```sql
ALTER TABLE UserAccount
DROP CONSTRAINT UQ_UserAccount_Email;
```

- Deshalb ist es sinnvoll, Constraints beim Erstellen **selbst zu benennen**
- Ohne Namen vergibt SQL Server einen automatischen Namen (z.B. `UQ__UserAcco__A9D10534F1C8E2B4`)
