## Einführung

Eine **Schleife** ist eine Kontrollstruktur, die Anweisungen **wiederholt**.  
Man unterscheidet:

1. **Zählschleifen** → feste Anzahl an Durchläufen  
2. **Kopfgesteuerte Schleifen** → Wiederholung, solange eine Bedingung gilt  
3. **Fußgesteuerte Schleifen** → wird mindestens einmal ausgeführt  
4. **Sammlungs-Schleifen** → durchläuft Arrays oder Listen  

!!! note "Merksatz"
    Schleifen sparen Wiederholungsarbeit – statt denselben Code 10-mal zu schreiben, lässt man die Schleife laufen.

---

## for-Schleife

- Die **Zählschleife**: gut, wenn man die Anzahl der Durchläufe kennt.

**Allgemeiner Aufbau:**
```csharp
for (Startwert; Bedingung; Veränderung)
{
    // Schleifenrumpf
}
```

**Beispiel:**

```csharp
for (int i = 1; i <= 5; i++)
{
    Console.WriteLine($"Durchlauf {i}");
}
```

- **Startwert:** int i = 1
- **Bedingung:** i <= 5 → solange wahr
- **Veränderung:** i++ → nach jedem Durchlauf

!!! note "Notiz"
    `i++` ist die Kurzform von `i = i + 1`

## while-Schleife

- **Kopfgesteuert:** Bedingung wird vor jedem Durchlauf geprüft.

```csharp
int zahl = 0;
while (zahl < 3)
{
    Console.WriteLine("Zahl: " + zahl);
    zahl++;
}
```
> Wird nur ausgeführt, wenn die Bedingung am Anfang wahr ist.

## do-while-Schleife

- **Fußgesteuert:** Bedingung wird nach jedem Durchlauf geprüft.
- Läuft mindestens einmal, auch wenn die Bedingung von Anfang an falsch ist.

```csharp
int eingabe;
do
{
    Console.Write("Bitte eine Zahl > 0 eingeben: ");
    eingabe = int.Parse(Console.ReadLine());
}
while (eingabe <= 0);
```

## foreach-Schleife

- **Sammlungs-Schleife:** Speziell zum Durchlaufen von Arrays und Listen.
- Kein Zähler nötig, sehr übersichtlich.

```csharp
string[] namen = { "Anna", "Max", "Lukas" };

foreach (string n in namen)
{
    Console.WriteLine(n);
}
```

!!! warning "Achtung"
    Arrays bzw Listen werden in diesem [Kapitel](./10_arrays.md) genauer erläutert.


## Steuerbefehle in Schleifen

- `break;` → beendet die Schleife sofort
- `continue;` → springt zum nächsten Durchlauf
- `return;` → beendet die Methode, in der die Schleife steht

**Beispiel mit `continue`:

```csharp
for (int i = 1; i <= 10; i++)
{
    if (i % 2 == 0)
    {
        continue; // überspringt gerade Zahlen
    }
    Console.WriteLine(i);
}
```

## Schleifenarten im Überblick

| Schleife     | Wann einsetzen?                                         |
| ------------ | ------------------------------------------------------- |
| **for**      | Feste Anzahl an Wiederholungen (Zählschleife)           |
| **while**    | Unbekannte Anzahl, Bedingung am Anfang geprüft          |
| **do-while** | Unbekannte Anzahl, Bedingung am Ende geprüft (mind. 1x) |
| **foreach**  | Durchlaufen von Arrays oder Listen                      |


## Verschachtelte Schleifen

```csharp
for (int i = 1; i <= 10; i++)
{
    for (int j = 1; j <= 10; j++)
    {
        Console.Write($"{i * j,4}");
    }
    Console.WriteLine();
}
```
