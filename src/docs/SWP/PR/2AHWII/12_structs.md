

## Einführung

Ein **Struct** ist ein **Werttyp**. Das heißt:

- Variablen eines Struct-Typs **enthalten den Wert direkt** (keine Referenz).
- **Zuweisen** oder **als Parameter übergeben** → es wird kopiert (Copy by Value)

## Syntax & Grundregeln

```csharp
public struct Point
{
    public int X;
    public int Y;

    public Point(int x, int y)  // benutzerdefinierter Konstruktor
    {
        X = x;
        Y = y;
    }

    public override string ToString() => $"({X},{Y})";
}
```

**Erzeugen & Kopierverhalten:**

```csharp
var p1 = new Point(2, 3);
var p2 = p1;      // KOPIE!
p2.X = 99;        // p1 bleibt (2,3)
```

!!! note "Parameterloser Konstruktor"
    - Bis C# 9: nicht erlaubt (Structs hatten implizit einen, der alle Felder auf 0/default setzt).
    - Ab C# 10: Erlaubt. Du kannst einen parameterlosen Konstruktor definieren und Felder initialisieren – erfordert passende Runtime (z. B. .NET 6+).

## Mutable Struct (veränderlich)

```csharp
using System;
					
public class Program
{
	public struct Counter
	{
		public int Value;

		public Counter(int v)
		{
			Value = v;
		}
		public void Inc() => Value++;

		public override string ToString() => $"Value is: ({Value})";
	}

	public static void Main()
	{
		Counter[] counterArray = new Counter[10];
		for (int i = 0; i < 10; i++) 
		{
			counterArray[i] = new Counter(i);
		}
		
		foreach (var counter in counterArray)
		{
			counter.Inc(); // Achtung: Erzeugt eine temporäre Kopie
			Console.WriteLine("Counter " + counter); // Ausgabe: 1 ... 10
		}
		
		foreach (var counter in counterArray)
		{
			Console.WriteLine("Counter " + counter); // Ausgabe: 0 ... 9
		}
	}
}
```

!!! warning "Achtung"
    Bei Kopien gehen Änderungen “verloren”, wenn du unbewusst an einer Kopie arbeitest (z. B. in foreach).


## Immutable Struct (unveränderlich)

### `readonly struct` (empfohlen für Werteobjekte)

```csharp
public readonly struct Size
{
    public int Width  { get; }
    public int Height { get; }
    public Size(int w, int h) { Width = w; Height = h; }

    public int Area => Width * Height;

	public override string ToString() => $"Size is: ({Width}x{Height})";

}

// Usage:
var s1 = new Size(100, 40);
s1.Width = 30; // Kompilierungsfehler: 
```

!!! tip "Vorteil"
    Klar als *unveränderlich* gekennzeichnet, verhindert versehentliche Kopien durch schreibende Member.
