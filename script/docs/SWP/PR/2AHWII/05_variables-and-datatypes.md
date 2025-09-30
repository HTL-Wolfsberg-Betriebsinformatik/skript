# Variablen und Datentypen in C#

## Was ist eine Variable?

Eine **Variable** ist wie ein **benannter Speicherplatz** im Arbeitsspeicher, in dem ein Wert abgelegt wird.

- **Name**: Wie wir die Variable im Programm ansprechen
- **Typ**: Welche Art von Daten sie speichern kann (z. B. Zahl, Text, Wahr/Falsch)
- **Wert**: Der aktuell gespeicherte Inhalt

!!! info "Merke"  
    Eine Variable ist wie eine beschriftete Schachtel – der Datentyp bestimmt, was hineindarf.

---

## Deklaration und Initialisierung

- **Deklaration**: Anlegen einer Variable mit Typ und Namen  
- **Initialisierung**: Erstmaliges Zuweisen eines Werts

**Beispiel:**
```csharp
int alter;           // Deklaration
alter = 16;          // Initialisierung
string name = "Max"; // Deklaration + Initialisierung
```

## Grundlegende Datentypen in C#

| Datentyp  | Beschreibung                      | Beispielwert    |
| --------- | --------------------------------- | --------------- |
| `int`     | Ganze Zahl                        | `42`            |
| `double`  | Gleitkommazahl (mit Nachkommast.) | `3.14`          |
| `bool`    | Wahr/Falsch                       | `true`, `false` |
| `string`  | Text                              | `"Hallo"`       |
| `char`    | Einzelnes Zeichen                 | `'A'`           |
| `decimal` | Exakte Dezimalzahl (z. B. Geld)   | `19.99`        |


## Variablennamen - Regeln & Konventionen

✅ Erlaubt:

- Buchstaben, Ziffern, `_` (Unterstrich)
- Muss mit Buchstaben oder `_` beginnen

❌ Nicht erlaubt:

- Sonderzeichen (außer `_`)
- Leerzeichen
- Schlüsselwörter wie `int`, `class`, `for`

**Namenskonventionen in C#:**

**camelCase** für lokale Variablen: `highestScore`, `birthday`, `currentYear`

## Werte zuweisen und ändern

```csharp
int points = 10; // deklariert und initialisiert (10)
points = 20; // neuer Wert (20)
points = points + 5; // alter Wert verändert (25)
```

## Konstanten

Eine **Konstante** ist wie eine Variable, deren Wert sich **nicht ändern darf**.

```csharp
const double Pi = 3.14159;
```
> Namenskonvention für Konstanten sind in PascalCase: e.g. `HighestScore`, `CurrentYear`, usw.

## Typumwandlung (Casting)

### Implizite Typumwandlung (automatisch)

```csharp
int a = 5;
double b = a; // int -> double
```
> Kein Datenverlust

### Explizite Typumwandlung

```csharp
double x = 5.9;
int y = (int)x; // Ergebnis: 5
```
> Möglicher Datenverlust

## Beispielprogramm

```csharp

string name = "Anna";
int age = 17;
double average = 1.7;
bool isAdult = age >= 18;

Console.WriteLine($"Name: {name}");
Console.WriteLine($"Alter: {age}");
Console.WriteLine($"Durchschnittsnote: {average}");
Console.WriteLine($"Volljährig: {isAdult}");

```