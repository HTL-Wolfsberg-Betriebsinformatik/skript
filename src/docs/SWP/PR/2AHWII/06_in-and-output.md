## Einführung

Unter **Ein- und Ausgabe** versteht man:
- **Eingabe**: Daten, die der Benutzer ins Programm eingibt.
- **Ausgabe**: Informationen, die das Programm an den Benutzer ausgibt.

In C# (mit .NET) arbeiten wir in der ersten Klasse meist mit **Konsolenprogrammen**.  
Die wichtigsten Befehle dafür sind:

| Methode                  | Zweck |
|--------------------------|-------|
| `Console.Write()`        | Text ausgeben **ohne** Zeilenumbruch |
| `Console.WriteLine()`    | Text ausgeben **mit** Zeilenumbruch |
| `Console.ReadLine()`     | Eine **Textzeile** einlesen |
| `Console.ReadKey()`      | Ein **einzelnes Zeichen** einlesen |

---

## Ausgabe

### Einfacher Text
```csharp
Console.WriteLine("Hallo HTL!");
Console.Write("Dies ist ");
Console.Write("eine Zeile");
```

!!! info "Unterschied"
    - WriteLine() fügt am Ende \n (Zeilenumbruch) ein.
    - Write() nicht.


### Variablen ausgeben
```csharp
string name = "Max";
int alter = 16;

Console.WriteLine("Name: " + name + ", Alter: " + alter); // Verkettung
Console.WriteLine($"Name: {name}, Alter: {alter}");       // String-Interpolation
Console.WriteLine("Name: {0}, Alter: {1}", name, alter);  // Platzhalter
```

## Eingabe

### Text einlesen

```csharp
Console.Write("Wie heißt du? ");
string name = Console.ReadLine();
Console.WriteLine("Hallo " + name);
```

### Typumwandlung

| Methode          | Beschreibung                   |
| ---------------- | ------------------------------ |
| `int.Parse()`    | String → int (Ganzzahl)        |
| `double.Parse()` | String → double (Kommazahl)    |
| `bool.Parse()`   | String → bool (`true`/`false`) |


### Zahl einlesen

- `Console.ReadLine()` liefert immer einen String.
- Für Zahlen müssen wir parsen:

```csharp
Console.Write("Wie alt bist du? ");
int alter = int.Parse(Console.ReadLine());
Console.WriteLine($"Du bist {alter} Jahre alt.");
```

### Sichere Eingabe mit `TryParse()`

- `TryParse()` verhindert Programmabstürze bei falscher Eingabe.
- **Vorteil**: Das Programm läuft weiter, auch wenn der Benutzer Unsinn eingibt.

```csharp
Console.Write("Bitte eine ganze Zahl eingeben: ");
string eingabe = Console.ReadLine();

if (int.TryParse(eingabe, out int zahl))
{
    Console.WriteLine($"Erfolgreich eingelesen: {zahl}");
}
else
{
    Console.WriteLine("Ungültige Eingabe!");
}
```

!!! warning "Achtung"
    `TryParse` benutzt einen speziellen `out` Parameter. Mehr dazu im Kapitel [Funktionen](./09_functions.md)

### Einzelnes Zeichen einlesen

```csharp
Console.Write("Beliebige Taste drücken...");
Console.ReadKey(); // wartet auf Tastendruck
```

### Beispielprogramm: Taschenrechner

```csharp
Console.Write("Zahl 1: ");
double zahl1 = double.Parse(Console.ReadLine());

Console.Write("Zahl 2: ");
double zahl2 = double.Parse(Console.ReadLine());

double summe = zahl1 + zahl2;
Console.WriteLine($"Ergebnis: {summe}");
```
