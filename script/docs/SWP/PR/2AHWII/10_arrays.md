## Arrays

Ein Array ist eine geordnete Folge von Elementen gleichen Typs mit **fester Länge**. In C# ist jedes Array selbst ein Objekt (abgeleitet von System.Array).
Die Variable, die du deklarierst (z. B. int[] zahlen), enthält eine Referenz auf dieses Array-Objekt-
Wesentlich ist das **zusammenhängende Speicherlayout**: Die Elemente eines Arrays liegen direkt nebeneinander.

Wichtige Eigenschaften:

- 0-basiert: Der erste Index ist 0. Die Länge steht in array.Length (schreibgeschützt).
- Wertetypen vs. Referenztypen:
    - Bei Wertetypen (z. B. int, double) liegen die Werte inline im Array.
    - Bei Referenztypen (z. B. Point, Strings) speichert das Array Referenzen auf separate Objektinstanzen.
- Feste Größe: Arrays haben nach der Erstellung eine fixe Länge. „Vergrößern“ bedeutet, ein neues Array  anzulegen und Inhalte zu kopieren (z. B. via Array.Resize oder manuell).
- Sicherheitscheck: Jeder Zugriff wird auf Bounds geprüft; ein ungültiger Index führt zu IndexOutOfRangeException. Der JIT kann diese Checks in einfachen Schleifen teilweise optimieren.

### Deklaration & Initialisierung

```csharp
// Länge fest, Index ab 0
int[] zahlen = new int[5];                 // [0,0,0,0,0]
int[] prim = new[] { 2, 3, 5, 7, 11 };

// Zugriff
int erstes = prim[0];       // 2
prim[2] = 13;               // jetzt: {2,3,13,7,11}

// Länge (read-only)
int n = prim.Length;        // 5
```

!!! note "Defaultwerte"
    - Wertetypen (z. B. int, double, boolean) erhalten 0, 0.0, false, …
    - Referenztypen erhalten null.

### Iteration

```csharp
int summe = 0;

// for: Index verfügbar
for (int i = 0; i < prim.Length; i++)
{
    summe += prim[i];
}

// foreach: lesend & bequem
foreach (var p in prim)
{
    Console.WriteLine(p);
}
```

### Nützliche Array-Operationen

```csharp
int[] a = { 9, 4, 7, 1 };
Array.Sort(a);                 // {1,4,7,9}
Array.Reverse(a);              // {9,7,4,1}

// Kopieren
int[] b = new int[a.Length];
Array.Copy(a, b, a.Length);

// Clone (shallow copy)
int[] c = (int[])a.Clone();

// Suchen
int idx = Array.IndexOf(a, 7); // 2 (nach Sort war 7 an Position 2)

// Resize (erstellt intern neues Array)
Array.Resize(ref b, 10);       // b hat jetzt Länge 10

// Slicing
int[] data = { 10, 20, 30, 40, 50 };
int last = data[^1];      // ^1 = letztes Element → 50
int[] mitte = data[1..4]; // {20,30,40} (Start inkl., Ende exkl.)
```

### Mehrdimensionale Arrays

Mehrdimensionale Array sind Arrays welche in einer Dimension gleich viele Elemente besitzen. Sprich, ein 2-dimensionales Array bekommt man ein Rechteck (e.g. 3 Zeilen, 4 Spalten).

```csharp
// 2D-Array (Zeilen x Spalten)
double[,] matrix = new double[2, 3];
matrix[0, 1] = 1.5;
int zeilen = matrix.GetLength(0); // 2
int spalten = matrix.GetLength(1); // 3
```

### Jagged Arrays (Gezackt)

Im Unterschied zu **mehrdimensionalen Arrays** können **Jagged Arrays** in einer Dimension unterschiedlich viele Elemente besitzen.

```csharp
int[][] dreieck = new int[3][]; // 3 Zeilen,   

dreieck[0] = new[] { 1 }; // 1.Spalte = 1 Element,
dreieck[1] = new[] { 2, 3 }; // 2.Spalte = 2 Elemente,
dreieck[2] = new[] { 4, 5, 6, 9 }; // 3.Spalte = 4 Elemente

// Zugriff
int x = dreieck[2][1]; // 5
```

## Listen

- kapseln intern ein dynamisch wachsendes Array. 
- können von einem Datentyp viele Elemente beinhalten. 

!!! note "Merke"
    Oft sieht man in Dokumentation folgende Syntax: `List<T>`. Das `<T>` steht hierfür für einen generischen (=beliebigen) Typen der Elemente in der Liste, die der Programmier definiert. (e.g. `List<int>`, `List<double>`).

### Deklaration & Grundoperationen

```csharp
using System.Collections.Generic;

List<int> liste = new List<int> { 3, 1, 4 };
liste.Add(1);                 // {3,1,4,1}
liste.Insert(1, 99);          // {3,99,1,4,1}
liste.Remove(1);              // entfernt erste 1 → {3,99,4,1}
liste.RemoveAt(0);            // {99,4,1}
bool hatVier = liste.Contains(4); // true

int anzahl = liste.Count;     // 3
int element = liste[1];       // 4
```

### Häufige Methoden

| Methode                    | Zweck                                 |
| -------------------------- | ------------------------------------- |
| `Add(item)`                | Am Ende einfügen                      |
| `AddRange(IEnumerable<T>)` | Viele auf einmal                      |
| `Insert(index, item)`      | An Position einfügen                  |
| `Remove(item)`             | Erste Übereinstimmung entfernen       |
| `RemoveAll(pred)`          | Alle entfernen, die Prädikat erfüllen |
| `RemoveAt(index)`          | Element an Index entfernen            |
| `IndexOf(item)`            | Ersten Index finden                   |
| `Sort()` / `Sort(cmp)`     | Sortieren                             |
| `Reverse()`                | Umkehren                              |
| `Clear()`                  | Leeren                                |
| `ToArray()`                | In Array umwandeln                    |


### Lambda-Ausdruck (anonyme Funktion)

**Was ist das?**
`x => x % 2 == 0` is ein Beispiel für einen Lambda-Ausdruck und wird wie folgt gelesen:
> „Nimm ein `x` und gib `true` zurück, wenn `x` durch 2 teilbar ist, sonst `false`.”

- `=>` heißt **Lambda-Operator**
- Links stehen die **Parameter** (e.g. `x`), rechts ein **Ausdruck** oder **Block** (`x % 2 == 0`), der den Rückgabewert liefert.


**Beispiel: `RemoveAll(pred)`**

`pred` steht für Prädikat und bedeutet im einfachen Sinne eine anonyme Funktion, die `true` sein muss um ein Element zu entfernen.

```csharp
var zahlen = new List<int> { 5, 2, 9, 4, 1 };
zahlen.RemoveAll(x => x % 2 == 0); // entfernt alle geraden Zahlen → {5,9,1}
```

## Vergleich Arrays vs Listen

| Kriterium          | Array (`T[]`)                        | Liste (`List<T>`)                                      |
| ------------------ | ------------------------------------ | ------------------------------------------------------ |
| Größe              | Fix                                  | Dynamisch (wächst bei Bedarf)                          |
| Speicherlayout     | Zusammenhängend (gut für Cache)      | Intern dynamisch vergrößert                 |
| Komfort            | Basisoperationen                     | Viele Methoden out-of-the-box                          |
| Typische Nutzung   | Performance-kritisch, bekannte Größe | Allgemein, wenn Größe/Operationen flexibel sein sollen |


## Konvertieren zwischen Arrays und Liste

```csharp
using System.Linq;

int[] a = { 3, 1, 4 };
List<int> l = a.ToList();
int[] a2 = l.ToArray();
```

