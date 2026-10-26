---
theme: seriph
routerMode: hash
title: C#-Techniken
info: |
  ## C#-Techniken
  Werkzeuge für den Datenzugriff · am Beispiel OnlineShop
background: https://raw.githubusercontent.com/HTL-Wolfsberg-Betriebsinformatik/skript/refs/heads/main/slides/content/slides/background-cover-16-9.webp
class: text-center
drawings:
    persist: false
transition: slide-left
mdc: true
layout: cover
hideInToc: true
download: true
export:
    format: pdf
    dark: false
    withClicks: true
    withToc: true
selectable: true
---

# C#-Techniken

## *Werkzeuge für den Datenzugriff*

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---
hideInToc: true
---

# Worum geht's?

In den nächsten Foliensätzen (Datenbanken, LINQ, EF Core) kommen diese Schreibweisen ständig vor:

<div class="text-sm">

| Schreibweise | Name | Kurz gesagt |
|---|---|---|
| `string? email` | Nullable-Typ | Die Variable darf `null` sein |
| `Console.ReadLine()!` | `!`-Operator | „Ich weiß, das ist nicht `null`“ |
| `email is null` | `is`-Operator | Prüft auf `null` oder auf einen Typ |
| `x > 0 ? "ja" : "nein"` | Ternärer Operator | `if`/`else` in einer Zeile |
| `email ?? "keine"` | `??`-Operator | Ersatzwert, wenn etwas `null` ist |
| `var liste = …` | `var` | Der Compiler erkennt den Typ selbst |
| `new Artikel { Preis = 12.90m }` | Objekt-Initialisierer | Eigenschaften direkt beim Erzeugen setzen |
| `"""` … `"""` | Raw-String-Literal | Mehrzeiliger Text, z. B. für SQL |

</div>

<!--
Diese Folie ist die Landkarte. Jede Zeile bekommt einen eigenen Abschnitt.
-->

---
hideInToc: true
---

# Unsere Beispielklassen

Alle Beispiele verwenden den OnlineShop:

<div class="grid grid-cols-2 gap-6" style="--slidev-code-font-size: 0.7rem;">
<div>

```csharp
public class Kunde
{
    public int Id { get; set; }
    public string Vorname { get; set; } = "";
    public string Nachname { get; set; } = "";
    public string? Email { get; set; }
    public string Ort { get; set; } = "";
}
```

</div>
<div>

```csharp
public class Artikel
{
    public int Id { get; set; }
    public string Bezeichnung { get; set; } = "";
    public decimal Preis { get; set; }
    public int Lagerstand { get; set; }
}
```

</div>
</div>

<v-click>

Neu sind hier `string?` bei `Email` und `= ""` als Startwert. Beides klären wir gleich.

</v-click>

<!--
- Die Klassen entsprechen den Tabellen Kunde und Artikel in der Datenbank OnlineShop.
- `= ""` gibt der Eigenschaft einen Startwert, damit sie nie `null` ist.
-->

---
layout: section
---

# null und string?

## Wenn eine Variable „nichts“ enthält

---
hideInToc: true
---

# Was ist null?

<div style="--slidev-code-font-size: 0.8rem;">

```csharp {1|2|3}
Kunde kunde = null;
Console.WriteLine(kunde.Vorname);
// 💥 NullReferenceException
```

</div>

<v-clicks>

- Eine Variable eines Klassentyps zeigt auf ein Objekt, oder auf **nichts**. Dieses „nichts“ heißt `null`.
- Greift man auf ein Mitglied von `null` zu, stürzt das Programm mit einer `NullReferenceException` ab.
- Das ist einer der häufigsten Fehler in C#. Darum hilft der Compiler beim Aufpassen.

</v-clicks>

<!--
Die NullReferenceException kennen die Schüler aus dem Foliensatz Exception Handling.
-->

---
hideInToc: true
---

# string? – darf null sein

<div style="--slidev-code-font-size: 0.8rem;">

```csharp {1|2|3|5|all}
string vorname = "Anna";     // muss immer einen Text haben
string? email = null;        // darf null sein ✅
email = "anna.berger@example.at";

string ort = null;           // ⚠️ Warnung: null für einen Typ ohne ?
```

</div>

<v-clicks>

- Das `?` nach dem Typ heißt: Diese Variable **darf** `null` sein.
- Ohne `?` erwartet der Compiler immer einen Wert und warnt bei `null`.
- Das gibt es auch für Zahlen: `int?`, `decimal?`, `DateTime?`

</v-clicks>

<SqlBruecke>

`Email NVARCHAR(100) NULL` in der Tabelle wird in C# zu `string? Email`. `NOT NULL`-Spalten werden zu `string` ohne `?`.

</SqlBruecke>

<!--
- Die Warnung lautet CS8600: „Converting null literal or possible null value to non-nullable type“.
- Wichtig: Das ist eine Warnung, kein Fehler. Das Programm kompiliert trotzdem. Warnungen also ernst nehmen.
-->

---
hideInToc: true
---

# Der !-Operator

Manchmal weiß man mehr als der Compiler:

<div style="--slidev-code-font-size: 0.8rem;">

```csharp {1|2|4}
string? eingabe = Console.ReadLine();   // ReadLine kann null liefern
string name = Console.ReadLine()!;      // ! = "ist sicher nicht null"

public Kunde Kunde { get; set; } = null!;   // "wird später befüllt"
```

</div>

<v-clicks>

- Das `!` nach einem Ausdruck sagt dem Compiler: **„Das ist nicht `null`, vertrau mir.“**
- Damit verschwindet die Warnung.
- `= null!` bei Eigenschaften heißt: Der Wert wird später gesetzt.

</v-clicks>

<Achtung>

`!` ändert nur die Warnung, nicht das Programm. Ist der Wert doch `null`, kommt die `NullReferenceException` trotzdem, nur später.

</Achtung>

<!--
- `Console.ReadLine()` liefert nur dann `null`, wenn die Eingabe endet (z. B. Strg+Z). In normalen Konsolenprogrammen ist `!` dort also in Ordnung.
- Im Datenbank-Foliensatz kommt `(int)cmd.ExecuteScalar()!` vor: `ExecuteScalar` liefert `object?`, bei `COUNT(*)` aber garantiert einen Wert.
-->

---
layout: section
---

# Prüfen mit is

## Ist das null? Ist das ein bestimmter Typ?

---
hideInToc: true
---

# is null und is not null

<div style="--slidev-code-font-size: 0.8rem;">

```csharp {1-2|4-5|all}
if (kunde.Email is null)
    Console.WriteLine("Keine E-Mail hinterlegt.");

if (kunde.Email is not null)
    Console.WriteLine($"E-Mail: {kunde.Email}");
```

</div>

<v-clicks>

- `is null` prüft, ob die Variable `null` ist. Das Ergebnis ist `true` oder `false`.
- `is not null` ist das Gegenteil.
- Gleichwertig zu `== null` bzw. `!= null`, aber besser lesbar.

</v-clicks>

<!--
`is null` funktioniert auch dann korrekt, wenn jemand den `==`-Operator einer Klasse umdefiniert hat. Das muss man nicht erklären, ist aber der Grund, warum es empfohlen wird.
-->

---
hideInToc: true
---

# is mit einem Typ

`is` kann auch prüfen, **welcher Typ** in einer Variable steckt:

<div style="--slidev-code-font-size: 0.8rem;">

```csharp {1|3|4|all}
object wert = 42;

if (wert is int)    Console.WriteLine("Das ist eine Zahl.");     // ✅
if (wert is string) Console.WriteLine("Das ist ein Text.");      // wird nicht ausgegeben
```

</div>

<v-click>

<Merke>

Im Datenbank-Foliensatz prüft man so, ob die Datenbank `NULL` geliefert hat:<br>
`if (ergebnis is DBNull) …`<br>
`DBNull` ist ein eigener Typ für „NULL aus der Datenbank“.

</Merke>

</v-click>

<!--
`object` kann jeden Wert aufnehmen. Darum muss man manchmal nachsehen, was tatsächlich drinsteckt.
-->

---
layout: section
---

# Der ternäre Operator ?:

## if/else in einer Zeile

---
hideInToc: true
---

# Von if/else zu ?:

<div style="--slidev-code-font-size: 0.8rem;">

````md magic-move
```csharp
string text;
if (artikel.Lagerstand > 0)
    text = "lagernd";
else
    text = "ausverkauft";
```
```csharp
string text = artikel.Lagerstand > 0 ? "lagernd" : "ausverkauft";
```
````

</div>

<div v-click class="text-center font-mono text-2xl mt-8">
<span class="px-2 rounded bg-blue-100">Bedingung</span> ? <span class="px-2 rounded bg-green-100">Wert, wenn true</span> : <span class="px-2 rounded bg-red-100">Wert, wenn false</span>
</div>

<!--
„Ternär“ heißt „dreiteilig“: Bedingung, Wert für true, Wert für false. Es ist der einzige Operator in C# mit drei Teilen.
-->

---
hideInToc: true
---

# ?: in der Praxis

<div style="--slidev-code-font-size: 0.8rem;">

```csharp {1-2|4-5|all}
decimal summe = 42.80m;
decimal versand = summe >= 50 ? 0m : 4.90m;

int menge = 1;
Console.WriteLine($"{menge} {(menge == 1 ? "Artikel" : "Artikel insgesamt")}");
```

</div>

<v-clicks>

- Beide Werte müssen **denselben Typ** haben (hier zweimal `decimal` bzw. zweimal `string`).
- Im String mit `$"…"` muss der Ausdruck in **runden Klammern** stehen.

</v-clicks>

<Achtung title="⚠️ Lesbarkeit">

Nur für kurze Entscheidungen zwischen zwei Werten. Verschachtelte `?:` versteht niemand mehr, dann lieber `if`/`else`.

</Achtung>

---
layout: section
---

# Der ??-Operator

## Ein Ersatzwert, wenn etwas null ist

---
hideInToc: true
---

# Von if/else zu ??

<div style="--slidev-code-font-size: 0.8rem;">

````md magic-move
```csharp
string anzeige;
if (kunde.Email is not null)
    anzeige = kunde.Email;
else
    anzeige = "(keine E-Mail)";
```
```csharp
string anzeige = kunde.Email is not null ? kunde.Email : "(keine E-Mail)";
```
```csharp
string anzeige = kunde.Email ?? "(keine E-Mail)";
```
````

</div>

<div v-click class="text-center font-mono text-2xl mt-8">
<span class="px-2 rounded bg-blue-100">Wert</span> ?? <span class="px-2 rounded bg-orange-100">Ersatz, wenn Wert null ist</span>
</div>

<!--
- Der Name ist „Null-Sammeloperator“ (englisch null-coalescing operator). In JavaScript heißt das Gegenstück „nullish coalescing“.
- Die Zwischenstufe mit `?:` zeigt: `??` ist nur eine Abkürzung für genau diesen Fall.
-->

---
hideInToc: true
---

# ?? in der Praxis

<div style="--slidev-code-font-size: 0.75rem;">

```csharp {1|3-5|all}
string name = Console.ReadLine() ?? "";     // statt ! : leerer Text als Ersatz

Kunde? gefunden = SucheKunde(5);            // liefert null, wenn es Kunde 5 nicht gibt
Kunde kunde = gefunden
    ?? throw new InvalidOperationException("Kunde nicht gefunden.");
```

</div>

<v-clicks>

- Rechts von `??` darf auch `throw` stehen: Ist der Wert `null`, wird sofort eine Exception geworfen.
- Danach ist `kunde` garantiert nicht `null`, darum ist kein `?` mehr nötig.
</v-clicks>

<Merke>

`??` greift **nur bei `null`**. Ein leerer String `""` oder die Zahl `0` sind nicht `null`.

</Merke>

<!--
`SucheKunde` ist hier eine beliebige Methode mit dem Rückgabetyp `Kunde?`. Bei EF Core sieht das später genau so aus: `await db.Kunden.FindAsync(5) ?? throw …`.
-->

---
layout: section
---

# var

## Der Compiler erkennt den Typ

---
hideInToc: true
---

# var: Typ ableiten lassen

<div style="--slidev-code-font-size: 0.8rem;">

```csharp {1|2|3|5|6|all}
var anzahl = 5;                       // int
var name = "Anna";                    // string
var liste = new List<Artikel>();      // List<Artikel>

anzahl = "fünf";                      // ❌ Fehler: anzahl ist int
var leer;                             // ❌ Fehler: ohne Wert kein Typ
```

</div>

<v-clicks>

- Bei `var` schaut der Compiler auf die **rechte Seite** und setzt den Typ selbst ein.
- Der Typ steht danach **fest**. `var` heißt nicht „beliebiger Typ“.
- Darum braucht `var` immer gleich einen Wert.

</v-clicks>

<!--
Mit der Maus über `var` fahren: Visual Studio zeigt den abgeleiteten Typ an. Das live zeigen.
-->

---
hideInToc: true
---

# Wann var, wann nicht?

<div class="grid grid-cols-2 gap-6" style="--slidev-code-font-size: 0.68rem;">
<div>

**Gut** ✅ – der Typ ist rechts sofort sichtbar

```csharp
var liste = new List<Artikel>();
var stick = new Artikel();
using var con = new SqlConnection(ConnStr);
```

</div>
<div>

**Besser ohne** – der Typ ist nicht erkennbar

```csharp
var ergebnis = cmd.ExecuteScalar();
// besser:
object? ergebnis = cmd.ExecuteScalar();
```

</div>
</div>

<Merke>

`var` spart Schreibarbeit, wenn der Typ ohnehin rechts steht. Wenn man den Typ erst nachschlagen müsste, schreibt man ihn lieber aus.

</Merke>

<!--
Der Fall „nötig“ sind anonyme Typen bei `Select(a => new { … })`. Das kommt im Foliensatz LINQ.
-->

---
layout: section
---

# Objekt-Initialisierer

## Eigenschaften direkt beim Erzeugen setzen

---
hideInToc: true
---

# Von Zuweisungen zum Initialisierer

<div style="--slidev-code-font-size: 0.8rem;">

````md magic-move
```csharp
Artikel stick = new Artikel();
stick.Bezeichnung = "USB-Stick 64 GB";
stick.Preis = 12.90m;
stick.Lagerstand = 50;
```
```csharp
Artikel stick = new Artikel
{
    Bezeichnung = "USB-Stick 64 GB",
    Preis = 12.90m,
    Lagerstand = 50
};
```
````

</div>

<v-clicks>

- Nach `new Artikel` folgen in `{ }` die Eigenschaften mit ihren Werten.
- Zwischen den Eigenschaften steht ein **Komma**, nach der `}` ein **Semikolon**.
- Nicht gesetzte Eigenschaften behalten ihren Startwert, hier `Id = 0`.
- Funktioniert mit dem Standard-Konstruktor und Eigenschaften mit `set`.

</v-clicks>

<!--
Beide Varianten erzeugen genau dasselbe Objekt. Der Initialisierer ist nur kürzer und zeigt auf einen Blick, was zusammengehört.
-->

---
hideInToc: true
---

# Initialisierer in der Praxis

Objekte erzeugen und gleich in eine Liste geben:

<div style="--slidev-code-font-size: 0.64rem;">

```csharp
List<Artikel> artikel = new List<Artikel>();
artikel.Add(new Artikel { Id = 1, Bezeichnung = "USB-Stick 64 GB", Preis = 12.90m, Lagerstand = 50 });
artikel.Add(new Artikel { Id = 2, Bezeichnung = "Funkmaus",        Preis = 24.90m, Lagerstand = 30 });
```

</div>

<div class="grid grid-cols-2 gap-4 mt-4 text-sm">
<div v-click class="p-3 rounded border-t-4 border-blue-500">

**Konstruktor mit Parametern** (falls die Klasse einen hat)<br>
`new Artikel("Funkmaus", 24.90m, 30)`<br>
Pflichtwerte werden erzwungen, aber man muss die Reihenfolge kennen.

</div>
<div v-click class="p-3 rounded border-t-4 border-green-600">

**Objekt-Initialisierer**<br>
`new Artikel { Bezeichnung = "Funkmaus", … }`<br>
Jeder Wert steht mit Namen da. Man setzt nur, was man braucht.

</div>
</div>

---
layout: section
---

# Raw-String-Literale

## Mehrzeiliger Text ohne Verrenkungen

---
hideInToc: true
---

# Von + zu """

Mehrzeiliges SQL als normaler String:

<div style="--slidev-code-font-size: 0.75rem;">

````md magic-move
```csharp
string sql = "SELECT Id, Bezeichnung, Preis " +
             "FROM Artikel " +
             "WHERE Lagerstand > 0 " +
             "ORDER BY Preis";
```
```csharp
string sql = """
    SELECT Id, Bezeichnung, Preis
    FROM Artikel
    WHERE Lagerstand > 0
    ORDER BY Preis
    """;
```
````

</div>

<v-clicks>

- Ein **Raw-String-Literal** beginnt und endet mit **drei Anführungszeichen** `"""`.
- Der Text darf über **mehrere Zeilen** gehen: kein `+`, kein vergessenes Leerzeichen am Zeilenende.
- Anführungszeichen im Text brauchen **kein** `\` davor: `"""Er sagte "Hallo"."""`

</v-clicks>

<!--
Den Fehler im ersten Stand zeigen: Fehlt das Leerzeichen am Ende einer Zeile, klebt z. B. `Artikel` mit `WHERE` zu `ArtikelWHERE` zusammen. Beim Raw-String kann das nicht passieren.
-->

---
hideInToc: true
---

# Die Regeln für """

<div class="grid grid-cols-2 gap-6" style="--slidev-code-font-size: 0.72rem;">
<div>

```csharp {all|5-6}
string sql = """
    SELECT COUNT(*)
    FROM Artikel
    WHERE Lagerstand = 0
    """;
//  ↑ diese Einrückung wird entfernt
```

</div>
<div>

<v-clicks>

- Nach dem öffnenden `"""` beginnt eine **neue Zeile**.
- Das schließende `"""` steht in einer **eigenen Zeile**.
- So weit wie das schließende `"""` eingerückt ist, wird **jede Zeile** eingerückt erwartet. Diese Einrückung entfernt C#.

</v-clicks>

</div>
</div>

<Merke>

Raw-Strings verwendet ihr im Datenbank-Foliensatz für SQL, das über mehrere Zeilen geht. Sie gibt es ab C# 11 (.NET 7).

</Merke>

<!--
Steht eine Textzeile weniger weit eingerückt als das schließende `"""`, meldet der Compiler einen Fehler. Das ist der häufigste Stolperstein.
-->

---
layout: section
---

# Zusammenfassung

---
hideInToc: true
---

# Alles auf einen Blick

<div class="text-sm">

| Schreibweise | Bedeutung | Beispiel |
|---|---|---|
| `string?` | darf `null` sein | `string? email = null;` |
| `!` | „ist sicher nicht `null`“ | `string name = Console.ReadLine()!;` |
| `is null` / `is not null` | Prüfung auf `null` | `if (email is null) …` |
| `is Typ` | Prüfung auf einen Typ | `if (ergebnis is DBNull) …` |
| `?:` | if/else in einer Zeile | `lager > 0 ? "lagernd" : "ausverkauft"` |
| `??` | Ersatzwert bei `null` | `email ?? "(keine E-Mail)"` |
| `var` | Typ wird abgeleitet | `var liste = new List<Artikel>();` |
| `{ … }` nach `new` | Objekt-Initialisierer | `new Artikel { Preis = 12.90m }` |
| `"""` … `"""` | Raw-String-Literal | mehrzeiliges SQL ohne `+` |

</div>

---
hideInToc: true
---

<PraxisSlide block="1" title="Was gibt das Programm aus?" time="10 min">

Sagt die Ausgabe zuerst **vorher**, dann probiert es aus.

<div style="--slidev-code-font-size: 0.66rem;">

```csharp
List<Kunde> kunden = new List<Kunde>();
kunden.Add(new Kunde { Vorname = "Anna", Email = "anna.berger@example.at" });
kunden.Add(new Kunde { Vorname = "Lukas", Email = null });

foreach (var k in kunden)
{
    string kontakt = k.Email ?? "keine E-Mail";
    string status = k.Email is null ? "❌" : "✅";
    Console.WriteLine($"{k.Vorname}: {kontakt} {status}");
}
```

</div>

Zusatzfragen: Welchen Typ hat `k`? Warum braucht `kontakt` kein `?`?

</PraxisSlide>

---
hideInToc: true
---

# Lösung

```text
Anna: anna.berger@example.at ✅
Lukas: keine E-Mail ❌
```

<v-clicks>

- `k` hat den Typ `Kunde`, weil `kunden` eine `List<Kunde>` ist.
- `kontakt` braucht kein `?`: Durch `?? "keine E-Mail"` ist der Wert nie `null`.
- `Ort`, `Nachname` und `Id` wurden nicht gesetzt. Sie behalten ihre Startwerte `""` bzw. `0`.

</v-clicks>
