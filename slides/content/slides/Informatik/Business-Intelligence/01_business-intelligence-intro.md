---
theme: seriph
routerMode: hash
title: Intro Business Intelligence
info: |
  ## Intro Business Intelligence
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

# Einführung Business Intelligence (BI)

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---
layout: two-cols-header
layoutClass: gap-8
---

# Daten sind überall

Unternehmen sammeln ständig Daten aus verschiedenen Systemen.


::left::

**Beispiele:**
<div v-click="1">

- Excel Dateien
- Datenbanken
- ERP Systeme (z. B. SAP)
- Web APIs
- ...
</div>
<br>



::right::
<div v-click="2">

**Fragen aus Daten beantworten:**

</div>

<div v-click="3">

* Welches Produkt verkauft sich am besten?
* In welchem Land machen wir den meisten Umsatz?
* Wie entwickelt sich der Umsatz über die Zeit?

</div>

<div class="mt-16" v-click="4">

<span class="text-red">**Daten sind vorhanden, aber schwer auszuwerten**</span>

</div>


---
layout: two-cols-header
layoutClass: gap-4
---

# Business Intelligence (BI)

Business Intelligence beschreibt **Methoden und Werkzeuge zur Analyse großer Datenmengen, um daraus verständliche Informationen zu gewinnen**.

::left::

**Business-Intelligence-Tools helfen dabei:**

- Daten aus verschiedenen Quellen zu sammeln
- Daten aufzubereiten und zu analysieren
- Zusammenhänge zu erkennen
- Ergebnisse verständlich darzustellen (Diagramme, Dashboards)


**Typische Einsatzbereiche:**
- Verkaufsanalysen
- Unternehmenskennzahlen
- Entscheidungsunterstützung

::right::

<div class="text-center w-full">

```mermaid
flowchart TD

A[Daten sammeln]
B[Daten vorbereiten]
C[Daten analysieren]
D[Ergebnisse visualisieren]

A --> B --> C --> D

classDef collect fill:#e3f2fd,stroke:#1e88e5,stroke-width:2px,color:#0d47a1
classDef prepare fill:#e8f5e9,stroke:#43a047,stroke-width:2px,color:#1b5e20
classDef analyze fill:#fff3e0,stroke:#fb8c00,stroke-width:2px,color:#e65100
classDef visualize fill:#f3e5f5,stroke:#8e24aa,stroke-width:2px,color:#4a148c

class A collect
class B prepare
class C analyze
class D visualize
```

</div>

---
layout: two-cols
---

# BI Tools

Es gibt viele Programme, die für Business Intelligence verwendet werden.

<br>

**Beispiele:**

- <span v-mark.red="1">Microsoft Power BI</span>
- Tableau
- Qlik Sense
- SAP Analytics Cloud
- Looker (Google)

<br>

<div v-click="1">

> 💡 Wir verwenden Microsoft Power BI im Unterricht
</div>

::right::

<div v-click="1">

![Microsoft Power BI Logo](./assets/New_Power_BI_Logo.svg.png)

</div>

---
layout: two-cols
---

# Einführung in Power BI 

Power BI ist ein Tool von Microsoft für:

- Datenanalyse
- Visualisierung
- Dashboards

**Versionen:**

- Power BI Desktop (Analyse & Reports)
- Power BI Service (Cloud)
- Power BI Mobile

::right::

<div class="flex flex-row items-end h-full">

![Power BI Demo](./assets/pbi-bblocks_03.png)
</div>

---

# Workflow in Power BI

Power BI folgt einem klaren Ablauf, um aus Rohdaten verständliche Analysen zu erstellen.

```mermaid
flowchart LR

A[Daten laden] --> B[Daten vorbereiten]
B --> C[Datenmodell]
C --> D[Visualisierung]
```

**Schritte:**

- **Daten laden**: Daten aus Quellen importieren (z. B. Excel, Datenbanken)

- **Daten vorbereiten (Power Query)**: Daten bereinigen, filtern und transformieren

- **Datenmodell**: Tabellen verbinden und Beziehungen definieren

- **Visualisierung**: Diagramme, Reports und Dashboards erstellen

---
layout: center
---

<div class="text-center">

# Übung: Bericht erstellen aus Excel Arbeitmappe

[Link zum Tutorial](https://learn.microsoft.com/de-de/power-bi/create-reports/desktop-excel-stunning-report)

</div>

