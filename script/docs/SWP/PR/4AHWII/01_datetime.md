# C# DateTime

## Was ist `DateTime`

`DateTime` ist ein Strukturtyp (`struct`) in C#, der Datum und Uhrzeit speichert.
Er bietet viele Eigenschaften (z. B. `Year`, `Month`) und Methoden (z. B. `AddDays`, `Subtract`).

**Beispiele:**

```csharp
DateTime jetzt = DateTime.Now; // lokale Zeit (Datum + Uhrzeit)
DateTime heute = DateTime.Today; // heutiges Datum, 00:00:00
DateTime utc = DateTime.UtcNow; // Weltzeit (UTC)
```

!!! note "Merke"
    - Now = lokale Zeit (abhängig von Systemzeitzone)
    - UtcNow = Weltzeit (UTC)
    - Today = nur Datum (Zeit ist 00:00)

## Erstellen von `DateTime`

```csharp
// Vollständiger Konstruktor: Jahr, Monat, Tag, Stunde, Minute, Sekunde (Millis optional)
DateTime meeting = new DateTime(2025, 10, 3, 14, 30, 0);

// Nur Datum
DateTime geburtstag = new DateTime(2008, 5, 12);

// Aus Ticks (fortgeschritten)
long ticks = DateTime.Now.Ticks;
DateTime ausTicks = new DateTime(ticks);

// Mit DateTimeKind (Local/UTC/Unspecified)
DateTime utcZeit = new DateTime(2025, 10, 3, 12, 0, 0, DateTimeKind.Utc);

// Statische Grenzen
DateTime min = DateTime.MinValue; // 01.01.0001 00:00:00
DateTime max = DateTime.MaxValue; // 31.12.9999 23:59:59
```

## Eigenschaften 

```csharp
var t = DateTime.Now;

int year = t.Year; // e.g. 2025
int month = t.Month; // e.g. 10
int day = t.Day; // e.g. 3
int hour = t.Hour; // e.g. 14
int minute = t.Minute;
int second = t.Second;
DayOfWeek wtag = t.DayOfWeek; // e.g. Friday
int dayOfYear = t.DayOfYear; // e.g. 276
```

## Rechnen & `TimeSpan`

### Add/Subtract

```csharp
DateTime jetzt = DateTime.Now;

DateTime inSiebenTagen = jetzt.AddDays(7);
DateTime vorEinemMonat = jetzt.AddMonths(-1);
DateTime naechstesJahr = jetzt.AddYears(1);

DateTime weihnachten = new DateTime(jetzt.Year, 12, 24);
TimeSpan bisWeihnachten = weihnachten - jetzt; // Subtract-Operator
Console.WriteLine(bisWeihnachten.TotalDays);
```

## `TimeSpan` Basics

```csharp
TimeSpan dauer = new TimeSpan(hours: 1, minutes: 30, seconds: 0);
DateTime beginn = DateTime.Today.AddHours(8);
DateTime ende = beginn + dauer;

Console.WriteLine(ende); // 09:30 des heutigen Datums
```

# Vergleiche & Sortierung

```csharp
DateTime a = new DateTime(2025, 10, 3, 10, 0, 0);
DateTime b = new DateTime(2025, 10, 3, 12, 0, 0);

bool frueher = a < b; // true
int cmp = DateTime.Compare(a, b); // -1, 0, 1
bool gleich = a == b; // Wertvergleich (Ticks)
```

!!! warning "Achtung"
    Nicht lokale mit UTC Zeit mischen – immer vorher vereinheitlichen.

## Formatierung

### Standard Formate

```csharp
DateTime t = new DateTime(2025, 10, 3, 14, 30, 0);
Console.WriteLine(t.ToString("d")); // Kurzdatum (kulturabhängig)
Console.WriteLine(t.ToString("T")); // Lange Uhrzeit
Console.WriteLine(t.ToString("f")); // Vollständig (kurz)
Console.WriteLine(t.ToString("o")); // ISO 8601 Round-trip (empfohlen)
```

### Benutzerdefinierte Formate

| Format | Bedeutung         | Beispiel  |
| -----: | ----------------- | --------- |
|   `dd` | Tag zweistellig   | `03`      |
|   `MM` | Monat zweistellig | `10`      |
| `yyyy` | Jahr vierstellig  | `2025`    |
|   `HH` | Stunde (24h)      | `14`      |
|   `mm` | Minute            | `30`      |
|   `ss` | Sekunde           | `05`      |
| `dddd` | Wochentag lang    | `Freitag` |


```csharp
DateTime t = new DateTime(2025, 10, 3, 14, 30, 5);
string de = t.ToString("dd.MM.yyyy HH:mm"); // 03.10.2025 14:30
string iso = t.ToString("yyyy-MM-ddTHH:mm:ss"); // 2025-10-03T14:30:05
```
