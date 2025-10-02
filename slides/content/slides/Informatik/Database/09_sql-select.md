---
theme: seriph

title: SQL - SELECT
info: SQL SELECT Befehl Übersicht
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

## SELECT - Basics


---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Alle Spalten anzeigen

```sql
SELECT * FROM Student;
```

- `*` = alle Spalten
- **Nicht empfohlen** für große Tabellen (besser Spalten angeben)

---

# Bestimmte Spalten auswählen

```sql
SELECT Name, Age
FROM Student;
```

- Nur die angegebenen Spalten werden gezeigt

---

# Spalten umbenennen

```sql
SELECT Name AS StudentName, Age AS Years
FROM Student;
```

- `AS` gibt einer Spalte einen neuen Namen in der Ausgabe.

---

# Berechnete Spalten

<br>

**Zeichenketten zusammenfügen:**

```sql
SELECT FirstName + ' ' + LastName AS FullName
FROM Student;
```

**Mathematische Operatoren:**

```sql
SELECT Price, Quantity, 
       Price * Quantity AS Total
FROM OrderItem;
```

- Rechnen mit Spalten ist möglich (+, -, *, /).
- Ergebnis bekommt oft einen Alias (hier: `Total`).

---

# Ergebnisse filtern (WHERE)

```sql
SELECT Name, Age
FROM Student
WHERE Age >= 18;
```

- `WHERE` = Bedingungen für Zeilen
- Vergleichsoperatoren: `=`, `<`, `>`, `<=`, `>=`, `<>` (NOT/UNGLEICH)

---

# Pattern Matching mit `LIKE`

```sql
SELECT Name, Email
FROM Student
WHERE Name LIKE 'A%';
```

- `'A%'` = alle Namen, die mit A beginnen.
- `'%NIE%'` = alle Namen, die NIE beinhalten.
- `%` = beliebig viele Zeichen

```sql
SELECT Name, Email
FROM Student
WHERE Name LIKE '___E%';
```

- `_` (Unterstrich) = genau ein beliebiges Zeichen
- `___E%` = drei beliebige Zeichen, dann ein `E`, danach beliebig viele Zeichen 

---

# `IS NULL` filtern

```sql
SELECT Name, Email
FROM Student
WHERE Email IS NULL;
```

- `IS NULL` → prüft, ob ein Wert fehlt (`NULL`).
- Wichtig: `= NULL` funktioniert nicht in SQL!
- Gegenteil: `IS NOT NULL`.

---

# Bereich ausschließen

```sql
SELECT Title, Year
FROM Movie
WHERE Year NOT BETWEEN 2000 AND 2010;
```

- Zeigt alle Filme, die nicht zwischen 2000 und 2010 erschienen sind.
- Ergebnis: nur Filme vor 2000 oder nach 2010.

---

# Bedingungen kombinieren

```sql
SELECT Name, Age
FROM Student
WHERE Age >= 18 AND Age < 30;
```

- `AND` = beide Bedingungen müssen stimmen
- `OR` = mindestens eine Bedingung muss stimmen
- `NOT` = Negation

---

# Bereich ein- bzw auschließen

```sql
SELECT Name, Department
FROM Employee
WHERE UPPER(Department) NOT IN ('HR', 'FINANCE');
```

- `IN` (...) prüft, ob ein Wert in einer Liste vorkommt.
- `NOT IN` (...) schließt diese Werte aus.
- `UPPER`(...) sorgt dafür, dass Groß-/Kleinschreibung keine Rolle spielt.

---

# Sortieren (ORDER BY)

```sql
SELECT Name, Age
FROM Student
ORDER BY Age DESC;
```

- `ORDER BY` = Reihenfolge festlegen
- `ASC` = aufsteigend (Standard)
- `DESC` = absteigend
- Es können auch mehrere Spalten angegeben werden (e.g. `ORDER BY Age ASC, Salary DESC`)

