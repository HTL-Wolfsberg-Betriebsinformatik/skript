---
theme: seriph

title: SQL - SELECT - Funktionen
info: SQL SELECT Funktionen Übersicht
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

## SELECT - Funktionen

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Zeichenkettenfunktionen: Länge

```sql
SELECT Name, LEN(Name) AS NameLength
FROM Employee;
```

- LEN() gibt die Anzahl der Zeichen zurück

| Name   | NameLength |
| ------ | ---------- |
| Anna   | 4          |
| Markus | 6          |
| Ben    | 3          |
| Carla  | 5          |
| David  | 5          |


---

# Summe bilden

```sql
SELECT SUM(Price) AS Gesamt
FROM Products;
```

- `SUM()` addiert alle Werte

| Gesamt |
| ------ |
| 12     |


---

# NULL-Werte ersetzen

```sql
SELECT AVG(ISNULL(Bonus, 250)) AS Durchschnitt
FROM Employees;
```

- `ISNULL(Spalte, Ersatzwert)` → ersetzt `NULL`

| Durchschnitt |
| ------------ |
| 280          |


---

# Zählen mit Bedingungen

```sql
SELECT
  SUM(CASE WHEN Discount IS NOT NULL THEN 1 ELSE 0 END) AS MitRabatt,
  SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS OhneRabatt
FROM Orders;

```

- `CASE` = bedingte Zählung

| MitRabatt | OhneRabatt |
| --------- | ---------- |
| 3         | 2          |


---

# Unterschiedliche Werte zählen

```sql
SELECT COUNT(DISTINCT Category) AS VerschiedeneKategorien
FROM Products;
```

- `COUNT(DISTINCT ...)` → nur verschiedene Werte

| VerschiedeneKategorien |
| ---------------------- |
| 3                      |


---

# Mehrere Aggregatfunktionen

```sql
SELECT
  SUM(Amount) AS Summe,
  COUNT(*) AS Anzahl,
  AVG(Amount) AS Durchschnitt
FROM Orders;
```

- Kombination von `SUM`, `COUNT`, `AVG`

| Summe | Anzahl | Durchschnitt |
| ----- | ------ | ------------ |
| 800   | 5      | 160          |


---

# Gruppieren

```sql
SELECT Department, COUNT(*) AS Anzahl
FROM Employees
GROUP BY Department;
```

`GROUP BY`: Ergebnisse je Filiale

| Department | Anzahl |
| ---------- | ------ |
| HR         | 2      |
| IT         | 2      |
| Sales      | 1      |


---

# Bedingungen im WHERE

```sql
SELECT Department, COUNT(DISTINCT Job) AS VerschiedeneJobs
FROM Employees
WHERE Job NOT IN ('Manager', 'President')
GROUP BY Department;
```

`NOT IN`: bestimmte Werte ausschließen

| Department | VerschiedeneJobs |
| ---------- | ---------------- |
| HR         | 1                |
| IT         | 2                |
| Sales      | 1                |

