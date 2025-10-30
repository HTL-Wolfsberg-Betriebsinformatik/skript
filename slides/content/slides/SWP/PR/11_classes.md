---
theme: seriph
routerMode: hash
title: Klassen in OOP in C#
info: |
  ## Klassen in OOP in C#
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

# Objektorientierte Programmierung

## Klassen

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Warum brauchen wir Klassen?

Structs reichen für einfache Daten, aber sobald Dinge **Verhalten** haben (z. B. ein Auto, das fahren kann), brauchen wir **Klassen**.

- Klassen sind das Herz der objektorientierten Programmierung (OOP).
- Sie beschreiben wie etwas aussieht (Daten) und was es tun kann (Methoden).

<br>

**Beispiel:**

```csharp
class Haus
{
    public int AnzahlFenster;
    public string Farbe;

    public void OeffneFenster()
    {
        Console.WriteLine("Fenster geöffnet!");
    }
}
```

---

# Klassen = der Bauplan 📝

Eine Klasse ist wie ein **Bauplan** für ein **Haus**.

- Der Bauplan beschreibt, welche Räume, Fenster und Türen das Haus hat.
- Aber solange der Plan nur auf Papier existiert, steht noch kein Haus.

```csharp
class Player
{
    public int Lebenspunkte;

    public void Angreifen()
    {
        Console.WriteLine($"Spieler greift an.");
    }
}
```

<br>

> 👉 Diese Klasse ist nur die Anleitung, kein echtes Objekt im Speicher.

---

# Der Konstruktor = der Baumeister 👷‍♂️

Damit aus einem Bauplan ein echtes Haus wird, braucht man jemanden, der es baut – den **Baumeister**.

In C# übernimmt das der **Konstruktor**.

```csharp
class Player
{
    public int Lebenspunkte;

    public Player(int lebenspunkte) // Konstruktor
    {
        this.Lebenspunkte = lebenspunkte;
    }

    public void Angreifen()
    {
        Console.WriteLine($"Spieler greift an.");
    }
}
```

---

# Das Objekt = das gebaute Haus 🏠

Wenn der Bauplan (Klasse) umgesetzt wird, entsteht ein konkretes **Objekt** – das „echte Haus“.

```csharp
Player player = new Player(100);
Player enemy = new Player(50);

Console.WriteLine(player.Lebenspunkte); // 100
Console.WriteLine(enemy.Lebenspunkte); // 50
```

<br>

> 💡 Merke: Objekt = Instanz der Klasse.

---

# Objekte referenzieren

Eine Klasse erstellt ein Objekt, und ein Objekt ist ein **Referenztyp** (*"referenzieren"*).

**Stell dir ein Schulspind-System vor:**
- Der Spind (Objekt) steht irgendwo im Schulhaus → das ist der Speicher im Heap.
- Die Spindnummer (Referenz) steht auf deinem Schlüsselanhänger → das ist die Variable im Code.

```csharp
Haus a = new Haus("Weiß");  // a speichert die „Spindnummer“
Haus b = a;                 // b bekommt dieselbe Nummer

b.Farbe = "Grün";
Console.WriteLine(a.Farbe); // Ausgabe: Grün
```

➡️ Beide Variablen (`a` und `b`) zeigen auf dasselbe Objekt (im Speicher).

➡️ Variablen von Klassen speichern nicht das Objekt selbst,
sondern nur eine Referenz (Adresse), um es zu erreichen.

---

# Zusammenfassung

| Begriff         | Analogie     | Bedeutung                                |
| --------------- | ------------ | ---------------------------------------- |
| **Klasse**      | Bauplan      | Vorlage, beschreibt Aufbau und Verhalten |
| **Konstruktor** | Baumeister   | Erzeugt das Objekt und befüllt es        |
| **Objekt**      | Haus / Spind | Konkrete Instanz im Speicher             |
| **Referenz**    | Spindnummer  | Zeiger auf das Objekt im Heap            |

