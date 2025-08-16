## Variablen und Datentypen

- Variablen sind Speicherplätze für Daten.
- Jede Variable hat einen Datentyp.

| Datentyp | Beschreibung      | Beispielwert |
| -------- | ----------------- | ------------ |
| `int`    | Ganze Zahl        | `42`         |
| `double` | Kommazahl         | `3.14`       |
| `bool`   | Wahr/Falsch       | `true`       |
| `string` | Text              | `"Hallo"`    |
| `char`   | Einzelnes Zeichen | `'A'`        |

**Beispiel:**

```csharp
int alter = 16;
string name = "Max";
bool istSchueler = true;

Console.WriteLine($"Name: {name}, Alter: {alter}, Schüler: {istSchueler}");
```

## Ein- und Ausgabe

```csharp
Console.Write("Wie heißt du? ");
string name = Console.ReadLine();
Console.WriteLine("Hallo " + name);
```

!!! tip "Tipp"
    `Console.ReadLine()` liest immer **Text** (`string`). Falls eine **Zahl** benötigt wird:
    ```csharp
    Console.Write("Wie alt bist du? ");
    int alter = int.Parse(Console.ReadLine());
    ```

## Kontrollstrukturen

### Verzweigung (if-else)

```csharp
int zahl = 10;
if (zahl > 5)
{
    Console.WriteLine("Größer als 5");
}
else
{
    Console.WriteLine("Kleiner oder gleich 5");
}
```

### Mehrfachverzweigung

#### `else if`

Mit `else if` können weitere Verzweigungen hinzugüfgt werden

```csharp
int zahl = 10;
if (zahl > 5)
{
    Console.WriteLine("Größer als 5");
} else if (zahl < 5) 
{
    Console.WriteLine("Kleienr als 5");
}
else
{
    Console.WriteLine("Gleich 5");
}
```

#### `switch`

Da zu viele `else if`s oft schwer leserlich sind, gibt es die Kontrollstruktur `switch`.

```csharp
string wochentag = "Montag";
switch (wochentag)
{
    case "Montag":
        Console.WriteLine("Wochenstart!");
        break;
    case "Freitag":
        Console.WriteLine("Fast Wochenende!");
        break;
    default:
        Console.WriteLine("Irgendein anderer Tag");
        break;
}
```

!!! warning "Achtung"
    Jedes `case` benötigt ein `break`. Ansonsten rennt der Code weiter in das nächste `case`. 
    Das `break`-Schlüsselwort in C# sorgt dafür, dass eine switch-Anweisung sofort beendet wird.

## Wiederholungen (Schleifen)

### `for`-Schleife

Die for-Schleife ist eine Zählschleife in C#, die besonders dann verwendet wird, wenn man im Voraus weiß, wie oft der Code wiederholt werden soll.

```csharp
for (int i = 1; i <= 5; i++)
{
    Console.WriteLine($"Durchlauf {i}");
}
```

**Aufbau einer for-Schleife:**

```
for (Startwert; Bedingung; Veränderung)
{
    // Wiederholter Code
}
```

| Teil            | Bedeutung                                                                                 |
| --------------- | ----------------------------------------------------------------------------------------- |
| **Startwert**   | Wird einmal **zu Beginn** der Schleife ausgeführt, oft eine Zählvariable wie `int i = 0`. |
| **Bedingung**   | Wird **vor jedem Durchlauf** geprüft. Solange sie `true` ist, läuft die Schleife weiter.  |
| **Veränderung** | Wird **nach jedem Durchlauf** ausgeführt, z. B. `i++` um den Zähler zu erhöhen.           |

**Beispiel:**

_Ablauf Schritt für Schritt:_

1. Startwert: i = 1
2. Bedingung prüfen: i <= 5 → ja → Codeblock ausführen
3. Veränderung: i++ (erhöht i um 1)
4. Zurück zu Schritt 2
5. Stop, wenn Bedingung false ist (hier bei i = 6)

```bash
Durchlauf 1
Durchlauf 2
Durchlauf 3
Durchlauf 4
Durchlauf 5
```

**Typische Variationen:**

Abwärts zählen:
```csharp
for (int i = 10; i >= 1; i--)
{
    Console.WriteLine(i);
}
```

Schrittweite ändern:
```csharp
for (int i = 0; i <= 10; i += 2)
{
    Console.WriteLine(i);
}
```