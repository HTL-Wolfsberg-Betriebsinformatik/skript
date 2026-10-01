---
theme: seriph
routerMode: hash
title: SQL - JOIN
info: SQL JOIN
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

# SQL Subselect

## Abfragen in Abfragen 🤔

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Was ist ein Subselect?

Ein **Subselect** (oder **Unterabfrage**) ist eine **SQL-Abfrage innerhalb einer anderen Abfrage**.

Man verwendet Subselects, um:

- Daten dynamisch zu filtern,
- Zwischenergebnisse zu berechnen,
- komplexe Bedingungen ohne `JOIN`s zu formulieren

---

# Warum brauchen wir Subselects?

Oft möchten wir Daten aus einer Tabelle **abhängig von Werten in einer anderen Tabelle anzeigen**, **ohne** dabei unbedingt eine **JOIN-Struktur aufzubauen**.

<br>

**Beispiel:** 
- *"Zeige alle Kunden, die mindestens eine Bestellung aufgegeben haben."*

<br>

> 💡 Mit einem `JOIN` ginge das, aber manchmal sind Subselects einfacher und übersichtlicher, besonders wenn nur eine Bedingung geprüft wird.

---
layout: two-cols-header
layoutClass: gap-16
---

# Beispiel-Tabellen

::left::

**Kunde**
| KundenId | Name    | Stadt |
| -------- | ------- | ----- |
| 1        | Müller  | Wien  |
| 2        | Huber   | Graz  |
| 3        | Steiner | Linz  |

::right::

**Bestellung**
| BestellId | KundenId | Produkt  | Preis |
| --------- | -------- | -------- | ----- |
| 101       | 1        | Monitor  | 250   |
| 102       | 1        | Maus     | 30    |
| 103       | 3        | Tastatur | 50    |

---

# Beispiel 1: Kunden mit Bestellungen

Gib alle Kunden aus welche zumindest eine Bestellung haben

```sql
SELECT Name
FROM Kunde
WHERE KundenId IN (
    SELECT KundenId
    FROM Bestellung
);
```

<br>

**Erklärung:**
- Das innere `SELECT` gibt alle `KundenId`s aus, die in der Tabelle `Bestellung` vorkommen.
- Das äußere `SELECT` zeigt die Namen dieser Kunden an.

---

# Beispiel 2: Höchste Bestellungssumme

Gib den Kunden aus mit der höchsten Bestellsumme

```sql
SELECT Name
FROM Kunde
WHERE KundenId = (
    SELECT TOP 1 KundenId
    FROM Bestellung
    GROUP BY KundenId
    ORDER BY SUM(Preis) DESC
);
```

<br>

**Erklärung:**
- Der innere `SELECT` berechnet den Kunden mit der höchsten Gesamtsumme indem es die nur den ersten Eintrag ausgibt nachdem er nach dem Gesamtpreis geordnet wurde.
- Das äußere `SELECT` zeigt die Namen dieser Kunden an.

---

# Subselects können überall stehen

Subselects können verwendet werden in:

- `WHERE` (Filter)
- `SELECT` (Einzelwerte)
- `FROM` (als virtuelle Tabelle)

<br>

```sql
SELECT 
    Name,
    (SELECT COUNT(*) 
     FROM Bestellung 
     WHERE Bestellung.KundenId = Kunde.KundenId) AS AnzahlBestellungen
FROM Kunde;
```

<br>

**Erklärung:**
- Das innere `SELECT` berechnet die Anzahl der Bestellungen dynamisch für jeden Kunden.

---

# Subselect vs JOIN

<br>

| **Aspekt**                 | **JOIN**                       | **Subselect**                 |
| :------------------------- | :----------------------------- | :---------------------------- |
| Mehrere Tabellen verbinden | Ja                             | Nur indirekt                  |
| Lesbarkeit bei Bedingungen | Komplex                        | Oft einfacher                 |
| Performance                | Schnell bei großen Datenmengen | Kann langsamer sein           |
| Ergebnisstruktur           | Kombiniert Spalten             | Bleibt bei einer Haupttabelle |

---

# `ALL` und `ANY`

Beide werden mit einem Subselect verwendet und vergleichen einen Wert mit mehreren Ergebnissen.

- Das Subselect liefert eine Liste von Werten
- `ALL` / `ANY` bestimmen, wie verglichen wird

**Beispiel: Tabelle `Orders`**

| OrderID | CustomerID | Amount |
| ------- | ---------- | ------ |
| 1       | 1          | 100    |
| 2       | 1          | 200    |
| 3       | 2          | 50     |
| 4       | 3          | 300    |

---

# `ANY`

Vergleich muss **für mindestens einen Wert** zutreffen

**Beispiel:**

```sql
SELECT *
FROM Orders
WHERE Amount > ANY (
    SELECT Amount
    FROM Orders
    WHERE CustomerID = 1
);
```

**Ergebnis:**

<div v-click="1">

`200, 300` weil Subselect liefert `100, 200` und `200, 300 > 100 ODER 200`

</div>

<br>

> 💡 **`ANY`= mindestens ein Vergleich muss stimmen**

---

# `ALL`

Vergleich muss **für alle Werte** zutreffen

**Beispiel:**

```sql
SELECT *
FROM Orders
WHERE Amount > ALL (
    SELECT Amount
    FROM Orders
    WHERE CustomerID = 1
);
```

**Ergebnis:**

<div v-click="1">

`300` weil Subselect liefert `100, 200` und `300 > 100 UND 200`

</div>

<br>

> 💡 `ALL` **= alle Vergleiche müssen stimmen**

---

# Typische `ALL` und `ANY` Szenarien

| SQL     | Bedeutung                         |
| ------- | --------------------------------- |
| `> ANY` | größer als **mindestens einer**   |
| `< ANY` | kleiner als **mindestens einer**   |
| `> ALL` | größer als **der größte Wert**    |
| `< ALL` | kleiner als **der kleinste Wert** |

---

# Synchronisierung

Die innere Abfrage **(Subquery) verwendet Werte aus der äußeren Abfrage**. Sie wird für jede Zeile neu ausgeführt.

**Beispiel: Tabelle `Orders`**

| OrderID | CustomerID | Amount |
| ------- | ---------- | ------ |
| 1       | 1          | 100    |
| 2       | 1          | 200    |
| 3       | 2          | 50     |
| 4       | 3          | 300    |


---

# Synchronisierung: Aufgabe

Finde alle Bestellungen, die **größer als der Durchschnitt des jeweiligen Kunden** sind

```sql
SELECT *
FROM Orders o
WHERE Amount > (
    SELECT AVG(Amount)
    FROM Orders
    WHERE CustomerID = o.CustomerID
);
```

**Wo ist die Synchronisierung?**

<div v-click="1">

```sql
WHERE CustomerID = o.CustomerID
```

- `o.CustomerID` kommt aus der äußeren Abfrage
- Die Subquery passt sich pro Zeile an

</div>

---

# Synchronisierung: Lösung

***

**Order 1 (C1, 100):**

<div v-click="1">

```bash
→ AVG(C1) = 150 
→ 100 > 150 ❌
```

</div>

**Order 2 (C1, 200):**

<div v-click="2">

```
→ AVG(C1) = 150 
→ 200 > 150 ✅
```

</div>

**Order 3 (C2, 50):**

<div v-click="3">

```
→ AVG(C2) = 50 
→ 50 > 50 ❌
```

</div>

**Order 4 (C3, 300):**

<div v-click="4">

```
→ AVG(C3) = 300 
→ 300 > 300 ❌
```

</div>