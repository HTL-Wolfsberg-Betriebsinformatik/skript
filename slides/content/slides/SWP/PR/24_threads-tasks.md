---
theme: seriph
routerMode: hash
title: Threads, Tasks und async/await
info: |
  ## Threads, Tasks und async/await
  Warum Warten nicht blockieren muss · am Beispiel OnlineShop
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

# Threads, Tasks und async/await

## *Warum Warten nicht blockieren muss*

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Prozess, Thread, Main-Thread

<div class="grid grid-cols-2 gap-8 mt-4">
<div>

- **Prozess:** laufendes Programm mit eigenem Speicher
- **Thread:** Ausführungsstrang im Prozess. Threads teilen sich den Speicher, jeder hat einen eigenen Stack.
- **Analogie:** Küche = Prozess, Köche = Threads, ein gemeinsamer Kühlschrank

</div>
<div>

- Der **Main-Thread** führt `Main` aus.
- In WinForms ist er der **UI-Thread**: `Application.Run` verarbeitet in einer Schleife Klicks, Tasten und das Neuzeichnen.

</div>
</div>

<Merke>

Nur der UI-Thread darf Steuerelemente ändern.

</Merke>

<!--
Im Task-Manager unter „Details“ die Spalte „Threads“ zeigen.
-->

---
hideInToc: true
---

# Wenn der UI-Thread wartet

<div class="mt-8" style="--slidev-code-font-size: 0.85rem; --slidev-code-line-height: 1.6;">

```csharp
private void btnLaden_Click(object sender, EventArgs e)
{
    Thread.Sleep(5000);          // steht für eine langsame Aufgabe
    lblStatus.Text = "Fertig";
}
```

</div>

<!--
Live in WinForms vorführen und während des Wartens versuchen, das Fenster zu verschieben.
-->

---
hideInToc: true
title: Was während der 5 Sekunden passiert
layout: none
clicks: 3
---

<ThreadZeitachse :schritt="$clicks" />

<!--
- Das ist genau der Code von der Folie davor, nur als Zeitachse.
- Klick 1: Der Klick startet den Handler, der UI-Thread hängt in `Thread.Sleep`. Windows meldet „Keine Rückmeldung“.
- Klick 2: Das Fenster verschieben oder klicken geht nicht verloren, es landet in der Warteschlange.
- Klick 3: Nach 5 Sekunden läuft der Handler zu Ende, erst dann kommt die Warteschlange dran.
- Überleitung: Der UI-Thread ist der einzige Thread, den wir bisher haben. Wie bekommt man einen zweiten?
-->

---

# Threads in C#

<div style="--slidev-code-font-size: 0.68rem; --slidev-code-line-height: 1.3;">

```csharp {1-8|9|11-15|16|all}
var t = new Thread(() =>
{
    for (int i = 0; i < 3; i++)
    {
        Console.WriteLine($"  Nebenthread: {i}");
        Thread.Sleep(100);
    }
});
t.Start();                       // läuft ab jetzt nebenher

for (int i = 0; i < 3; i++)
{
    Console.WriteLine($"Main: {i}");
    Thread.Sleep(100);
}
t.Join();                        // auf den Nebenthread warten
```

</div>

<p class="text-sm !mt-3 !mb-0">Die Reihenfolge ist nicht vorhersagbar, das Betriebssystem teilt die Rechenzeit zu. Mit einem Kern wechseln die Threads in Zeitscheiben, mit mehreren laufen sie echt parallel.</p>

<!--
- Dreimal ausführen.
- `() =>` hier nur kurz ansprechen: „Das ist der Code, den der Thread ausführen soll.“ Erklärt wird die Schreibweise bei den Delegates.
- Rückbezug aufs Fenster: Auf einem Nebenthread könnte man warten, ohne dass das Fenster hängt. Aber der Nebenthread darf `lblStatus` nicht ändern (siehe Merke auf „Prozess, Thread, Main-Thread“). Mit Debugger kommt dann eine `InvalidOperationException`. Die saubere Lösung ist `await`, das kommt später.
-->

---

# Race Condition

<div style="--slidev-code-font-size: 0.72rem; --slidev-code-line-height: 1.35;">

````md magic-move
```csharp
int lagerstand = 0;

void Einlagern()
{
    for (int i = 0; i < 1_000_000; i++)
        lagerstand++;
}

var t1 = new Thread(Einlagern);
var t2 = new Thread(Einlagern);
t1.Start(); t2.Start();
t1.Join();  t2.Join();
Console.WriteLine(lagerstand);   // meist < 2000000
```
```csharp
int lagerstand = 0;
object sperre = new();

void Einlagern()
{
    for (int i = 0; i < 1_000_000; i++)
        lock (sperre) { lagerstand++; }
}

var t1 = new Thread(Einlagern);
var t2 = new Thread(Einlagern);
t1.Start(); t2.Start();
t1.Join();  t2.Join();
Console.WriteLine(lagerstand);   // immer 2000000
```
````

</div>

<Merke title="🛒 Bezug zum Shop">

Zwei Kassen verkaufen denselben Artikel: Ohne Schutz stimmt der Lagerstand danach nicht mehr.

</Merke>

<!--
- Zuerst den ersten Stand mehrmals ausführen, das Ergebnis ändert sich jedes Mal.
- Die Schleife läuft bewusst eine Million Mal. Bei kleinen Zahlen ist der erste Thread oft schon fertig, bevor der zweite startet, dann stimmt das Ergebnis zufällig.
- Klick: Das `lock` kommt in die Schleife. Jetzt kann immer nur ein Thread `lagerstand++` ausführen.
-->

---
hideInToc: true
title: Race Condition Schritt für Schritt
layout: none
clicks: 4
---

<RaceCondition :schritt="$clicks" />

<!--
`lagerstand++` sieht aus wie ein Schritt, sind aber drei: lesen, rechnen, schreiben. Dazwischen kann der andere Thread drankommen.
-->

---

# Delegate: Methode als Wert

<p class="!mt-1 !mb-3">Bei <code>new Thread(Einlagern)</code> fehlen die Klammern. Warum?</p>

<div class="grid grid-cols-2 gap-6">
<div style="--slidev-code-font-size: 0.85rem;">

**Mit Klammern:** jetzt ausführen

```csharp
Einlagern();
```

</div>
<div v-click style="--slidev-code-font-size: 0.85rem;">

**Ohne Klammern:** die Methode weitergeben

```csharp
var t = new Thread(Einlagern);
// noch ist nichts passiert
t.Start();   // jetzt läuft sie
```

</div>
</div>

<div v-click>

<Merke title="📞 Analogie">

`Einlagern()` ist wie selbst anrufen. `Einlagern` ist wie die Telefonnummer auf einen Zettel schreiben und weitergeben: Jemand anderer ruft an, wenn es so weit ist.

</Merke>

</div>

<!--
- Einstieg über etwas, das die Klasse gerade gesehen hat: Auf der Folie „Race Condition“ stand `new Thread(Einlagern)`, ohne Klammern.
- Das ist der Kern des ganzen Themas: Eine Methode kann man nicht nur aufrufen, man kann sie auch weitergeben.
- Frage an die Klasse: Was würde `new Thread(Einlagern())` bedeuten? Antwort: `Einlagern` liefe sofort, und zwar auf dem aktuellen Thread. Der Compiler meldet dann einen Fehler, weil `Einlagern` nichts zurückgibt.
-->

---
hideInToc: true
---

# Wozu soll das gut sein?

Zwei Rabatte im Shop, zwei fast gleiche Methoden:

<div style="--slidev-code-font-size: 0.72rem; --slidev-code-line-height: 1.35;">

```csharp {all|4,10}
static void RechnungZehnProzent(decimal preis)
{
    Console.WriteLine($"Preis:     {preis:C}");
    Console.WriteLine($"Zu zahlen: {preis * 0.9m:C}");
}

static void RechnungFuenfEuro(decimal preis)
{
    Console.WriteLine($"Preis:     {preis:C}");
    Console.WriteLine($"Zu zahlen: {preis - 5m:C}");
}
```

</div>

<div v-click="1" class="text-lg mt-3">

Nur die **Rechnung** ist anders. Einen anderen **Wert** übergibt man als Parameter. Aber wie übergibt man eine andere **Rechnung**?

</div>

<!--
- Bewusst ein Problem ohne Threads. Hier sieht man den Nutzen am leichtesten.
- Kommt ein dritter Rabatt dazu, braucht man eine dritte Kopie. Ändert sich die Ausgabe, muss man jede Kopie ändern.
- Die Schüler kennen die Lösung für unterschiedliche Werte: Parameter. Genau das wollen wir jetzt auch für Rechenregeln. Eine Rechenregel ist in C# eine Methode.
-->

---
hideInToc: true
title: Eine Variable für eine Methode
layout: none
clicks: 5
---

<DelegateVariable :schritt="$clicks" />

<!--
- Vor einem Parameter kommt der einfachere Fall: eine Variable. Ein Parameter ist ja auch nur eine Variable.
- Klick 1: Das bekannte Bild, der Typ sagt, was in die Variable passt.
- Klick 2: Gleiches Muster, nur passt in `rabatt` eine Methode. `ZehnProzent` steht ohne Klammern, also läuft noch nichts.
- Klick 3: Jetzt mit Klammern. `rabatt(100m)` sieht aus wie ein normaler Methodenaufruf, ausgeführt wird `ZehnProzent`.
- Klick 4 und 5: Zuweisen wie bei jeder Variable. Die Aufrufzeile bleibt gleich, das Ergebnis ändert sich. Genau das brauchen wir für die Rechnung.
- `90,0` statt `90`: `decimal` merkt sich die Nachkommastellen aus `0.9m`. Das hat mit Delegates nichts zu tun.
- Begriff: „Delegate“ heißt die Art von Typ, zu der `Func` gehört. Auf Deutsch etwa „Beauftragter“: Ich beauftrage eine Methode, die Arbeit zu machen.
-->

---
hideInToc: true
---

# Welcher Typ passt zu welcher Methode?

<div class="text-sm">

| Methode | passender Typ |
|---|---|
| `decimal ZehnProzent(decimal preis)` | `Func<decimal, decimal>` |
| `bool IstLagernd(int menge)` | `Func<int, bool>` |
| `decimal Gesamtpreis(decimal preis, int menge)` | `Func<decimal, int, decimal>` |
| `void Einlagern()` | `Action` |
| `void Drucke(string text)` | `Action<string>` |

</div>

<Merke>

**`Func`:** Methode mit Rückgabe, der **letzte** Typ ist das Ergebnis. **`Action`:** Methode ohne Rückgabe (`void`). In den spitzen Klammern stehen die Parametertypen.

</Merke>

<!--
- Vorgehen zum Mitsprechen: Gibt die Methode etwas zurück? Dann `Func`, sonst `Action`. Dann die Parametertypen der Reihe nach aufschreiben, bei `Func` zum Schluss den Rückgabetyp.
- Die Parameternamen sind egal, nur die Typen zählen. Darum sagen wir „Form“ der Methode.
- `Func` und `Action` sind fertige Delegates aus .NET, man muss nichts selbst anlegen.
- Falls jemand fragt: Eigene Delegate-Typen gibt es auch, zum Beispiel `delegate decimal Preisregel(decimal p);`. Heute nimmt man fast immer `Func` und `Action`.
-->

---
hideInToc: true
---

# Zwei typische Fehler

<div class="mt-4" style="--slidev-code-font-size: 0.8rem; --slidev-code-line-height: 1.5;">

```csharp {all|1|3|5}
Func<decimal, decimal> r = ZehnProzent(100m);   // Fehler

Func<decimal, decimal> r = Einlagern;           // Fehler

Func<decimal, decimal> r = ZehnProzent;         // richtig
```

</div>

<v-clicks at="1">

- **Zeile 1:** Mit Klammern ist das ein Aufruf. Das Ergebnis ist ein `decimal`, keine Methode.
- **Zeile 3:** `Einlagern` hat die falsche Form: kein Parameter, keine Rückgabe.
- **Zeile 5:** Ohne Klammern, und die Form passt.

</v-clicks>

<!--
- Der erste Fehler ist der häufigste: Die Klammern gehören zum Aufruf, nicht zum Weitergeben.
- Die Compiler-Meldungen dazu: CS0029 („Der Typ decimal kann nicht implizit in Func<decimal, decimal> konvertiert werden“) und CS0123 („Keine Überladung für Einlagern stimmt mit dem Delegaten überein“).
- Beide Fehler findet der Compiler. Das Programm startet gar nicht erst.
-->

---
hideInToc: true
---

# Die Methode als Parameter

<div style="--slidev-code-font-size: 0.72rem; --slidev-code-line-height: 1.35;">

````md magic-move
```csharp
static void RechnungZehnProzent(decimal preis)
{
    Console.WriteLine($"Preis:     {preis:C}");
    Console.WriteLine($"Zu zahlen: {preis * 0.9m:C}");
}

static void RechnungFuenfEuro(decimal preis)
{
    Console.WriteLine($"Preis:     {preis:C}");
    Console.WriteLine($"Zu zahlen: {preis - 5m:C}");
}
```
```csharp
static void Rechnung(decimal preis, Func<decimal, decimal> rabatt)
{
    Console.WriteLine($"Preis:     {preis:C}");
    Console.WriteLine($"Zu zahlen: {rabatt(preis):C}");
}

static decimal ZehnProzent(decimal preis) { return preis * 0.9m; }
static decimal FuenfEuro(decimal preis)   { return preis - 5m; }

Rechnung(100m, ZehnProzent);   // Zu zahlen: € 90,00
Rechnung(100m, FuenfEuro);     // Zu zahlen: € 95,00
```
````

</div>

<div v-click="1">

<Merke>

`Rechnung` weiß nicht, welcher Rabatt gilt. Sie bekommt ihn als Parameter und ruft ihn auf, wenn es so weit ist.

</Merke>

</div>

<!--
- Das ist die Lösung für das Problem von vorhin. Der Parameter `rabatt` ist genau die Variable von der Folie „Eine Variable für eine Methode“.
- Beim Aufruf steht `ZehnProzent` ohne Klammern: Wir geben die Methode weiter, `Rechnung` ruft sie selbst auf.
- Ein neuer Rabatt braucht jetzt nur noch eine kleine Methode, `Rechnung` bleibt unverändert.
-->

---
hideInToc: true
---

# Lambda: Methode ohne Namen

<div class="mt-2" style="--slidev-code-font-size: 0.9rem; --slidev-code-line-height: 1.5;">

````md magic-move
```csharp
// Methode mit Namen, nur für diesen einen Aufruf
static decimal FuenfEuro(decimal preis)
{
    return preis - 5m;
}

Rechnung(100m, FuenfEuro);
```
```csharp
// Name und Rückgabetyp weg, dafür =>
Rechnung(100m, (decimal preis) => { return preis - 5m; });
```
```csharp
// Parametertyp weg: Der Compiler kennt ihn aus Func<decimal, decimal>
Rechnung(100m, (preis) => { return preis - 5m; });
```
```csharp
// Nur ein Ausdruck: Klammern, { } und return weg
Rechnung(100m, preis => preis - 5m);
```
````

</div>

<div v-click="3">

<Merke>

Ein **Lambda** ist eine kurze Methode ohne Namen, direkt dort geschrieben, wo man sie braucht. Links von `=>` stehen die Parameter, rechts steht der Code.

</Merke>

</div>

<!--
- Alle vier Stände sind gültiges C# und tun genau dasselbe. Es wird nur Schritt für Schritt weggelassen, was der Compiler ohnehin weiß.
- Vorlesen: „preis wird zu preis minus 5“.
- Das Lambda ist nur eine Schreibweise. Es passt in dieselbe `Func`-Variable wie eine Methode mit Namen.
- Hat das Lambda keinen Parameter, bleiben leere Klammern: `() => …`. Das braucht die Bonusaufgabe, und es kommt auf „Das kennt ihr schon“ wieder.
-->

---
hideInToc: true
---

<PraxisSlide block="1" title="Rabatte an der Kassa" time="15 min">

Übernehmt die Methode `Rechnung` in ein neues Konsolenprojekt:

<div style="--slidev-code-font-size: 0.66rem;">

```csharp
static void Rechnung(decimal preis, Func<decimal, decimal> rabatt)
{
    Console.WriteLine($"Preis:     {preis:C}");
    Console.WriteLine($"Zu zahlen: {rabatt(preis):C}");
}
```

</div>

1. Schreibt die Methode `Treuerabatt` (15 % weniger) und übergebt sie an `Rechnung`. Preis: 200 €.
2. Aktion „20 € weniger“: Übergebt diesmal ein **Lambda** statt einer Methode mit Namen.
3. Ein Kunde bekommt keinen Rabatt. Wie sieht das Lambda aus?
4. **Bonus:** Schreibt die Methode `Zweimal`, die eine `Action` bekommt und sie zweimal aufruft. Gebt damit „Danke für den Einkauf!“ aus.

<template #hinweis>

Beim Übergeben keine Klammern! Ein Lambda ohne Parameter beginnt mit `() =>`.

</template>

</PraxisSlide>

<!--
- Erwartete Ergebnisse zum Kontrollieren: 170,00 €, 180,00 € und 200,00 €.
- Wer bei Aufgabe 1 hängt: Die Methode `ZehnProzent` als Vorlage nehmen.
- Aufgabe 3 ist die Denkaufgabe: Das Lambda gibt den Preis einfach unverändert zurück.
- Die Bonusaufgabe übt `Action`, das bisher nur in der Tabelle vorkam.
-->

---
hideInToc: true
---

# Lösung

<div style="--slidev-code-font-size: 0.72rem; --slidev-code-line-height: 1.35;">

```csharp {all|1-2|4|6|8-14}
static decimal Treuerabatt(decimal preis) { return preis * 0.85m; }
Rechnung(200m, Treuerabatt);             // Zu zahlen: € 170,00

Rechnung(200m, preis => preis - 20m);    // Zu zahlen: € 180,00

Rechnung(200m, preis => preis);          // Zu zahlen: € 200,00

static void Zweimal(Action aufgabe)
{
    aufgabe();
    aufgabe();
}

Zweimal(() => Console.WriteLine("Danke für den Einkauf!"));
```

</div>

<!--
- Der Parametername im Lambda ist frei wählbar, `p => p - 20m` ist genauso richtig.
- Bonus: `Zweimal` weiß nicht, was `aufgabe` tut, genau wie `Rechnung` den Rabatt nicht kennt.
-->

---
hideInToc: true
---

# Das kennt ihr schon

<div class="text-sm">

| Code | Was wird weitergegeben? | Wer ruft es auf, und wann? |
|---|---|---|
| `Rechnung(100m, ZehnProzent)` | die Methode `ZehnProzent` | `Rechnung`, in ihrem Code |
| `new Thread(Einlagern)` | die Methode `Einlagern` | der neue Thread, nach `Start()` |
| `new Thread(() => { … })` | ein Lambda ohne Parameter | der neue Thread, nach `Start()` |
| `btnLaden.Click += btnLaden_Click;` | die Methode `btnLaden_Click` | WinForms, bei jedem Klick |

</div>

<Merke>

Ein Delegate heißt: „Hier ist eine Methode, ruf sie auf, wenn es so weit ist.“

</Merke>

<!--
- Jetzt lösen wir auf, was auf „Threads in C#“ noch offen war: `() => { … }` ist ein Lambda ohne Parameter.
- Der Thread macht dasselbe wie `Rechnung`: Er bekommt eine Methode und ruft sie später auf.
- Darum hat `btnLaden_Click` immer die Parameter `object sender, EventArgs e`: Das `Click`-Ereignis erwartet genau diese Form.
- Genau genommen heißen die Delegate-Typen hier `ThreadStart` und `EventHandler`. Sie funktionieren wie `Action`, die Namen muss niemand lernen.
- Überleitung: Auf der nächsten Folie steht wieder ein Lambda, bei `Task.Run`.
-->

---

# Task: Ergebnis kommt später

<div style="--slidev-code-font-size: 0.7rem; --slidev-code-line-height: 1.35;">

```csharp {1-8|10|11|12|all}
static decimal BerechneLagerwert(List<Artikel> artikel)
{
    decimal summe = 0;
    foreach (var a in artikel)
        summe += a.Preis * a.Lagerstand;
    Thread.Sleep(2000);                    // simuliert eine aufwändige Berechnung
    return summe;
}

Task<decimal> bon = Task.Run(() => BerechneLagerwert(liste));   // Delegate: was zu tun ist
Console.WriteLine("Berechnung läuft …");
decimal wert = bon.Result;                                       // wartet: blockiert!
```

</div>

<div class="grid grid-cols-2 gap-4">

<Merke title="🍔 Analogie">

Bon an der Fast-Food-Kassa: Man bekommt ihn sofort, das Essen kommt später.

</Merke>

<Merke>

Ein Task ist **kein Thread**, sondern „ein Ergebnis kommt später“. `Task.Run` nutzt den ThreadPool.

</Merke>

</div>

<!--
`liste` ist eine `List<Artikel>` mit Testdaten.
-->

---

# Von .Result zu await

<div class="mt-6" style="--slidev-code-font-size: 0.85rem; --slidev-code-line-height: 1.5;">

````md magic-move
```csharp
decimal wert = bon.Result;                       // blockiert den Thread
Console.WriteLine($"Lagerwert: {wert:C}");
```
```csharp
bon.ContinueWith(t =>                            // Fortsetzung als Delegate
    Console.WriteLine($"Lagerwert: {t.Result:C}"));
```
```csharp
decimal wert = await bon;                        // wartet, ohne zu blockieren
Console.WriteLine($"Lagerwert: {wert:C}");       // ← das ist die Fortsetzung
```
````

</div>

<Merke>

`await` macht aus dem Rest der Methode die Fortsetzung. Das ist im Prinzip dasselbe wie `ContinueWith`, aber lesbar, mit normalem `try`/`catch`, und in WinForms läuft es automatisch wieder auf dem UI-Thread.

</Merke>

<div class="text-sm mt-4">

**Regeln:** `async` an der Methode · Rückgabe `Task` bzw. `Task<T>` · `async void` nur bei Ereignis-Handlern

</div>

<!--
- Stand 2 läuft nebenher weiter: Endet ein Konsolenprogramm direkt danach, kommt die Ausgabe eventuell gar nicht mehr.
- Stand 3 funktioniert in `Program.cs` ohne weiteres, weil die Top-Level-Anweisungen `await` erlauben.
-->

---

# Zurück zum Fenster

<div class="mt-6" style="--slidev-code-font-size: 0.9rem; --slidev-code-line-height: 1.55;">

````md magic-move
```csharp
private void btnLaden_Click(object sender, EventArgs e)
{
    Thread.Sleep(5000);          // steht für eine langsame Aufgabe
    lblStatus.Text = "Fertig";
}
```
```csharp
private async void btnLaden_Click(object sender, EventArgs e)
{
    lblStatus.Text = "Lade …";
    await Task.Delay(5000);      // wartet, ohne zu blockieren
    lblStatus.Text = "Fertig";
}
```
````

</div>

<!--
`async void` ist hier richtig: Der Handler muss zur Signatur des `Click`-Ereignisses passen.
-->

---
hideInToc: true
title: Was bei await passiert
layout: none
clicks: 4
---

<AwaitAblauf :schritt="$clicks" />

<!--
- Der entscheidende Klick ist der dritte: Während der 5 Sekunden wartet kein Thread. Der UI-Thread ist frei.
- `Task.Delay` stellt nur einen Timer. Ist die Zeit um, geht es mit der Fortsetzung weiter.
-->

---

# Rechnen oder warten?

<div class="text-sm">

| Situation | Lösung |
|---|---|
| **Rechnen** (CPU-lastig), z. B. Lagerwert über 1 Mio. Artikel | `await Task.Run(...)` |
| **Warten** (Datei, Netzwerk) | die `…Async`-Methode direkt mit `await` aufrufen |

</div>

<div class="mt-3" style="--slidev-code-font-size: 0.72rem; --slidev-code-line-height: 1.35;">

```csharp
static async Task<int> ZaehleZeilenAsync(string pfad)
{
    string[] zeilen = await File.ReadAllLinesAsync(pfad);
    return zeilen.Length;
}
```

</div>

<Merke>

Beim Warten auf die Datei arbeitet kein Thread, darum braucht es auch kein `Task.Run`.

</Merke>

<!--
Überleitung zum Foliensatz „Asynchroner Datenzugriff“: Dort stellen wir den gesamten Datenzugriff von sync auf async um.
-->

---

# Zusammenfassung

<div class="text-sm">

| Begriff | in einem Satz |
|---|---|
| Thread | Ausführungsstrang, teuer, ohne Rückgabewert |
| Delegate | Methode als Wert (`Action`, `Func`, Lambda) |
| Task | Ergebnis, das später kommt |
| await | weitermachen, wenn es da ist, ohne zu blockieren |

</div>

<p class="font-bold !mt-4 !mb-1">Drei Fehlvorstellungen:</p>

<v-clicks>

- ❌ „async startet immer einen neuen Thread.“
- ❌ „`Thread.Sleep` ist dasselbe wie `await Task.Delay`.“
- ❌ „Mehr Threads machen alles schneller.“

</v-clicks>

<!--
- Zu 1: Beim Warten, etwa auf eine Datei, ist gar kein zusätzlicher Thread nötig.
- Zu 2: `Thread.Sleep` blockiert den Thread, `await Task.Delay` gibt ihn frei.
- Zu 3: Threads kosten Speicher und Umschaltzeit. Beim reinen Warten bringen sie gar nichts.
-->
