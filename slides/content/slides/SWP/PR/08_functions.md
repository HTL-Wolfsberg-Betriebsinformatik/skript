---
theme: seriph
routerMode: hash
title: Funktionen in C#
info: |
  ## Einführung in Funktionen mit C#
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

# Funktionen schreiben vs. benutzen

- Eine Funktion ist einfach ein **benannter Block von Code**, der etwas Bestimmtes tut.
- Man kann eine Funktion **selbst schreiben**, oder eine **fertige Funktion** aus einer Bibliothek aufrufen.
- Damit spart man sich Arbeit, weil viele nützliche Dinge schon im .NET-Framework programmiert sind.

**Beispiele:**

`Console.WriteLine("Hallo");`

- `WriteLine(...)` is eine Funktion mit Parameter

`"Hallo".StartsWith("Ha")`

- `"Hallo"` ist ein String-Objekt (Zeichenkette)
- `StartsWith(...)` ist eine Funktion, die überprüft, ob die Zeichenkette mit einem bestimmten Text anfängt
- Rückgabetyp ist `bool` und somit Rückgabewert `true` oder `false`

---

# Ablauf einer Funktion

```csharp {all|6-7|8-9|11|1|11|12|2|12|13|3|13|14|4|14}{lines:true}
int Addiere(int a, int b) { return a + b };
int Subtrahiere(int a, int b) { return a - b; }
int Multipliziere(int a, int b) { return a * b; }
double Dividiere(int a, int b) { return (double) a / b; }

Console.Write("Zahl 1: ");
int x = int.Parse(Console.ReadLine());
Console.Write("Zahl 2: ");
int y = int.Parse(Console.ReadLine());

Console.WriteLine($"Summe: {Addiere(x,y)}");
Console.WriteLine($"Differenz: {Subtrahiere(x,y)}");
Console.WriteLine($"Produkt: {Multipliziere(x,y)}");
Console.WriteLine($"Quotient: {Dividiere(x,y)}");
```

Ausgabe:
```bash {all|1|2|2|2|3|3|3|4|4|4|5|5|5|6}{at:1}
Zahl 1: 4
Zahl 2: 2
Summe: 6
Differenz: 2
Produkt: 8
Quotient: 2
```

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