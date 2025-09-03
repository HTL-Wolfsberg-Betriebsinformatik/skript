# Einführung in die Objektorientierte Programmierung (OOP)

In der **strukturierten Programmierung** haben wir **Daten** (z. B. Variablen, Arrays) und Funktionen, die **nebeneinander** (auf gleicher Ebene) existieren.
Das wird bei größeren Programmen schnell unübersichtlich.

Die **objektorientierte Programmierung** versucht, Daten und das, was man mit diesen Daten tun kann, **in einer Einheit zu bündeln**.
Diese Einheit nennt man **Klasse**.

## Klasse und Objekt – die Grundidee

- Eine **Klasse** ist ein **Bauplan** (Definition).
- Ein **Objekt** ist eine **Instanz** (konkretes Ding), das nach dem Bauplan gebaut wurde.
- **Beispiel aus dem Alltag:**
    - Klasse = Bauplan „Auto“
    - Objekt = mein roter VW Golf, dein blauer Tesla
- Jedes Objekt hat:
    - **Attribute (Eigenschaften)**: z. B. Farbe, PS, Baujahr
    - **Methoden (Verhalten)**: z. B. fahren, bremsen, hupen

```csharp
// Klasse
class Auto
{
    // Attribute (Eigenschaften)
    public string Marke;
    public string Farbe;
    public int Baujahr;

    // Methode (Verhalten)
    public void Hupen()
    {
        Console.WriteLine("Hup! Hup!");
    }
}
```

```csharp
class Program
{
    static void Main()
    {
        // Ein Objekt erzeugen (Instanz)
        Auto meinAuto = new Auto();
        meinAuto.Marke = "VW";
        meinAuto.Farbe = "Rot";
        meinAuto.Baujahr = 2015;

        Console.WriteLine($"Mein Auto ist ein {meinAuto.Farbe}er {meinAuto.Marke}, Baujahr {meinAuto.Baujahr}.");
        meinAuto.Hupen();
    }
}
```

Ausgabe: 
```bash
Mein Auto ist ein Roter VW, Baujahr 2015.
Hup! Hup!
```



## Konstruktor - der Erzeuger

- Ein **Konstruktor** ist wie ein **Baumeister**.
- Er nimmt den Bauplan (**Klasse**) und erzeugt daraus ein neues **Objekt (Instanz)** mit Startwerten.
- Jede Klasse 
    - hat automatisch einen Standardkonstruktor (ohne Übergabeparameter -> ähnlich wie Funktionen)
    - kann einen Konstruktoren mit Übergabeparametern haben
 
```csharp
class Auto
{
    private string Marke;
    private string Farbe;
    private int Baujahr;

    // Konstruktor
    public Auto(string marke, string farbe, int baujahr)
    {
        Marke = marke;
        Farbe = farbe;
        Baujahr = baujahr;
    }

    public void Hupen()
    {
        Console.WriteLine("Hup! Hup!");
    }
}

class Program
{
    static void Main()
    {
        Auto meinAuto = new Auto("Tesla", "Blau", 2022);
        Console.WriteLine($"Mein Auto ist ein {meinAuto.Farbe}er {meinAuto.Marke}, Baujahr {meinAuto.Baujahr}.");
        meinAuto.Hupen();
    }
}
```
 

!!! tip "Merke"
    Ein **Konstruktor** hat die "Weisheit", wie ein Objekt bzw Instanz erstellt wird. Die **Attribute** selbst sind nun nicht mehr `public`, was bedeutet dass außerhalb der **Klasse** niemand darauf Zugriff hat. 
 

## Kapselung von Daten

**Klassen** sind, abgesehen von ihrem objektorientierten Konzept, gut um Daten zu kapseln. 

Das bedeutet, eine Klasse kann bestimmen wer alles auf ihre Inhalte (Attribute und Methoden) zugreifen darf.

**Beispiel - Auto:**

- Ergänzend zum vorherigen Beispiel, könnte ein Auto auch ein Attribut `int Geschwindigkeit` haben. 
- Wenn von außen nun jemand die Geschwindigkeit einfach überschreiben könnte mit z.B. negative Zahlen oder Bereiche die der Motor nicht schaffen würde, hätte das fatale Konsequenzen (z.B in einem Fahrzeugsimulator).
- Besser wäre es, wenn man von außen diesen Eingriff gleich verhindern könnte, und eine **Methode** in der Klasse hätte, die kontrolliert die Geschwindigkeit verändert (z.B. negative Zahlen nicht erlauben)
- Aus diesem Grund gibt es sogenannte **Access Modifiers**.

### Access Modifiers

**Access Modifier** bestimmen, **von wo aus** man auf Attribute und Methoden einer Klasse zugreifen darf.
Man nennt das auch **Sichtbarkeit**.

**Die wichtigsten Access Modifier in C#:**

- **public**: von überall im Programm sichtbar und verwendbar
- **private**: nur innerhalb der Klasse selbst sichtbar
- **protected**: sichtbar in der Klasse und in abgeleiteten Klassen (Hinweis: Dieses Thema kommt im Kapitel "Vererbung" vor)

**Beispiel ohne Schutz:**

```csharp
class Auto
{
    public int Geschwindigkeit;
}

class Program
{
    static void Main()
    {
        Auto a = new Auto();
        a.Geschwindigkeit = -200; // Unsinn!
        Console.WriteLine(a.Geschwindigkeit);
    }
}
```
> Das Programm akzeptiert eine negative Geschwindigkeit, obwohl das inhaltlich falsch ist.

**Beispiel mit Schutz:**

```csharp
class Auto
{
    private int geschwindigkeit;

    public void SetGeschwindigkeit(int wert)
    {
        if (wert >= 0 && wert <= 240)
            geschwindigkeit = wert;
        else
            Console.WriteLine("Ungültige Geschwindigkeit!");
    }

}

class Program
{
    static void Main()
    {
        Auto a = new Auto();
        // a.geschwindigkeit = 20;                 // würde einen Kompilierungsfehler erzeugen
        a.SetGeschwindigkeit(100);                 // Gültig, wird gesetzt
        a.SetGeschwindigkeit(-50);                 // Ungültig, wird nicht gesetzt
        a.SetGeschwindigkeit(250);                 // Ungültig, wird nicht gesetzt
    }
}
```

## Mehrere Objekte einer Klassen

Wie schon gesagt, eine Klasse ist ein **Bauplan**.

Aus einem Bauplan kann man **beliebig viele Objekte erzeugen** – jedes Objekt ist eigenständig, auch wenn alle nach dem gleichen Plan gebaut sind.

**Beispiel:**

- Klasse: `Auto`
- Objekte: roter VW, blauer Tesla, schwarzer BMW
- Alle sind Autos, aber jedes hat **eigene Attribute** (Marke, Farbe, Baujahr).


```csharp

class Auto
{
    public string Marke;
    public string Farbe;
    public int Baujahr;

    public void Hupen()
    {
        Console.WriteLine($"{Marke} hupt: Hup! Hup!");
    }
}

class Program
{
    static void Main()
    {
        // Erstes Objekt
        Auto auto1 = new Auto();
        auto1.Marke = "VW";
        auto1.Farbe = "Rot";
        auto1.Baujahr = 2015;

        // Zweites Objekt
        Auto auto2 = new Auto();
        auto2.Marke = "Tesla";
        auto2.Farbe = "Blau";
        auto2.Baujahr = 2022;

        // Drittes Objekt
        Auto auto3 = new Auto();
        auto3.Marke = "BMW";
        auto3.Farbe = "Schwarz";
        auto3.Baujahr = 2020;

        // Jedes Auto ist unabhängig
        auto1.Hupen();
        auto2.Hupen();
        auto3.Hupen();
    }
}
```

Ausgabe: 
```bash
VW hupt: Hup! Hup!
Tesla hupt: Hup! Hup!
BMW hupt: Hup! Hup!
```

**Objekte in einer Sammlung speichern:**

Damit man mit vielen Objekten arbeiten kann, speichert man sie in Arrays oder Collections.
(z. B. eine Liste aller Autos in einem Autohaus)

```csharp
using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        List<Auto> autos = new List<Auto>();

        autos.Add(new Auto { Marke = "VW", Farbe = "Rot", Baujahr = 2015 });
        autos.Add(new Auto { Marke = "Tesla", Farbe = "Blau", Baujahr = 2022 });
        autos.Add(new Auto { Marke = "BMW", Farbe = "Schwarz", Baujahr = 2020 });

        foreach (Auto a in autos)
        {
            Console.WriteLine($"{a.Marke} ({a.Farbe}, {a.Baujahr})");
        }
    }
}
```

Ausgabe:
```bash
VW (Rot, 2015)
Tesla (Blau, 2022)
BMW (Schwarz, 2020)
```
