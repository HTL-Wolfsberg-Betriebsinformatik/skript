## Einführung

Kontrollstrukturen bestimmen, **in welcher Reihenfolge** Anweisungen ausgeführt werden.  
Es gibt drei grundlegende Kategorien:

1. **Sequenz** – Anweisungen werden der Reihe nach ausgeführt  
2. **Selektion (Verzweigung)** – Entscheidungen treffen   

!!! note "Merksatz"  
    Kontrollstrukturen steuern den „Programmfluss“.

## Sequenz

Die einfachste Form: Befehle werden von oben nach unten abgearbeitet.

```csharp
Console.WriteLine("Programmstart");
Console.WriteLine("Zwischenschritt");
Console.WriteLine("Programmende");
```

## Verzweigung

### if - einfache Bedingung

```csharp
int alter = 17;

if (alter >= 18)
{
    Console.WriteLine("Volljährig");
}

```

!!! danger "Vereinfachte Schreibweise"
    Eine einfache Bedingung die nur 1 Zeile behinhaltet, kann auch ohne geschwungene Klammern {} geschrieben werden
    
    ```csharp
    int alter = 17;

    if (alter >= 18)
        Console.WriteLine("Volljährig");
    ```
    Es wird aber abgeraten diese Schreibweise durchzuführen, da sie fehlernfälliger ist (e.g. jemand will eine 2.Zeile hinzufügen und vergisst die Klammersetzung, dadurch wird die 2.Zeile immer ausgeführt.)
    

### if-else - Alternative

```csharp
if (alter >= 18)
{
    Console.WriteLine("Volljährig");
}
else
{
    Console.WriteLine("Minderjährig");
}
```

### Mehrere Fälle

#### if-else if-else

```csharp
int note = 2;

if (note == 1)
    Console.WriteLine("Sehr gut");
else if (note == 2)
    Console.WriteLine("Gut");
else if (note == 3)
    Console.WriteLine("Befriedigend");
else
    Console.WriteLine("Nicht genügend");
```

#### switch

```csharp
string wochentag = "Montag";

switch (wochentag)
{
    case "Montag":
        Console.WriteLine("Wochenstart");
        break;
    case "Freitag":
        Console.WriteLine("Fast Wochenende!");
        break;
    default:
        Console.WriteLine("Ein anderer Tag");
        break;
}
```

!!! warning "Achtung"
    Jedes `case` benötigt ein `break`. Ansonsten rennt der Code weiter in das nächste `case`. 
    Das `break`-Schlüsselwort in C# sorgt dafür, dass eine switch-Anweisung sofort beendet wird.




