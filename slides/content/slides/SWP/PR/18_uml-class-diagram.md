---
theme: seriph
routerMode: hash
title: UML Klassendiagramme
info: |
  ## UML Klassendiagramme
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

# UML Klassendiagramme

## *Unified Modelling Language*

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Was sind Klassendiagramme? 

Klassendiagramme sind ein Teil der UML (Unified Modeling Language).

- Sie zeigen Aufbau, **Eigenschaften, Methoden und Beziehungen** zwischen Klassen.
- Sie helfen dabei, Struktur und Logik des **Systems zu planen**.
- Sie bilden die **Grundlage der objektorientierten Programmierung** (OOP).

--- 

# Warum verwenden wir Klassendiagramme?

- Architekturen planen
- Komplexität zu reduzieren
- Klassenverantwortungen sichtbar zu machen
- Beziehungen zu klären
- Teams ein gemeinsames Verständnis zu geben

---
layout: two-cols
layoutClass: gap-16
---

# Aufbau einer Klasse

<br>

### Eine Klasse besteht in UML aus drei Bereichen:

<br>


1. Name der Klasse
2. Attribute (Eigenschaften, Felder)
3. Methoden (Funktionen der Klasse)

<br>

### ...und zeigt Sichtbarkeiten:

<br>

- `+`  → `public` 
- `-` → `private`
- `#` → `protected`

::right::

<br>
<br>
<br>

```mermaid
classDiagram
  class Person {
    - name: string
    - age: int
    # GetAge() int
    + Walk(distance: double) void
  }
```

---

# Beziehungen zwischen Klassen abbilden

Auch Beziehungen zwischen Klassen bzw. Objekten können in UML abgebildet werden:

<br>

<div class="grid grid-cols-6 gap-8 text-center">
<div>

<h4>Abhängigkeit</h4>

```mermaid
classDiagram
    class Person {
    }

    class TaxiService {
    }

    Person ..> TaxiService : uses
```

</div>
<div>

<h4>Assoziation</h4>

```mermaid
classDiagram
    class Hospital {
    }

    class Patient {
    }

    Hospital --> Patient : treats
```

</div>
<div>
<h4>Aggregation</h4>

```mermaid
classDiagram
    class Hospital {
    }

    class Doctor {
    }

    Hospital o-- Doctor : employs
```

</div>
<div>

<h4>Komposition</h4>

```mermaid
classDiagram
    class House {
    }

    class Room {  
    }

    House *-- Room : contains 
```

</div>
<div>

<h4>Vererbung</h4>

```mermaid
classDiagram

    class Animal {
          <<abstract>>
    }

    class Dog {
    }

    Animal <|-- Dog
```


</div>
<div>
<h4>Interface</h4>

```mermaid
classDiagram
    class IMovable {
        <<interface>>
    }

    class Car {
    }

    IMovable <|.. Car
```

</div>
</div>
