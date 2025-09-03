# Get/Set Properties in `C#`

## Ausgangslage

Klassen beinhalten oft **Attribute** die gelesen oder geschrieben werden müssen. Da allerdings in der OOP es "bad practice" ist, einfach von außen auf diese zu schreiben, werden Attribute `private` definiert und eigene **Methoden** geschrieben um diesen Zweck zu erfüllen.

**Beispiel:**

```csharp
class Auto
{
    private int geschwindigkeit; // internes Feld

    // Setter-Methode
    public void SetGeschwindigkeit(int neueGeschwindigkeit)
    {
        if (neueGeschwindigkeit >= 0)
            geschwindigkeit = neueGeschwindigkeit;
        else
            Console.WriteLine("Ungültige Geschwindigkeit!");
    }

    // Getter-Methode
    public int GetGeschwindigkeit()
    {
        return geschwindigkeit;
    }
}

class Program
{
    static void Main()
    {
        Auto a = new Auto();

        a.SetGeschwindigkeit(120);     // Wert setzen
        Console.WriteLine(a.GetGeschwindigkeit()); // Wert holen

        a.SetGeschwindigkeit(-50);     // Abgefangen durch Setter
    }
}
```

**Nachteile:**

1. Unübersichtliche Namensgebung
    - Mit Methoden muss man zusätzliche Namen einführen (`GetX()`, `SetX(value)`), obwohl es eigentlich nur ein **Attribut X** ist.
    - Wenn man später den Namen des Attributs ändern will, muss man auch alle Methoden anpassen.
2. Boilerplate-Code (viel Schreibarbeit)
    - Für jedes Attribut braucht man zwei Methoden (Get..., Set...).
    - Bei Klassen mit vielen Attributen bedeutet das sehr viel wiederholten Code.
3. Schlechte Lesbarkeit
    - Aufrufe wirken kompliziert
    ```csharp
    schueler.SetName("Anna");
    Console.WriteLine(schueler.GetName());
    ```

## Die Lösung: Properties

Wenn wir für jedes Attribut eigene Get...- und Set...-Methoden schreiben, führt das schnell zu unnötig viel Code und unübersichtlicher Namensgebung.
Um diese Probleme zu lösen, bietet C# mit **Properties** eine elegantere und einheitliche Lösung, die wie Felder aussehen, aber die gleiche Kontrolle wie Methoden erlauben.

### Aufbau

Eine Property besteht aus:

- Getter (`get`): Wert zurückgeben
- Setter (`set`): Wert setzen (mit Kontrolle möglich)

```csharp
class Auto
{
    private int geschwindigkeit; // internes Feld

    public int Geschwindigkeit
    {
        get { return geschwindigkeit; }         // Wert lesen
        set { geschwindigkeit = value; }        // Wert schreiben
    }
}
```

!!! tip "Merke"
    `value` ist ein Schlüsselwort: es steht für den Wert, den man setzen möchte.


Nutzung:

```csharp
Auto a = new Auto();
a.Geschwindigkeit = 80;                // ruft den Setter auf
Console.WriteLine(a.Geschwindigkeit);  // ruft den Getter auf
```

### Kontrolle im Setter

Wir können Regeln einbauen, um unsinnige Werte zu verhindern.

```csharp
class Auto
{
    private int geschwindigkeit;

    public int Geschwindigkeit
    {
        get { return geschwindigkeit; }
        set
        {
            if (value >= 0)
                geschwindigkeit = value;
            else
                Console.WriteLine("Ungültige Geschwindigkeit!");
        }
    }
}
```

```csharp
Auto a = new Auto();
a.Geschwindigkeit = 100;    // gültig
a.Geschwindigkeit = -50;    // "Ungültige Geschwindigkeit!"
```

### Auto-Properties (Kurzschreibweise)

Wenn keine zusätzliche Logik nötig ist, kann man Auto-Properties verwenden

```csharp
class Auto
{
    public string Marke { get; set; }   // Kurzschreibweise
    public int Baujahr { get; set; }
}
```

```csharp
Auto a = new Auto { Marke = "VW", Baujahr = 2015 };
Console.WriteLine($"{a.Marke}, {a.Baujahr}");
```

### Nur-lesbare Properties (readonly)

Manchmal will man nur einen Getter anbieten.

```csharp
class Auto
{
    public string Marke { get; };
}
```

Properties erlauben auch das initialisieren von Standardwerten:

```csharp
class Auto
{
    public string Marke { get; } = "VW";
}
```

### Öffentlich lesbar, privat schreibbar

```csharp
class Auto
{
    public int Kilometerstand { get; private set; }

    public void Fahren(int km)
    {
        Kilometerstand += km; // nur die Klasse darf das Attribut setzen
    }
}
```

## Properties vs. Konstruktor

Durch **Properties** erhalten wir einen Konstruktor-ähnlichen Effekt, nämlich das initalisieren von Attributen eines Objektes.
Trotzdem gibt es Unterschiede in der Verwendung der beiden Features.

### Konstruktor-Initialisierung

Man übergibt die Werte direkt im Konstruktor:

```csharp
class Schueler
{
    public string Name { get; set; }
    public int Alter { get; set; }

    public Schueler(string name, int alter)
    {
        Name = name;
        Alter = alter;
    }
}

class Program
{
    static void Main()
    {
        var s = new Schueler("Anna", 16);
        Console.WriteLine($"{s.Name}, {s.Alter}");
    }
}
```

**Vorteil:**

- Man **erzwingt**, dass beim Erstellen des Objekts **wichtige Werte gesetzt werden**.
- Gut, wenn bestimmte Eigenschaften niemals leer sein dürfen.

### Objekt-Initialisierung (Properties direkt setzen)

Man erstellt das Objekt mit dem Standardkonstruktor und setzt die Properties direkt:

```csharp
class Schueler
{
    public string Name { get; set; }
    public int Alter { get; set; }
}

class Program
{
    static void Main()
    {
        var s = new Schueler { Name = "Anna", Alter = 16 };
        Console.WriteLine($"{s.Name}, {s.Alter}");
    }
}
```

**Vorteil:**

- Weniger Schreibarbeit, sehr lesbar und übersichtlich.
- Praktisch, wenn viele **optionale** Eigenschaften existieren.

### Wann was?

- Konstruktor: wenn gewisse Werte zwingend erforderlich sind, um ein gültiges Objekt zu erstellen.
- Objekt-Initialisierer: wenn man ein Objekt flexibel zusammenbauen möchte, besonders bei vielen optionalen Properties.


!!! tip "Merke"
    Der Konstruktor stellt sicher, dass ein Objekt schon beim Erzeugen „vollständig“ ist.
    Objekt-Initialisierer sind bequemer, wenn man viele Werte hat, die auch leer bleiben dürften.

### Beispiel

```csharp
class Schueler
{
    // Pflichtwerte (müssen im Konstruktor gesetzt werden)
    public string Name { get; }
    public int Alter { get; }

    // Optionale Werte (können später gesetzt werden)
    public double Notenschnitt { get; set; }
    public string Klasse { get; set; }

    // Konstruktor verlangt die Pflichtwerte
    public Schueler(string name, int alter)
    {
        Name = name;
        Alter = alter;
    }

    public void Info()
    {
        Console.WriteLine($"{Name}, {Alter} Jahre, Notenschnitt: {Notenschnitt}, Klasse: {Klasse}");
    }
}

class Program
{
    static void Main()
    {
        // Pflichtwerte über Konstruktor, optionale über Objekt-Initialisierer
        var s1 = new Schueler("Anna", 16) 
        { 
            Notenschnitt = 1.7, 
            Klasse = "3AHIF" 
        };

        // Nur Pflichtwerte gesetzt, optionale bleiben Standardwerte
        var s2 = new Schueler("Markus", 17);

        s1.Info();
        s2.Info();
    }
}
```

**Ausgabe:**

```bash
Anna, 16 Jahre, Notenschnitt: 1,7, Klasse: 3AHIF
Markus, 17 Jahre, Notenschnitt: 0, Klasse:
```

**Erklärung**

- **Name** und **Alter** sind Pflicht → ohne sie kann man keinen Schüler erstellen.
- **Notenschnitt** und **Klasse** sind optional → können später oder gar nicht gesetzt werden.
- Mit dieser Kombination hat man **Sicherheit + Flexibilität**.
