---
theme: seriph
routerMode: hash
title: Interfaces in C#
info: |
  ## Interfaces in C#
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

# Interfaces

## *"Verträge für Klassen"* 

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Wiederholung zur Vererbung

- Klassen können **Eigenschaften und Methoden** von anderen Klassen **erben**
- Eine Klasse kann **nur von einer Basisklasse erben**
- Mit **Polymorphismus** können Objekte unterschiedlich reagieren, obwohl sie denselben Typ haben

<br>
<br>

**❓ Aber was, wenn mehrere Klassen ein gleiches Verhalten teilen sollen, ohne dass sie verwandt sind?**

---

# Interface als "Vertrag"

Ein Interface ist wie ein **Vertrag** oder ein **Versprechen**. Wer diesen Vertrag **unterschreibt**, verpflichtet sich, alle darin geforderten Punkte einzuhalten.

**Oder anders formuliert:**

<cite style="line-height: 2">Eine Klasse ist ein Bauplan für ein Haus,<br>
ein Interface ist die Bauordnung, die vorgibt, was vorhanden sein muss (z. B. Türen, Fenster, Notausgang) <br>
 – aber nicht, wie sie gebaut sind.</cite>

---

# Syntax von Interfaces

```csharp
public interface IFahrbar
{
    void Starten();
    void Stoppen();
}
```

<br>

- Schlüsselwort `interface`
- Enthält nur Methodenköpfe, **keine Implementierung**
- Methoden sind standardmäßig public
- **Keine Felder**, nur Konstanten

---

# Implementierung eines Interfaces

```csharp
public class Auto : IFahrbar
{
    public void Starten()
    {
        Console.WriteLine("Motor startet...");
    }

    public void Stoppen()
    {
        Console.WriteLine("Auto hält an.");
    }
}

```

<br>

- Eine Klasse **„implementiert“** ein Interface
- Dazu wird `: I<InterfaceName>` geschrieben
- Die Klasse **muss alle Methoden** des Interfaces definieren

---

# Warum Interfaces

- **Mehrfachverwendung von Verhalten**
    - Eine Klasse kann mehrere Interfaces implementieren
- **Lose Kopplung**
    - Du kannst Klassen leicht austauschen oder erweitern, ohne bestehenden Code zu ändern.
- **Ermöglicht Polymorphismus** zwischen Klassen **ohne gemeinsame Basisklasse**

---

# Polymorphismus mit Interfaces

```csharp
public interface IFahrbar
{
    void Starten();
}

public class Auto : IFahrbar
{
    public void Starten() => Console.WriteLine("Motor startet");
}

public class Fahrrad : IFahrbar
{
    public void Starten() => Console.WriteLine("Los geht’s mit Muskelkraft!");
}

// Nutzung
List<IFahrbar> fahrzeuge = new List<IFahrbar>() { new Auto(), new Fahrrad() };

foreach (var f in fahrzeuge)
{
    f.Starten();
}
```

---

# Mehrere Interfaces implementieren

Verhalten kombinieren — wie „Fahrbar“ und „Reparierbar“.

```csharp
public interface IFahrbar { void Starten(); }
public interface IReparierbar { void Reparieren(); }

public class Auto : IFahrbar, IReparierbar
{
    public void Starten() => Console.WriteLine("Motor startet");
    public void Reparieren() => Console.WriteLine("Auto wird repariert");
}
```

---

# Interface mit Property

Eigenschaften (Properties) dürfen im Interface deklariert werden,
aber ohne Implementierung.

```csharp
public interface IDruckbar
{
    string Titel { get; set; }

    void Drucken();
}

public class Bericht : IDruckbar
{
    public string Titel { get; set; } = "Quartalsbericht";
    
    public void Drucken()
    {
        Console.WriteLine($"Drucke: {Titel}");
    }
}
```


---

# Vergleich: Vererbung VS. Interfaces

<br>

| **Merkmal**| **Vererbung**                    | **Interface**                  |
| ---------- | -------------------------------- | ------------------------------ |
| Beziehung  | „ist ein“ (is-a)                 | „kann“ oder „hat Fähigkeit zu“ |
| Anzahl     | Nur **eine** Basisklasse erlaubt | **Mehrere Interfaces** erlaubt |
| Enthält    | Implementierung                  | Nur Methodensignaturen         |
| Ziel       | Struktur & Verhalten vererben    | Verhalten vorschreiben         |

<br>

> 💡 **Merke:** <br>
> Klassen beschreiben **was etwas ist**, <br>
> Interfaces beschreiben **was etwas kann**.

---

# Zusammenfassung

- **Keine Instanzen möglich** (`new` nicht erlaubt)
- **Keine Konstruktoren**
- Alle Member sind **automatisch** `public`
- Dürfen **keine Felder enthalten**
- Können Methoden und Eigenschaften (*=Properties*) deklarieren
- Benennungskonvention: `I` + `Name` → z. B. `IFahrbar`, `IDruckbar`

---


# Übung

1. Erstelle ein Interface `IBeweglich` mit: `void Bewegen();`
2. Erstelle eine Klasse `Mensch`, eine `Auto` und eine `Vogel`.
3. Alle sollen `IBeweglich` implementieren.
4. Gib in `Bewegen()` jeweils eine passende Console-Ausgabe aus.
(z. B. „Mensch geht“, „Auto fährt“, „Vogel fliegt“)
5. Sammle alle in einer `List<IBeweglich>` und rufe `Bewegen()` in einer Schleife auf.