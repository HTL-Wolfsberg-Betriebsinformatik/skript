---
theme: seriph
routerMode: hash
title: Structs in C#
info: |
  ## Structs in C#
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

# Structs

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---
layout: two-cols-header
layoutClass: gap-8
---

# Was sind Structs?

Ein **Struct** ist in C# eine **selbstgemachte Datensorte**.
Ähnlich wie `int`, `double` oder `bool`, kann man mit einem Struct **seinen eigenen Datentyp** erfinden, der **mehrere Werte zusammenhält**.

**Beispiel:**

- Nehmen wir an, wir wollen die Koordinaten eines Punktes speichern — also `x` und `y`.

::left::

⚠️ **Ohne** Structs müsste man zwei Variablen benutzen:

```csharp
int x = 10;
int y = 20;
```

::right::

✅ **Mit** Structs sagen wir: *"Ich habe einen Punkt, und der hat zwei Zahlen: X und Y."*

```csharp
struct Punkt
{
    public int X;
    public int Y;
}

Punkt p;
p.X = 10;
p.Y = 20;
```



---

# Warum braucht man Structs?

...weil Structs Dinge **zusammenfassen**, die **zusammengehören**.
Anstatt viele einzelne Variablen herumliegen zu haben, kann man einen **logischen Block** bilden.

<br>

**Beispiele:**

- Ein Punkt ➡️ X, Y
- Eine Farbe ➡️ Rot, Grün, Blau (RGB)
- ein Rechteck ➡️ Breite, Höhe

---

# Wie funktionieren Structs im Speicher?

Wenn wir eine Variable vom Typ `int` oder `double` anlegen, wird sie direkt im Speicher (auf dem Stack) gespeichert.
Structs sind genauso — sie sind **Wertetypen**, also werden sie direkt **kopiert**, nicht nur „verlinkt“.

```csharp
Punkt a;
a.X = 5;
a.Y = 10;

Punkt b = a; // Kopie!
b.X = 99;

Console.WriteLine(a.X); // 5
Console.WriteLine(b.X); // 99
```

Hier sieht man deutlich:
* `b` ist **eine Kopie** von `a`, also zwei getrennte Punkte.

---
layout: two-cols-header
layoutClass: gap-8
---

# Konstruktor in einem Struct

Ein Konstruktor ist einfach gesagt eine Start-Anleitung, wie dein Struct beim Erstellen befüllt werden soll.

```csharp
struct Punkt
{
    public int X;
    public int Y;
}
```


::left::
Ohne Konstruktor:

```csharp


Punkt p;
p.X = 10;
p.Y = 20;

```

::right::
Mit Konstruktor:

```csharp
Punkt p = new Punkt(); // Standardkonstruktor (setzt alles auf 0)
```

<br>

> 💡 Der Standardkonstruktor wird **automatisch erzeugt**
und **setzt alle Felder auf ihre Standardwerte** (`0`, `false`, `null`, usw.).

---

# Eigener Konstruktor

Wir können auch selbst bestimmen, **wie ein Struct gebaut wird**:

```csharp
struct Punkt
{
    public int X;
    public int Y;

    public Punkt(int x, int y) // Konstruktor mit Parameter
    {
        X = x;
        Y = y;
    }
}

```

<br>
Jetzt können wir den Punkt so anlegen:

```csharp
Punkt p = new Punkt(10, 20);
Console.WriteLine($"X: {p.X}, Y: {p.Y}");
```

---
layout: two-cols-header
layoutClass: gap-8
---

# Best Practice Struct-Konstruktor

::left::
In einem Struct-Konstruktor sollten <br> **alle Felder selbst gesetzt werden**.

```csharp
struct Punkt
{
    public int X;
    public int Y;

    public Punkt(int x)
    {
        X = x;
        // Y fehlt! --> Absicht oder keine Absicht
    }
}
```

::right::

**C# stellt automatisch** einen Standard Konstruktor zur Verfügung. Man könnte ihn notfalls überschreiben, sollte man aber nicht wenn nichts initialisiert wird.

```csharp
struct Punkt
{
    public int X;
    public int Y;

    public Punkt() // Standardverhalten überschreiben
    {
        X = 5;
        Y = 7;
    }
}
```
