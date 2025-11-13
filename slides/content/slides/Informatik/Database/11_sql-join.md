---
theme: seriph
routerMode: hash
title: SQL - JOIN
info: SQL JOIN
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

# SQL JOIN

## Daten aus mehreren Tabellen gemeinsam anzeigen

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Warum `JOIN`s?

- In relationalen Datenbanken sind **Informationen auf mehrere Tabellen verteilt**.
- JOINs ermöglichen es, **zusammenhängende Daten** wieder **zusammenzuführen**.

<br>

**Beispiel:**

- Tabelle `Kunde`
- Tabelle `Bestellung`

> Wir möchten sehen, welcher Kunde welche Bestellung gemacht hat.

---
layout: two-cols-header
layoutClass: gap-8
---

# Grundidee

Ein `JOIN` verbindet Datensätze über gemeinsame Werte, meist über **Primär- und Fremdschlüssel**.

**Beispiel:**
- `Kunden.Id` <--> `Bestellungen.KundenId`

::left::

```sql
CREATE TABLE Kunden (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50)
);

CREATE TABLE Bestellungen (
    Id INT PRIMARY KEY,
    KundenId INT,
    Produkt NVARCHAR(50),
    FOREIGN KEY (KundenId) REFERENCES Kunden(Id)
);
```

::right::

```sql
INSERT INTO Kunden (Id, Name) VALUES
(1, N'Anna'),
(2, N'Bernd'), -- Bernd hat keine Bestellungen
(3, N'Carla'),
(4, N'Dirk');  -- Dirk hat keine Bestellungen

-- Bestellungen:
INSERT INTO Bestellungen (Id, KundenId, Produkt) VALUES
(1, 1, N'Laptop'),    -- Bestellung von Anna
(2, 3, N'Handy'),     -- Bestellung von Carla
(3, NULL, N'Maus'),   -- KundenId bewusst NULL
(4, 1, N'Tastatur');  -- Bestellung von Anna
```


---
layout: two-cols-header
layoutClass: gap-16
---
# `INNER JOIN`

Der `(INNER) JOIN` zeigt nur Datensätze, die in **beiden Tabellen vorkommen**.

::left::

```sql
SELECT k.Name, b.Produkt
FROM Kunden AS k
INNER JOIN Bestellungen AS b
    ON k.id = b.KundenId;
```

::right::

| Name  | Produkt  |
| ----- | -------- |
| Anna  | Laptop   |
| Carla | Handy    |
| Anna  | Tastatur |


---
layout: two-cols-header
layoutClass: gap-16
---

# `FULL OUTER JOIN`

Der `FULL (OUTER) JOIN` zeigt auch Datensätze, die **keine Übereinstimmung** in der anderen Tabelle haben.

::left::

```sql
SELECT k.name, b.produkt
FROM kunden AS k
FULL JOIN bestellungen AS b
    ON k.id = b.kunden_id;
```

::right::

| Name  | Produkt  |
| ----- | -------- |
| Anna  | Laptop   |
| Anna  | Tastatur |
| Bernd | `NULL`   |
| Carla | Handy    |
| Dirk  | `NULL`   |
| `NULL`| Maus     |

---
layout: two-cols-header
layoutClass: gap-16
---

# `LEFT OUTER JOIN`

Der `LEFT (OUTER) JOIN` zeigt alle Datensätze aus der **linken Tabelle**,
auch wenn **keine passenden Einträge auf der rechten Seite** existieren.

::left::

```sql
SELECT k.Name, b.Produkt
FROM Kunden AS k
LEFT JOIN Bestellungen AS b
    ON k.id = b.KundenId;
```

::right::


| Name  | Produkt  |
| ----- | -------- |
| Anna  | Laptop   |
| Anna  | Tastatur |
| Bernd | `NULL`   |
| Carla | Handy    |
| Dirk  | `NULL`   |

---
layout: two-cols-header
layoutClass: gap-16
---

# `RIGHT OUTER JOIN`

Der `RIGHT (OUTER) JOIN` zeigt alle Datensätze aus der **rechten Tabelle**,
auch wenn **keine passenden Einträge auf der linken Seite** existieren.

::left::

```sql
SELECT k.Name, b.Produkt
FROM Kunden AS k
RIGHT JOIN Bestellungen AS b
    ON k.id = b.KundenId;
```

::right::

| Name  | Produkt  |
| ----- | -------- |
| Anna  | Laptop   |
| Anna  | Tastatur |
| Carla | Handy    |
| `NULL`| Maus     |

---

# Zusammenfassung

| **JOIN-Typ**       | **Beschreibung**                | **Fehlende Werte werden…** |
| ------------------ | ------------------------------- | ---------------------- |
| `(INNER) JOIN`         | Nur übereinstimmende Datensätze | …weggelassen           |
| `LEFT (OUTER) JOIN`  | Alle aus der linken Tabelle     | …als NULL ergänzt      |
| `RIGHT (OUTER) JOIN` | Alle aus der rechten Tabelle    | …als NULL ergänzt      |
| `FULL (OUTER) JOIN`    | Alle aus beiden Tabellen        | …als NULL ergänzt      |

---

# Übung: Lehrer - Fächer

- Erstelle zwei Tabellen:
    - `Lehrer (Id, Name)`
    - `Fach (Id, Name, LehrerId)`
- Fülle ein paar Beispiel-Daten ein
- Führe verschiedene `JOIN`s aus:
    - `INNER JOIN`
    - `LEFT JOIN`
    - `RIGHT JOIN`
    - `FULL JOIN`
- Überlege: Wann erscheinen NULL-Werte?