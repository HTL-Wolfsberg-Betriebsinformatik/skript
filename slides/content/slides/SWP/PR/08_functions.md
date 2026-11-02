---
theme: seriph
routerMode: hash
title: Funktionen in C#
info: |
  ## Einführung in Funktionen mit C#
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

# Einführung in Funktionen

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Definition

Eine **Funktion** (in C# meist *Methode* genannt) ist ein **abgegrenzter Programmbaustein**, der eine bestimmte Aufgabe erfüllt.


<div class="grid grid-cols-2 gap-16">
<div>    
```csharp
// ohne Funktion
Console.WriteLine("Do your homework");
Console.WriteLine("Do your homework");
Console.WriteLine("Do your homework");

```
</div>
<div>    
```csharp
// mit Funktion
void DoHomework()
{
    Console.WriteLine("Do your homework");
}

DoHomework();
DoHomework();
DoHomework();
```
</div>
</div>

- Code wird **übersichtlicher** und **wiederverwendbar**
- **Fehler leichter finden** (kleinere Bausteine statt Riesencode)
- Programme lassen sich **besser strukturieren**

<br>

> Merksatz:
>
> Eine Funktion ist wie ein Werkzeug: **Einmal definiert, kann man es immer wieder benutzen.**

---

# Wie sind Funktionen aufgebaut

Eine Funktion besteht aus folgenden Teilen:

- **Funktionsnamen**: Ein sprechender Name (e.g. `ZeigeHelloWorld`)
- **Rumpf**: Der Inhalt bzw die Anweisungen in der Funktion was sie tun soll
- **Rückgabewert/-typ**: Das was die Funktion zurückliefern soll nachdem sie fertig ist.
- **Parametertyp/-name**: Optional können sogenannte Parameter vom aufzurufenden Programm mitgegeben werden

<br>

```csharp
Rückgabetyp Funktionsname(Parametertyp parameterName, ...)
{
    // Funktionsrumpf
    return Rückgabewert; // falls Rückgabewert nicht void
}
```

---

# Wie ruft man Funktionen auf

```csharp
Rückgabetyp Funktionsname(Parametertyp parameterName, ...)
{
    // Funktionsrumpf
    return Rückgabewert; // falls Rückgabewert nicht void
}

Parametertyp parameter1 = ...;

Funktionsname(parameter1, ...)
```

---

# Funktionen ohne Rückgabewert


Wenn eine Funktion keinen Rückgabewert hat (e.g eine Zahl, einen Text, etc), dann gibt man als **Rückgabetyp** `void` an.

<br>

```csharp
void DoHomework()
{
    Console.WriteLine("Do your homework");
}

DoHomework(); // Aufruf
```

<br>

> 🫏 **Eselsbrücke:**
>
> In der Astronomie sind **"Voids"** großskalige Leer- oder Hohlräume im Universum. **Leerräume** sind also gleichbedeutend wie **"Nichts returnieren"** bei Funktionen

---

# Funktionen mit Rückgabewert

Der Rückgabewert wird einer Variable zugewiesen

```csharp
string GibHelloWorldZurueck()
{
    return "Hello World";
}

string text = GibHelloWorldZurueck();
```

---

# Funktionen mit Parameter

Parameter sind Platzhalter für Werte, die beim Funktionsaufruf übergeben werden.

```csharp
int BerechneQuadrat(int laenge)
{
    return laenge * laenge;
}

int resultat = BerechneQuadrat(5);
```

**Funktionen mit mehreren Parametern**

```csharp
int BerechneRechteckFlaeche(int a, int b)
{
    return a * b;
}

int resultat = BerechneRechteckFlaeche(5, 3);
```

---

# Funktionen mit Standardwerte für Parametern

Sind optionale Parameter: Der Aufrufer **kann, muss aber nicht,** diesen Parameter bereitstellen

```csharp
void Begruessung(string name = "Gast")
{
    Console.WriteLine("Hallo " + name);
}

Begruessung(); // ok, nimmt "Gast" als `name`
Begruessung("Stefan"); // ok, nimmt "Stefan" als `name` 
```

---

# Überladene Funktionen (Method Overloading)

Mehrere Funktionen dürfen **denselben Namen** haben, wenn sich ihre **Parameterliste** unterscheidet.

<div class="grid grid-cols-2 gap-8">
<div>

```csharp
int Addiere(int a, int b)
{
    return a + b;
}

int Addiere(int a, int b, int c)
{
    return a + b + c;
}

double Addiere(double a, double b)
{
    return a + b;
}
```

</div>
<div>

```csharp
// ruft Addiere(int, int) auf
int summe1 = Addiere(2, 3);

// ruft Addiere(int, int, int) auf
int summe2 = Addiere(2, 3, 4);

// ruft Addiere(double, double) auf
double summe3 = Addiere(2.5, 1.5);
```

</div>
</div>

Der Compiler entscheidet anhand der **übergebenen Argumente**, welche Variante aufgerufen wird.

---

# Regeln für das Überladen

Die Funktionen müssen sich in ihrer **Signatur** (Name + Parameterliste) unterscheiden durch:

- die **Anzahl** der Parameter: `Addiere(int a, int b)` vs. `Addiere(int a, int b, int c)`
- die **Typen** der Parameter: `Addiere(int a, int b)` vs. `Addiere(double a, double b)`
- die **Reihenfolge** der Typen: `Ausgabe(string text, int anzahl)` vs. `Ausgabe(int anzahl, string text)`

<br>

❌ **Nicht erlaubt:** Unterschied nur im **Rückgabetyp** oder in den **Parameternamen**

```csharp
int Berechne(int a) { ... }
double Berechne(int a) { ... } // Fehler: gleiche Parameterliste!
int Berechne(int zahl) { ... } // Fehler: nur anderer Parametername!
```

<br>

> Merksatz:
>
> **Gleicher Name, gleiche Aufgabe – aber unterschiedliche Eingaben.**

---

# Überladung in .NET

Viele fertige .NET-Funktionen sind überladen:

<div class="grid grid-cols-2 gap-8">
<div>

**`Console.WriteLine`** – unterschiedliche **Typen**

```csharp
Console.WriteLine();          // leere Zeile
Console.WriteLine("Hallo");   // string
Console.WriteLine(42);        // int
Console.WriteLine(3.14);      // double
Console.WriteLine(true);      // bool
```

</div>
<div>

**`Math.Round`** – unterschiedliche **Anzahl**

```csharp
double a = Math.Round(3.14159);    // 3
double b = Math.Round(3.14159, 2); // 3.14
```

**`Math.Abs`** – Rückgabetyp passt zum Parameter

```csharp
int    c = Math.Abs(-5);    // Abs(int)    → int
double d = Math.Abs(-2.5);  // Abs(double) → double
```

</div>
</div>

---
title: Ablauf einer Funktion
layout: full
clicks: 7
---

<FunktionsAblauf :schritt="$clicks" />

---

# Parameterübergabe in C#: `out` & `ref`

Warum gibt es diese Schlüsselwörter?

Normale Parameter in C# werden *by value* übergeben:
- Die Funktion erhält eine **Kopie** der Daten.
- Änderungen wirken sich **nicht** auf die Originalvariable aus.

`ref` und `out` erlauben **by reference**:
- Die Funktion erhält **eine Referenz auf die Originalvariable**.
- Änderungen wirken sich **direkt auf den Aufrufer aus**.

## Ziel von `out` und `ref`

- **Mehrere Werte aus einer Funktion zurückgeben**  
- **Werte in einer Funktion verändern lassen**

---
layout: two-cols
layoutClass: gap-16
---

# `out` – Parameter, die *von der Funktion gesetzt* werden müssen

- Die Variable **darf vor dem Aufruf nicht initialisiert** sein.
- Die Funktion **muss einen Wert zuweisen**.
- Typisch für: *Versuche etwas zu berechnen – lief es oder nicht?*

**Einsatzgebiete:**

- Methoden, die Erfolg/Misserfolg zurückgeben + berechneten Wert liefern
- Bekannt aus .NET-API: `int.TryParse()`, `double.TryParse()`

::right::
<br>

```csharp
bool TryDivide(int a, int b, out int result)
{
    // verhindert eine Division durch 0
    if (b == 0)
    {
        result = 0;
        return false;
    }

    result = a / b;
    return true;
}

// Aufruf:
int result; // darf nicht initialisiert werden
bool success = TryDivide(5, 0, out result)
```

---
layout: two-cols
layoutClass: gap-16
---

# `ref` – Parameter, die *vorher existieren & valid sein müssen*

- Die Variable **muss vor dem Aufruf initialisiert** sein.
- Funktion **kann** diese verändern (muss aber nicht).
- Typisch für: *Werte an Funktionen übergeben, die sie verändern sollen*.

::right::
<br>

```csharp
void Increase(ref int number)
{
    number += 10;
}

int x = 5;
Increase(ref x);
// x ist jetzt 15
```

---

# Vergleich: `out` vs `ref`

| Merkmal                             | `out`                                 | `ref`                                        |
| ----------------------------------- | ------------------------------------- | -------------------------------------------- |
| Muss vor Aufruf initialisiert sein? | ❌ Nein                               | ✔ Ja                                         |
| Muss die Methode einen Wert setzen? | ✔ Ja                                  | ❌ Nein                                       |
| Typische Nutzung                    | Parsing, Berechnungen                 | Werte verändern                              |
| Rückgabecharakter                   | *„Hier, ich fülle das für dich aus.“* | *„Arbeite mit meiner bestehenden Variable.“* |


**Merksatz:**

- out: Die Funktion liefert einen Wert.
- ref: Die Funktion verarbeitet/ändert einen vorhandenen Wert.