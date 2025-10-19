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

# Grundidee

Ein `JOIN` verbindet Datensätze über gemeinsame Werte, meist über **Primär- und Fremdschlüssel**.

<br>

**Beispiel:**
- `kunden.id` <--> `bestellungen.kunden_id`

```sql
CREATE TABLE kunden (
    id INT PRIMARY KEY,
    name NVARCHAR(50)
);

CREATE TABLE bestellungen (
    id INT PRIMARY KEY,
    kunden_id INT,
    produkt NVARCHAR(50)
);
```

---
layout: two-cols-header
layoutClass: gap-16
---
# `INNER JOIN`

Der `INNER JOIN` zeigt nur Datensätze, die in **beiden Tabellen vorkommen**.

::left::

```sql
SELECT k.name, b.produkt
FROM kunden AS k
INNER JOIN bestellungen AS b
    ON k.id = b.kunden_id;
```

::right::

| name  | produkt  |
| ----- | -------- |
| Anna  | Laptop   |
| Carla | Handy    |
| Carla | Tastatur |


---
layout: two-cols-header
layoutClass: gap-16
---

# `OUTER JOIN`

Der `OUTER JOIN` zeigt auch Datensätze, die **keine Übereinstimmung** in der anderen Tabelle haben.

::left::

```sql
SELECT k.name, b.produkt
FROM kunden AS k
INNER JOIN bestellungen AS b
    ON k.id = b.kunden_id;
```

::right::

| name  | produkt  |
| ----- | -------- |
| Anna  | Laptop   |
| Carla | Handy    |
| Carla | Tastatur |
| Bernd | NULL     |
| NULL  | Fernseher|