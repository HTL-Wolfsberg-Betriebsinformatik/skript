# Strings (Zeichenketten) in C#

## Einführung

Ein **String** ist eine **Zeichenkette**, also eine Folge von Zeichen (Buchstaben, Ziffern, Symbole).  
In C# wird ein String mit **doppelten Anführungszeichen** geschrieben.

```csharp
string name = "Anna";
string text = "Hallo Welt!";
```

!!! note "Merksatz"
    Ein String ist wie eine Liste von char-Werten, aber mit vielen praktischen Funktionen.

---

## Zeichen in Strings

- Jeder String besteht intern aus einzelnen Zeichen (char).
- Zugriff über Index (beginnend bei 0):

```csharp
string wort = "HTL";
Console.WriteLine(wort[0]); // H
Console.WriteLine(wort[1]); // T
Console.WriteLine(wort[2]); // L
```

---

## Wichtige Eigenschaften und Methoden

Strings haben viele eingebaute Eigenschaften und Methoden.

| Methode/Eigenschaft        | Bedeutung                              | Beispiel                                       |
| -------------------------- | -------------------------------------- | ---------------------------------------------- |
| `Length`                   | Länge des Strings                      | `"Hallo".Length` → 5                           |
| `ToUpper()`                | Alles in Großbuchstaben                | `"Hallo".ToUpper()` → `"HALLO"`                |
| `ToLower()`                | Alles in Kleinbuchstaben               | `"Hallo".ToLower()` → `"hallo"`                |
| `Substring(start, laenge)` | Teilstring ausschneiden                | `"Programmieren".Substring(0, 6)` → `"Progra"` |
| `Contains("Text")`         | Prüfen, ob enthalten                   | `"Hallo".Contains("Ha")` → true                |
| `IndexOf("a")`             | Position suchen (Index)                | `"Hallo".IndexOf("a")` → 1                     |
| `Replace("alt","neu")`     | Teilstring ersetzen                    | `"Auto".Replace("A","B")` → `"Buto"`           |
| `Trim()`                   | Leerzeichen vorne und hinten entfernen | `" Hallo ".Trim()` → `"Hallo"`                 |

---

## Verketten von Strings

Strings können mit `+` zusammengefügt werden.

```csharp
string vorname = "Anna";
string nachname = "Muster";
string name = vorname + " " + nachname;

Console.WriteLine(name); // Anna Muster
```

Besser ist die **String-Interpolation** mit **$**:

```csharp
string vorname = "Anna";
string nachname = "Muster";
Console.WriteLine($"Name: {vorname} {nachname}");
```

---

## Escape-Sequenzen

Manchmal braucht man **Sonderzeichen** in Strings:

| Sequenz | Bedeutung                   | Beispiel                               |
| ------- | --------------------------- | -------------------------------------- |
| `\n`    | Zeilenumbruch               | `"Hallo\nWelt"` → `Hallo` + neue Zeile |
| `\t`    | Tabulator                   | `"A\tB"` → `A    B`                    |
| `\"`    | doppeltes Anführungszeichen | `"Er sagte: \"Hallo\""`                |
| `\\`    | Backslash                   | `"C:\\Ordner\\Datei.txt"`              |

---

## Strings vergleichen

Wichtig: In C# vergleicht man Strings mit `==` oder Methoden.

```csharp
string a = "Test";
string b = "test";

Console.WriteLine(a == b); // false (Groß-/Kleinschreibung zählt!)
Console.WriteLine(a.Equals(b, StringComparison.OrdinalIgnoreCase)); // true
```

---

## Strings als Zeichenketten

Da ein String intern eine Folge von `char` ist, kann man ihn mit `foreach` durchlaufen:

```csharp
string text = "HTL";
foreach (char c in text)
{
    Console.WriteLine(c);
}
```

---

## Beispielprogramm: Passwortprüfung

```csharp
Console.Write("Passwort eingeben: ");
string pw = Console.ReadLine();

if (pw.Length >= 6 && pw.Contains("!"))
{
    Console.WriteLine("Passwort ist stark genug.");
}
else
{
    Console.WriteLine("Passwort zu schwach!");
}
```

## `Stringbuilder`

Wenn man Strings oft verändern muss (z. B. in Schleifen), ist StringBuilder effizienter.

```csharp
using System.Text;

StringBuilder sb = new StringBuilder("Hallo");
sb.Append(" Welt");
sb.Append("!");
Console.WriteLine(sb.ToString()); // Hallo Welt!
```
