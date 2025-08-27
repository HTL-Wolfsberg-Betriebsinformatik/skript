## Recap: Arrays

**Arrays** sind fix in der Länge und eignen sich gut für:

- bekannte, feste Größe
- sehr schnelle Indexzugriffe

**Nachteile:**

- Größe nicht dynamisch veränderbar
- Einfügen/Löschen in der MItte ist teuer (Verschieben)
- Kaum Komfortmethoden (Suchen, Entfernen, Sortieren nur rudimentär)

## Collections - Intro

Collections sind dynamische Datenstrukturen mit hilfreichen Methoden, besserer Erweiterbarkeit und meist guter Performance.

Collections liegen in `System.Collections` und `System.Collections.Generic`

```csharp
using System.Collections;
using System.Collections.Generic;
```

!!! warning "Achtung"
    Wir fokussieren uns auf `System.Collections.Generic`, da diese typsicher sind und keine Casts benötigen und dadurch besser performen.


## Wichtigste Collections im Überblick

| Collection                      | Kurzbeschreibung                      | Typischer Einsatz                                      |
| ------------------------------- | ------------------------------------- | ------------------------------------------------------ |
| `List<T>`                       | Dynamisches Array (am häufigsten)     | Flexible Liste, häufiges Hinzufügen am Ende            |
| `Dictionary<TKey,TValue>`       | Schlüssel–Wert-Speicher (Hash-Map)    | Schnelles Nachschlagen per Schlüssel                   |
| `HashSet<T>`                    | Menge, **keine Duplikate**            | Duplikate vermeiden, Mengenoperationen                 |
| `Queue<T>`                      | **FIFO**-Warteschlange                | Tasks nacheinander abarbeiten                          |
| `Stack<T>`                      | **LIFO**-Stapel                       | Rückgängig-Stack, Tiefensuche                          |
| `LinkedList<T>`                 | Doppelt verkettete Liste              | Häufige Einfügungen/Löschungen **an bekannten Knoten** |


## `<T>` - Generics

- In C# steht `<T>` für einen `Platzhalter-Typ` (Generic).
- Damit können Klassen und Methoden mit beliebigen Typen arbeiten, ohne den Code mehrfach zu schreiben.
- Der konkrete Typ wird beim Erstellen des Objekts angegeben.

**Beispiel ohne Generics:**

```csharp
using System.Collections;

ArrayList liste = new ArrayList();
liste.Add(42);
liste.Add("Hallo");   // funktioniert, aber unsicher
```
!!! danger "Achtung"
    - Man kann alles hinzufügen, aber beim Auslesen muss man casten, und Fehler passieren leicht.
    - .NET API empfiehlt `ArrayList` nicht mehr zu benutzen für neue Entwicklungen. Siehe [hier](https://learn.microsoft.com/en-us/dotnet/api/system.collections.arraylist?view=net-9.0)


**Beispiel mit Generics:**

```csharp
List<int> zahlen = new List<int>();
zahlen.Add(42);
// zahlen.Add("Hallo"); // ❌ Fehler: Nur integer erlaubt!
```

!!! tip "Merke"
    `<T>` ist ein Platzhalter für „Type“.
    Generics machen Collections **flexibel, sicher und wiederverwendbar**.

## O-Notation (Big-O)

Die **O-Notation** beschreibt, **wie schnell oder langsam** ein Algorithmus wächst, wenn die **Datenmenge größer wird**.
Es geht also nicht um „wie viele Millisekunden auf meinem PC“, sondern um die **grundsätzliche Skalierung**.

**Häufige Klassen von Laufzeiten:**

| Bezeichnung   | O-Notation | Erklärung (vereinfacht)                                  |
| ------------- | ---------- | -------------------------------------------------------- |
| konstant      | `O(1)`     | Immer gleich schnell, egal wie viele Daten               |
| linear        | `O(n)`     | Aufwand wächst proportional zur Anzahl der Elemente      |
| quadratisch   | `O(n²)`    | Aufwand wächst sehr stark, wenn Datenmenge größer wird   |
| logarithmisch | `O(log n)` | Aufwand wächst sehr langsam, auch bei großen Datenmengen |

**Beispiele mit Collections:**

- **Array / List Zugriff per Index:** `O(1)` (immer gleich schnell)
- **Suchen in unsortierter Liste:** `O(n)` (man muss im schlimmsten Fall alle durchgehen)
- **Sortieren:** `O(n log n)` (z. B. Quicksort Algorithmus)


## `List<T>` - die Standardliste

- dynamischer Speicher, amortisiert schnelles Append (`Add`)
- Indexzugriff `O(1)`, Einfügen/Löschen in der Mitte `O(n)`

```csharp
var list = new List<int> { 3, 1, 4 };
list.Add(2);                       // [3,1,4,2]
list.Insert(1, 99);                // [3,99,1,4,2]
list.Remove(4);                    // erstes 4 entfernen: [3,99,1,2]
list.RemoveAt(0);                  // Element an Index 0: [99,1,2]
list.Sort();                       // [1,2,99]
bool has99 = liste.Contains(99);    // true 
foreach (int x in list) Console.WriteLine(x);
```

**Konvertieren zwischen Array und List:**

```csharp
int[] arr = { 1, 2, 3 };
var list = new List<int>(arr);
int[] backToArray = list.ToArray();
```

**Wann benutzen?**

- Standardwahl, wenn du „eine Liste von Dingen“ brauchst.

## `Dictionary<TKey, TValue>` - Schlüssel/Wert

- Sehr schnelles Nachschlagen über **Key** (typisch `O(1)`)
- Keys müssen **eindeutig** sein

```csharp
var tel = new Dictionary<string, string>();
tel["Anna"] = "0664 123456";
tel["Markus"] = "0676 987654";

// Lesen mit TryGetValue:
if (tel.TryGetValue("Anna", out string nummer))
    Console.WriteLine(nummer);

// Sicheres Einfügen:
if (!tel.ContainsKey("Anna"))
    tel.Add("Anna", "0123");

// Iterieren:
foreach (var kvp in tel)
    Console.WriteLine($"{kvp.Key} → {kvp.Value}");
```

**Wann benutzen?**

- Wenn du per **Schlüssel** schnell auf Daten zugreifen willst (Index „by ID/Name“ statt Position in der Liste).

## `HashSet<T>` - Mengen ohne Duplikate

- Fügt ein Element nur einmal hinzu (`Add` liefert `false`, wenn vorhanden)
- sehr schnell für `Contains` (typisch `O(1)`)
- Mengenoperationen: `UnionWith`, `IntersectWith`, `ExceptWith`

```csharp
var s = new HashSet<string> { "HTL", "C#", "OOP" };
bool neu = s.Add("C#");              // false (schon vorhanden)
s.Add("Collections");

var a = new HashSet<int> { 1, 2, 3 };
var b = new HashSet<int> { 3, 4, 5 };
a.IntersectWith(b);                   // a = {3}
```

**Wann benutzen?**
- Wenn **keine Duplikate** erlaubt sind / Mengenlogik gebraucht wird.

## `Queue<T>` - FIFO

* **First-In-First-Out**
* Wie in einer Warteschlange an der Kasse - wer zuerst in der Schlage steht kommt als erstes wieder raus
* Support von Methoden wie `Enqueue` (rein), `Dequeue` (raus), `Peek` (nur ansehen)

```csharp
var q = new Queue<string>();
q.Enqueue("A");
q.Enqueue("B");
Console.WriteLine(q.Dequeue()); // A
Console.WriteLine(q.Peek());    // B (bleibt drin)
```

**Wann benutzen?**
- Warteschlangen, Puffer, Aufgaben nacheinander abarbeiten.

## `Stack<T>` - LIFO

* **Last-In-First-Out**
* Wie ein Stapel von Boxen - die erste Box ist unten, und die letzte Box ist oben. Boxen sollte man nur von oben entnehmen
* Support von Methoden wie `Push` (drauf), `Pop` (runter), `Peek` (oben ansehen)

```csharp
var st = new Stack<int>();
st.Push(10);
st.Push(20);
Console.WriteLine(st.Pop());   // 20
Console.WriteLine(st.Peek());  // 10
```

**Wann benutzen?**
- „Zurück“-Funktion: Alle Anweisungen in einer Anwendung können wiederhergestellt werden.

## `LinkedList<T>` - doppelt verkettete Liste

- Einfügen/Löschen ist `O(1)`, wenn du den Knoten (`LinkedListNode<T>`) hast
- Zugriff per Index ist teuer (O(n))

```csharp
var linkedList = new LinkedList<string>();
var nodeA = ll.AddLast("A");
var nodeB = ll.AddLast("B");
linkedList.AddAfter(nodeA, "X"); // A <-> X <-> B
linkedList.Remove(nodeB);        // A <-> X
```

**Wann benutzen?**
- Wenn du **häufig** Elemente **an bekannten Positionen** (über Knoten) einfügst/entfernst.

## Wann nehme ich welche Collection? (Faustregeln)

- „Ich brauche eine flexible Liste“ → List<T>
- „Ich habe Schlüssel und will schnell nachschlagen“ → Dictionary<TKey,TValue>
- „Duplikate vermeiden / Mengenlogik“ → HashSet<T>
- „Reihenfolge: zuerst rein, zuerst raus“ → Queue<T>
- „Reihenfolge: zuletzt rein, zuerst raus“ → Stack<T>
- „Viele Einfügungen/Löschungen an bekannten Stellen“ → LinkedList<T>
