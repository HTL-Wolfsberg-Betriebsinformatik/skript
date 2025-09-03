- Mit `var` überlässt man es dem Compiler, den Typ zu erschließen (type inference).
- var ist ein Schlüsselwort für implizite Typinferenz
- Der Typ ist trotzdem `statisch` und ändert sich nicht!

!!! note "Hinweis"
    Implizite Typeinferenz bedeutet, dass der Compiler sich den rechten Ausdruck ansieht und den den statischen Typ daraus ableitet.

```csharp
var x = 5;           // Compiler: x ist int
var name = "Anna";   // Compiler: name ist string
var liste = new List<string>(); // Compiler: liste ist List<string>
```

Nach der Zuweisung steht der Typ **fest** und ist **statisch** wie bei einer normalen Deklaration. Man kann ihn nicht mehr ändern:

```csharp
var x = 5;   // x ist int
x = "Hallo"; // ❌ Fehler: string passt nicht zu int
```


**Wann ist `var` sinnvoll**

1. Wenn der Typ rechts eindeutig erkennbar ist

- Erhöht Lesbarkeit, weil der Code kürzer wird.
- Typ kann man direkt vom Ausdruck erkennen.

```csharp
var schueler = new Schueler("Anna", 16);  // klar erkennbar: Schueler
var liste = new List<string>();           // klar erkennbar: List<string>
```

2. Bei langen/komplizierten Typnamen

- Macht den Code viel übersichtlicher.

```csharp
Dictionary<string, List<int>> daten = new Dictionary<string, List<int>>();
var daten = new Dictionary<string, List<int>>();  // deutlich kürzer
```

3. Bei anonymen Typen (ohne Namen)

- Nur möglich mit `var`.

```csharp
var person = new { Name = "Anna", Alter = 16 };
```


**Wann lieber den Typ ausschreiben**

1. Wenn der Typ nicht sofort erkennbar ist

```csharp
var ergebnis = Berechne();  // Was kommt hier zurück? int? double? Liste?
int ergebnis = Berechne();  // Sofort klar
```

!!! tip "Merke"
    `var` spart Schreibarbeit, aber nur dann einsetzen, wenn der Typ eindeutig ist – sonst lieber den Typnamen ausschreiben.
