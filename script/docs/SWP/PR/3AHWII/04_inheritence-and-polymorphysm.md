**Problemstellung:**

- Ein Programmierer will einen Fahrzeugsimulator bauen.
- Dabei muss er unterschiedlichste Fahrzeuge unterstützen (Autos, Motorräder, Traktoren, Tanklastwägen, uvm.)
- Da ein Tanklastwagen zwar ein Fahrzeug ist, aber mehr Attribute als ein Auto hat (e.g. `FuellmengeTank`) bzw Methoden (`Auffuellen()`, `Ausleeren()`) hat, wäre es hilfreich nicht jede Klasse von Null weg schreiben zu müssen
- Hier kommt **Vererbung** und **Polymorphismus** zum Einsatz.

## Vererbung

- Eine **Unterklasse** (Kindklasse) kann Eigenschaften und Methoden einer Oberklasse (Elternklasse) **erben**.
- Man spart sich **doppelte Codewiederholung**.
- Neue Klassen können **Spezialfälle** von allgmeinen Klassen sein.

**Beispiel: Unterschiedliche Fahrzeuge modellieren**

- Oberklasse = "Fahrzeug"
- Unterklassen = "Auto", "Motorrad", "Traktor", "Tanklastwagen", ...
- Alle Fahrzeuge können fahren --> **gemeinsamer Code in Fahrzeug Klasse**
- Nur Tanklastwägen können befüllt bzw entleert werden --> **spezifischer Code in Unterklasse**

```csharp
// Oberklasse: Fahrzeug
class Fahrzeug
{
    protected string Kennung;
    protected int Baujahr;

    public Fahrzeug(string kennung, int baujahr)
    {
        Kennung = kennung;
        Baujahr = baujahr;
    }

    public void Bewege(int km)
    {
        Console.WriteLine($"{Kennung}: fährt {km} km.");
    }

    public void Info()
    {
        Console.WriteLine($"[{Kennung}], Baujahr {Baujahr}");
    }
}

// Unterklasse: Auto
class Auto : Fahrzeug
{
    public Auto(string kennung, int baujahr) : base(kennung, baujahr) { }
}

// Unterklasse: Motorrad
class Motorrad : Fahrzeug
{
    public Motorrad(string kennung, int baujahr) : base(kennung, baujahr) { }
}

// Unterklasse: Traktor
class Traktor : Fahrzeug
{
    public Traktor(string kennung, int baujahr) : base(kennung, baujahr) { }
}

// Unterklasse: Tanklastwagen
class Tanklastwagen : Fahrzeug
{
    private int Fuellmenge;  // in Litern

    public Tanklastwagen(string kennung, int baujahr, int startFuellung = 0) 
        : base(kennung, baujahr)
    {
        Fuellmenge = startFuellung;
    }

    public void Auffuellen(int liter)
    {
        Fuellmenge += liter;
        Console.WriteLine($"{Kennung}: Tanklastwagen wurde mit {liter} L befüllt. Aktuell {Fuellmenge} L.");
    }

    public void Ausleeren(int liter)
    {
        if (liter > Fuellmenge)
        {
            Console.WriteLine($"{Kennung}: Nicht genug Inhalt – es werden nur {Fuellmenge} L ausgelassen.");
            Fuellmenge = 0;
        }
        else
        {
            Fuellmenge -= liter;
            Console.WriteLine($"{Kennung}: hat {liter} L ausgelassen. Verbleibend {Fuellmenge} L.");
        }
    }
}

// Hauptprogramm
class Program
{
    static void Main()
    {
        var flotte = new List<Fahrzeug>
        {
            new Auto("AUTO-AT-123", 2015),
            new Motorrad("BIKE-AT-007", 2019),
            new Traktor("TRACTOR-AT-42", 2010),
            new Tanklastwagen("TRUCK-AT-99", 2020, 500)
        };

        Console.WriteLine("=== Fahrzeugflotte ===");
        foreach (var f in flotte)
            f.Info();

        Console.WriteLine("\n=== Bewegung (30 km) ===");
        foreach (var f in flotte)
            f.Bewege(30);

        Console.WriteLine("\n=== Tanklastwagen Spezialfunktionen ===");
        Tanklastwagen truck = new Tanklastwagen("TRUCK-AT-77", 2022, 200);
        truck.Info();
        truck.Auffuellen(300);
        truck.Ausleeren(600);
    }
}
```

!!! warning "Achtung"
    - Listen benötigen einen Typen (in diesem Beispiel `Fahrzeug`, damit alle Unterklassen unterstützt werden). 
    - Dadurch verlieren wir aber z.B. beim Iterieren die Information welche Unterklasse an welcher Stelle in der Liste ist.
    - Es kann somit nicht leicht auf Spezialfunktionen der Unterklasse zugegriffen werden.


## Polymorphismus

- Polymorphismus = "Viele Gestalten"
- **Gleiche Methode** kann bei verschiedenen Objekten **unterschiedliche Verhalten** haben.
- Man nutzt **Vererbung + Überschreiben von Method**
- Damit das funktioniert, braucht man in C# diese Schlüsselwörter:
    - `virtual` (Basisklasse erlaubt Überschreiben),
    - `override` (Unterklasse überschreibt),
    - `abstract` (Unterklasse muss überschreiben).

### `override`

Das Schlüsselwort `override` verwendet man in einer **Unterklasse**, um eine als `virtual` (oder `abstract`) markierte Methode aus der Basisklasse zu **überschreiben**.
Dadurch kann die Unterklasse das Verhalten verändern oder spezialisieren.

> Wichtig: Der Methodenname und die Signatur bleiben gleich – nur die Implementierung wird ersetzt.

### `virtual`

Das Schlüsselwort `virtual` kennzeichnet in einer **Basisklasse** (=Oberklasse) eine Methode oder Eigenschaft, die eine **Standard-Implementierung** besitzt, aber von Unterklassen **überschrieben werden darf**.
Damit sagt die Basisklasse sinngemäß: *„So könnte man es machen, aber meine Kinder dürfen das Verhalten anpassen.“*

```csharp
class Fahrzeug
{
    public string Kennung { get; }
    public int Baujahr { get; }

    public Fahrzeug(string kennung, int baujahr)
    {
        Kennung = kennung;
        Baujahr = baujahr;
    }

    // Virtuelle Methode - kann überschrieben werden
    public virtual void Bewege(int km)
    {
        Console.WriteLine($"{Kennung}: fährt {km} km.");
    }
}

// Unterklasse: Auto
class Auto : Fahrzeug
{
    public Auto(string kennung, int baujahr) : base(kennung, baujahr) { }

    // Hat keine überschriebene "Bewege()" Methode und nutzt damit die Standardimplementierung der Fahrzeug Klasse
}

// Unterklasse: Motorrad
class Motorrad : Fahrzeug
{
    public Motorrad(string kennung, int baujahr) : base(kennung, baujahr) { }

    // Überschreibt die virtuelle Methode für einen individuellen Output bei Motorrädern.
    public override void Bewege(int km)
    {
        Console.WriteLine($"{Kennung}: Motorrad zischt flink {km} km durch den Verkehr.");
    }
}
```

### `abstract`

Das Schlüsselwort `abstract` wird in einer Basisklasse verwendet, wenn eine Methode **keine Standard-Implementierung** hat, sondern nur als **Pflicht** definiert wird.
Jede Unterklasse muss diese Methode dann mit `override` selbst bereitstellen.
Eine Klasse mit mindestens einer abstrakten Methode nennt man `abstrakte Klasse`, und sie kann nicht direkt erzeugt werden – sie dient nur als Bauplan.


```csharp
// Abstrakte Basisklasse: kann nicht direkt erzeugt werden
abstract class Fahrzeug
{
    public string Kennung { get; }
    public int Baujahr { get; }

    public Fahrzeug(string kennung, int baujahr)
    {
        Kennung = kennung;
        Baujahr = baujahr;
    }

    // Abstrakte Methode → MUSS von jeder Unterklasse überschrieben werden
    public abstract void Bewege(int km);
}

// Unterklasse: Auto
class Auto : Fahrzeug
{
    public Auto(string kennung, int baujahr) : base(kennung, baujahr) { }

    public override void Bewege(int km)
    {
        Console.WriteLine($"{Kennung}: Auto rollt {km} km über die Straße.");
    }
}

// Unterklasse: Motorrad
class Motorrad : Fahrzeug
{
    public Motorrad(string kennung, int baujahr) : base(kennung, baujahr) { }

    public override void Bewege(int km)
    {
        Console.WriteLine($"{Kennung}: Motorrad fährt flink {km} km durch den Verkehr.");
    }
}
```

!!! info "Zusammenfassung"
    - Die Methode `Bewege()` ist **abstrakt** → sie muss von jeder Unterklasse implementiert werden.
    - Es gibt **keine Standard-Implementierung** in der Basisklasse.
    - `Fahrzeug` Klasse ist **abstrakt** → man kann kein Objekt direkt davon erzeugen (`new Fahrzeug(...)` ist verboten).