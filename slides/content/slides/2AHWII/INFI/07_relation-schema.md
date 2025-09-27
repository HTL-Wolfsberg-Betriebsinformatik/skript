---
theme: seriph

title: Relationsschema
info: Relationsschema und Ableitung vom ER Diagramm
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

# Relationsschema

## Vom ER Diagramm zum Relationsschema

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Erinnerung: ER-Modell

- Entitäten (z. B. `FILM`, `SCHAUSPIELER`)  
- Attribute (z. B. `Titel`, `Name`)  
- Beziehungen (z. B. „spielt in“)  
- Kardinalitäten (1:1, 1:n, m:n)

👉 ER-Modell = **konzeptuelle Sicht** (fachliche Welt)

---

# Ziel: Relationsschema

- Relationsschema = **Sammlung von Tabellen**  
- Jede Tabelle: Name + Attribute + Primärschlüssel  
- Später Grundlage für SQL `CREATE TABLE`

👉 Relationsschema = **logische Sicht**

---

# Regeln zur Umwandlung (Basis)

1. **Entität → Tabelle**  
   - Attribute der Entität → Spalten  
   - Primärschlüssel markieren  

2. **1:n Beziehung → Fremdschlüssel**  
   - Der Schlüssel der „1“-Seite wird in der „n“-Tabelle als Fremdschlüssel gespeichert  

3. **m:n Beziehung → Zwischentabelle**  
   - Neue Relation mit beiden Primärschlüsseln  
   - ggf. zusätzliche Beziehungsattribute  

---

# Beispiel: Film & Schauspieler

**ER-Modell (vereinfacht):**  
- `FILM(Film_ID, Titel)`  
- `SCHAUSPIELER(Schauspieler_ID, Name)`  
- Beziehung: *m:n* „spielt in“ mit Attribut `Charakter_Name`

---

# Umwandlung ins Relationsschema

- `FILM(Film_ID PK, Titel)`  
- `SCHAUSPIELER(Schauspieler_ID PK, Name)`  
- `CASTING(Film_ID FK, Schauspieler_ID FK, Charakter_Name, PK = (Film_ID, Schauspieler_ID))`

👉 `CASTING` ist die Zwischentabelle für die m:n-Beziehung

---

# Beispiel: 1:n Beziehung

**ER-Modell:**  
- `REGISSEUR(Regisseur_ID, Name)`  
- `FILM(Film_ID, Titel)`  
- Beziehung: *1:n* – ein Regisseur kann viele Filme haben

---

# Relationsschema

- `REGISSEUR(Regisseur_ID PK, Name)`  
- `FILM(Film_ID PK, Titel, Regisseur_ID FK)`

👉 Fremdschlüssel in `FILM` zeigt auf `REGISSEUR`

---

# Besondere Fälle

- **Schwache Entität**  
  - Primärschlüssel = eigener Schlüssel + Fremdschlüssel  
- **Abgeleitete Attribute**  
  - werden i. d. R. **nicht gespeichert**  

---

# Warum diese Schritte?

✅ Das Relationsschema ist **klar definiert**  
✅ Direkte Grundlage für SQL (`CREATE TABLE`)  
✅ Vermeidet Fehler und Inkonsistenzen  
