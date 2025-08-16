## Was sind Bibliotheken?

Eine **Bibliothek** in der Programmierung ist eine **Sammlung von fertigen Funktionen und Klassen**, die man in seinen Programmen verwenden kann.

!!! warning "Achtung"
    `Klassen` sind nicht Teil der strukturierten Programmierung, allerdings können wir diese über Bibliotheken verwenden. 
    Für den momentan reicht es, dass `Klassen` ein Gruppierung von Funktionen/Methoden darstellen.

!!! tip "Vergleich" 
    Stell dir vor, du schreibst ein Referat. Du musst nicht alle Informationen selbst erfinden – du kannst dir Bücher aus einer Bibliothek holen.  
    Genauso holt sich ein Programm Funktionen aus Programmier-Bibliotheken.

---

## `using` - Einbinden von Bibliotheken

Mit dem Schlüsselwort `using` binden wir Bibliotheken in unser C#-Programm ein. 
Das Schlüsselwort steht ganz oben in der Datei.

## Beispiele

- `System` Bibliothek → enthält grundlegende Funktionen, z. B. `Console.WriteLine()`  
- `System.Math` Bibliothek → enthält mathematische Funktionen, z. B. `Math.Sqrt(16)` für die Quadratwurzel

**Beispiel: `System` Bibliothek**:

```csharp
using System;

Console.WriteLine("Hallo HTL"); // kommt aus der System-Bibliothek
```

!!! warning "Achtung"
    Seit .NET 6, gibt es ein vereinfachtes Template der `Program.cs` Datei für Konsolenanwendungen. 
    Das bedeutet, dass gewisse top-level `using` statements (e.g. `System`) automatisch hinzugefügt werden beim Bauen des Projekts.
    Entscheidend dafür ist in der Projektdatei (.csproj) das `<ImplicitUsings>enable</ImplicitUsings>`.
    Mehr dazu findet man in dieser [Dokumentation](https://learn.microsoft.com/en-us/dotnet/core/tutorials/top-level-templates).

**Beispiel: `System.Math` Bibliothek**:


```csharp
using System.Math;

double squareRoot = Sqrt(16); // kommt aus System.Math
```

Man kann auch nur die übergeordnete Bibliothek einbinden:

```csharp
using System;

double squareRoot = Math.Sqrt(16); // Math kommmt aus der System Bibliothek
```

Man kann auch komplett auf das Einbinden von Bibliotheken verzichten, indem man den vollen Namen schreibt:

```csharp
double squareRoot = System.Math.Sqrt(16);
```

## Warum sind Bibliotheken wichtig?

- Man muss nicht alles selbst programmieren (z. B. Quadratwurzel berechnen, Text verarbeiten).
- Spart Zeit und reduziert Fehler.
- Funktionen wurden von Experten entwickelt und getestet.
- In C#/.NET gibt es sehr viele Bibliotheken – für Text, Mathe, Dateien, Datenbanken, Web, usw.