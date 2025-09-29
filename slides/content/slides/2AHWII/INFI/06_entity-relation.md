---
theme: seriph

title: Datenbankmodellierung und Entity Relation
info: Grundlagen von Datenbankmodellierung und Entity Relation
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

# Datenbankmodellierung

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Warum modellieren?

Analogie: Man stelle sich vor, wir würden ein Haus **ohne Bauplan** bauen

- Wände passen nicht zusammen  
- Türen gehen ins Leere  
- Stromleitungen fehlen oder sind doppelt  
- Änderungen sind sehr teuer  

**Vergleich zur Datenbank:**

- **Haus** = Datenbank  
- **Bauplan** = Datenbankmodell

<br>

> 💡 Niemand baut ein Haus ohne Plan – warum also eine Datenbank ohne Modell? 

---

# Vorteile der Datenbankmodellierung

<br>

✅ **Struktur & Übersicht**: Komplexe Daten werden klar organisiert  

✅ **Vermeidung von Redundanz**: Keine mehrfach gespeicherten Infos  

✅ **Konsistenz & Regeln sichtbar**: Klare Vorgaben: was ist erlaubt, was nicht  

✅ **Einfache Abfragen & Nutzung**: Daten sind leichter zu durchsuchen  

✅ **Bessere Wartbarkeit & Erweiterbarkeit**: Neue Anforderungen lassen sich leichter einbauen  

---

# Definition: Datenbankmodellierung

**Datenbankmodellierung** übersetzt die Fachdomäne in eine klare, widerspruchsfreie Datenstruktur.  

- Statt sofort Tabellen in SQL zu schreiben,  
  → **zuerst ein Modell erstellen**  
- Zeigt: welche Dinge (Entitäten) und welche Verknüpfungen (Beziehungen) es gibt  
- Ergebnis: ein **Relationenschema**, das später in SQL umgesetzt wird  

<br>

> 💡Erst **modellieren (konzeptuell)** → dann **Tabellen bauen (logisch)** → zuletzt **im DBMS speichern (physisch)**

<br>

--> <span v-mark.red="1">Wir benutzen das **ER-Modell** als Modellierungssprache</span>

---

# Was ist ein ER-Modell?

- **E**ntity (**Entität**) = Ding/Objekt, das wir speichern wollen 
- **R**elationship (**Beziehung**) = Verknüpfung zwischen Entitäten 

<br>

**Beispiel:**

*Entitäten (Tabellen):*
- Movie(movie_id, title, release_date, runtime_min)
- Actor(actor_id, name)

*Beziehungen:*
- Ein Movie kann viele Actors haben  
- Ein Actor kann in vielen Movies spielen 

---

# ER-Diagramm

Das ER-Diagramm ist die **grafische Darstellung** des ER-Modells.

- **Rechteck** = Entität (Tabelle)  
- **Ellipse** = Attribut (Spalte)  
- **Raute** = Beziehung (Verknüpfung)  

👉 mit **Kardinalität**: 1:1, 1:n, m:n


**Beispiel:**

![Beispiel](./assets/er-movie-actor-example.drawio.png)

---

# Kardinalität – Was heißt das?

Beschreibt **wie viele Objekte** einer Entität  
mit Objekten einer anderen Entität verknüpft sein können.

- **1:1**
    - genau eins zu eins
    - *Beispiel:* **Ein (1)** Schüler hat **genau einen (1)** Schülerausweis
- **1:n**
    - eins zu vielen
    - *Beispiel:* **Ein (1)** Kunde hat **viele (n)** Bestellungen, aber **eine (1)** Bestellung gehört nur zu **einem (1)** Kunden
- **m:n** 
    - viele zu vielen
    - *Beispiel:*  **Ein (1)** Schüler besucht **viele (n)** Kurse, und **ein (1)** Kurs hat **viele (m)** Schüler

---

# Beispiel - 1:1 Kardinalität

**Ein (1)** Schüler hat **genau einen (1)** Schülerausweis

![ER Kardinalität - 1:1](./assets/er-cardinality-1-to-1.drawio.png){width=100%}

---

# Beispiel - 1:n Kardinalität

**Ein (1)** Kunde hat **viele (n)** Bestellungen, aber **eine (1)** Bestellung gehört nur zu **einem (1)** Kunden

![ER Kardinalität - 1:n](./assets/er-cardinality-1-to-n.drawio.png){width=100%}

---

# Beispiel - m:n Kardinalität

**Ein (1)** Schüler besucht **viele (n)** Kurse, und **ein (1)** Kurs hat **viele (m)** Schüler

![ER Kardinalität - 1:n](./assets/er-cardinality-m-to-n.drawio.png){width=100%}

> 💡 in `m:n` Beziehungen können auch *Beziehungen* Attribute haben.

---

# Beziehungen mit Attributen

In `m:n` Beziehungen können auch *Beziehungen* Attribute haben.

![ER Beziehung mit Attribut](./assets/er-attribute-on-relation-example.drawio.png){width=100%}

---

# Weitere Elemente im ER Diagramm

<br>

**Schwache Entität**

- kann nicht alleine existieren
- Beispiel: `Bewertung` gehört immer zu genau einem `Film`
- Symbol: *Doppeltes Rechteck*

<br>

![ER - Schwache Entität](./assets/er-weak-entity-example.drawio.png)

---
hideInToc: true
---

# Weitere Elemente im ER Diagramm

<br>

**Abgeleitetes Attribut**

- wird aus einem anderen Attribut berechnet
- Beispiel: `Alter` wird aus `Geburtstag` berechnet
- Symbol: *Gestrichelte Ellipse*

<br>

![ER - Schwache Entität](./assets/er-derived-attribute-example.drawio.png)