# UML Klassendiagramme

- Teil der UML (Unified Modeling Language).
- Zeigt die Struktur von Klassen: Attribute, Methoden und Beziehungen.
- Dient als Bauplan: hilft beim Verstehen, Entwerfen und Dokumentieren von Programmen.

## Aufbau

```mermaid
classDiagram
  class Klassenname {
    Attributnamen
    Methodennamen()
  }
```

## Sichtbarkeit (Access Modifier)

- `+` = public
- `-` = private
- `#` = protected

**Beispiel: Klasse Auto**

```mermaid
classDiagram
    class Auto {
        - int geschwindigkeit
        - string marke
        + Beschleunigen(kmh: string) : void
        + Bremsen() : int
    }
```

C# Code:

```csharp
class Auto
{
    private int geschwindigkeit;
    private string marke;
    public void Beschleunigen(string kmh) { /* ... */ }
    public int Bremsen() { /* ... */ }
}
```


## Beziehungen zwischen Klassen

### Assoziation ("hat ein")

- Ein Lehrer **hat ein** (benutzt) Fachbuch.
- Beide Klassen können unabhängig voneinander existieren.

```mermaid
classDiagram
    class Lehrer {
        + Name : string
        + BenutzeBuch(buch : Fachbuch) : void
    }
    class Fachbuch {
        + Titel : string
    }
    Lehrer --> Fachbuch : benutzt
```

C# Code:

```csharp
class Fachbuch
{
    public string Titel { get; set; }
}

class Lehrer
{
    public string Name { get; set; }

    // Assoziation: Lehrer kennt ein Fachbuch
    public void BenutzeBuch(Fachbuch buch)
    {
        Console.WriteLine($"{Name} benutzt das Buch {buch.Titel}.");
    }
}
```



### Aggregation ("besteht aus")

- Eine Bibliothek **besteht aus** Büchern. 
- Ganzes (Bibliothek) kann Teile (Bücher) verlieren, Teile existieren weiter

```mermaid
classDiagram
    class Bibliothek {
        +Buecher : List<Buch>
        +FuegeHinzu(b : Buch) : void
    }
    class Buch {
        +Titel : string
    }
    Bibliothek o-- Buch : besteht aus
```

C# Code:

```csharp
class Buch
{
    public string Titel { get; set; }
}

class Bibliothek
{
    // Aggregation: Liste von Büchern
    public List<Buch> Buecher { get; } = new List<Buch>();

    public void FuegeHinzu(Buch b)
    {
        Buecher.Add(b);
    }
}
```


### Komposition

- Ein Haus **besteht zwingend** aus Räumen.
- Stärke Aggregation: "besteht zwingend aus"
- Teile (Räume) existieren nur mit dem Ganzen


```mermaid
classDiagram
    class Haus {
        +Raeume : List<Raum>
        +Haus()        // Konstruktor
    }
    class Raum {
        +Name : string
    }
    Haus *-- Raum : besteht zwingend aus
```

C# Code:

```csharp
class Raum
{
    public string Name { get; set; }
}

class Haus
{
    public List<Raum> Raeume { get; } = new List<Raum>();

    // Räume entstehen IM Haus → Komposition
    public Haus()
    {
        Raeume.Add(new Raum { Name = "Wohnzimmer" });
        Raeume.Add(new Raum { Name = "Küche" });
    }
}
```


### Vererbung

- Auto **ist ein** Fahrzeug

```mermaid
classDiagram
    class Fahrzeug
    class Auto
    class Traktor
    class Motorrad
    Fahrzeug <|-- Auto
    Fahrzeug <|-- Traktor
    Fahrzeug <|-- Motorrad
```

### Interfaces

- Auto **implementiert** `IFahrbar`

```mermaid
classDiagram
    class IFahrbar {
        + Bewege()
    }
    class Auto
    class Traktor
    class Motorrad
    IFahrbar <|.. Auto
    IFahrbar <|.. Traktor
    IFahrbar <|.. Motorrad
```
