---
theme: seriph

title: Intro Programmieren
info: |
  ## Intro Programmieren - Überblick
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

# Variablen und ihre Datentypen in C#

---

# Inhalt

<Toc minDepth="1" maxDepth="2" />

---

# Was ist eine Variable?

Eine **Variable** ist wie ein **benannter Speicherplatz** im Arbeitsspeicher, in dem ein Wert abgelegt wird.

- **Name**: Wie wir die Variable im Programm ansprechen  
- **Typ**: Welche Art von Daten sie speichern kann (z. B. Zahl, Text, Wahr/Falsch)  
- **Wert**: Der aktuell gespeicherte Inhalt  

```
Typ Name = Wert;
```


**Beispiele:**

```csharp
string name = "Max";
int alter = 16;
bool hatAusbildung = true;
```

---

# Grundlegende Datentypen in `C#`

| Datentyp  | Beschreibung                      | Beispielwert    |
| --------- | --------------------------------- | --------------- |
| `int`     | Ganze Zahl                        | `42`            |
| `double`  | Gleitkommazahl (mit Nachkommast.) | `3.14`          |
| `bool`    | Wahr/Falsch                       | `true`, `false` |
| `string`  | Text                              | `"Hallo"`       |
| `char`    | Einzelnes Zeichen                 | `'A'`           |
| `decimal` | Exakte Dezimalzahl (z. B. Geld)   | `19.99`         |

---

# Variablennamen - Regeln & Konventionen

<hr>

✅ **Erlaubt:**

- Buchstaben, Ziffern, `_` (Unterstrich)
- Muss mit Buchstaben oder `_` beginnen

❌ **Nicht erlaubt:**

- Sonderzeichen (außer `_`)
- Leerzeichen
- Schlüsselwörter (bereits belegte Wörter von C#) wie `int`, `class`, `for`

⚠️ **Empfehlung:**

- Keine Umlaute (ä,ö,ü)
- Schreibvariante: "camelCase" (e.g. erstesWortKleinDannAllesGross, hatAusbildung)
- englische Wörter benutzen

---

# Deklaration und Initialisierung

- **Deklaration**: Anlegen einer Variable mit Typ und Namen  
- **Initialisierung**: Erstmaliges Zuweisen eines Werts  

**Beispiel:**

```csharp
int alter;           // Deklaration
alter = 16;          // Initialisierung
```

oder:

```csharp
string alter = 16; // Deklaration + Initialisierung
```

---

# Werte zuweisen und ändern

- Variablen können neue Werte zugewiesen werden, sobald sie deklariert sind.

```csharp
int points = 10; // deklariert und initialisiert (10)
points = 20;     // neuer Wert (20)
points = points + 5; // alter Wert verändert (25)
```

<br>

⚠️ **Ausnahme: Konstanten**

- Eine Konstante ist wie eine Variable, deren Wert sich **nicht ändern darf**.

```csharp
const double Pi = 3.14159;
```
