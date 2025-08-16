## Einführung

Eine **Funktion** (in C# meist *Methode* genannt) ist ein **abgegrenzter Programmbaustein**, der eine bestimmte Aufgabe erfüllt.  
Vorteile:
- Code wird **übersichtlicher** und **wiederverwendbar**
- **Fehler leichter finden** (kleinere Bausteine statt Riesencode)
- Programme lassen sich **besser strukturieren**

!!! note "Merksatz"
    Eine Funktion ist wie ein Werkzeug: Einmal definiert, kann man es immer wieder benutzen.

---

## Aufbau einer Funktion

```csharp
Rückgabewert Funktionsname(Parameterliste)
{
    // Funktionsrumpf
    return Rückgabewert; // falls Rückgabewert nicht void
}
```

**Beispiel:**

```csharp
int Add(int a, int b)
{
    int sum = a + b;
    return sum;
}
```

---

## Funktionen ohne Rückgabewert (void)

Manchmal soll die Funktion nur etwas tun, aber nichts zurückgeben.

```csharp
void Greeting()
{
    Console.WriteLine("Hello World");
}

// Aufruf:
Greeting();
```

---

## Funktionen mit Rückgabewert

Eine Funktion kann einen Wert zurückgeben – wichtig, wenn man ein Ergebnis weiterverwenden will.

```csharp
double SquareOfFive()
{
    return 5 * 5;
}

// Aufruf:
double result = SquareOfFive();
Console.WriteLine($"Ergebnis: {result}");
```

---

## Parameterübergabe

Parameter sind Platzhalter für Werte, die beim Funktionsaufruf übergeben werden.

```csharp
double Square(double number)
{
    return number * number;
}

// Aufruf:
double result = Square();
Console.WriteLine($"Ergebnis: {result}");
```

### Mehrere Paramenter

```csharp
int Multipliziere(int a, int b)
{
    return a * b;
}
```

### Standardwerte für Parameter

```csharp
void Begruessung(string name = "Gast")
{
    Console.WriteLine("Hallo " + name);
}
```

### Der `out`-Parameter

Normalerweise kann eine Funktion **nur einen Rückgabewert** haben.  
Mit **`out`-Parametern** kann man jedoch **mehrere Werte zurückgeben**.

**Beispiel 1: Restwert einer Division zurückgeben**
```csharp
int DivideWithRest(int dividend, int divisor, out int rest)
{
    rest = dividend % divisor;     // Rest wird über out zurückgegeben
    return dividend / divisor;     // Ergebnis als Rückgabewert
}

int r;
int ergebnis = DivideWithRest(17, 5, out r);

Console.WriteLine($"17 / 5 = {ergebnis}, Rest = {r}");
```

!!! tip "Erklärung"
    - `out` bedeutet: Diese Variable wird in der Funktion gesetzt und dann an den Aufrufer zurückgegeben.
    - Man kann so mehrere Werte aus einer Funktion herausgeben.
    - Die Variable muss beim Aufruf mitgegeben werden, aber nicht vorher initialisiert sein.

**Beispiel 2: Parsing mit TryParse()**

Das bekannte int.TryParse() aus der Eingabe arbeitet auch mit out:

```csharp
string eingabe = "123";
if (int.TryParse(eingabe, out int zahl))
{
    Console.WriteLine($"Erfolgreich eingelesen: {zahl}");
}
else
{
    Console.WriteLine("Ungültige Eingabe!");
}
```

Hier gibt die Funktion zwei Werte zurück:

- `true` oder `false` → ob die Umwandlung geklappt hat (normaler Rückgabewert)

- die Zahl selbst → über den `out`-Parameter

---

## Lokale und globale Variablen

```csharp
Lokal: Gültig nur innerhalb der Funktion

Global (bzw. Klassenvariablen): Gültig in der ganzen Klasse
```

**Beispiel:**

```csharp
int globalerZaehler = 0;

void Erhoehe()
{
    int lokal = 1;        // nur in dieser Funktion gültig
    globalerZaehler++;    // global verfügbar
}
```

---

## Beispiel: Kleiner Taschenrechner

```csharp
int Addiere(int a, int b) => a + b;
int Subtrahiere(int a, int b) => a - b;
int Multipliziere(int a, int b) => a * b;
double Dividiere(int a, int b) => (double)a / b;


Console.Write("Zahl 1: ");
int x = int.Parse(Console.ReadLine());
Console.Write("Zahl 2: ");
int y = int.Parse(Console.ReadLine());

Console.WriteLine($"Summe: {Addiere(x,y)}");
Console.WriteLine($"Differenz: {Subtrahiere(x,y)}");
Console.WriteLine($"Produkt: {Multipliziere(x,y)}");
Console.WriteLine($"Quotient: {Dividiere(x,y)}");

```




