---
theme: seriph
routerMode: hash
title: Schleifen in C#
info: |
  ## Schleifen in C#
  while, do-while und for
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

# Schleifen

## Wiederholen, ohne zu kopieren

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" columns="2" />

---

# Das Problem

Wir wollen die Zahlen von **1 bis 5** ausgeben:

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

```csharp
Console.WriteLine(1);
Console.WriteLine(2);
Console.WriteLine(3);
Console.WriteLine(4);
Console.WriteLine(5);
```

</div>
<div>

<v-clicks>

- Und jetzt bis **1000**? 😩
- Und bis zu einer Zahl, die der **Benutzer eingibt**?
- Oder: „Frag so lange nach dem Passwort, **bis es stimmt**“. Wie oft ist das?

</v-clicks>

</div>
</div>

<Merke v-click>

Copy & Paste funktioniert nur, wenn die Anzahl **vorher bekannt** und **klein** ist. Für alles andere brauchen wir **Schleifen**.

</Merke>

---

# Was ist eine Schleife?

Eine **Schleife** wiederholt einen Codeblock, **solange eine Bedingung `true` ist**.

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

**Im Alltag**

<v-clicks>

- **Solange** der Teller nicht leer ist: einen Bissen essen
- **Solange** noch Stufen da sind: eine Stufe hinaufgehen
- Rühre um, **bis** der Teig glatt ist

</v-clicks>

</div>
<div v-click>

**Begriffe**

| Begriff | Bedeutung |
| ------- | --------- |
| **Bedingung** | Entscheidet, ob noch einmal wiederholt wird |
| **Schleifenrumpf** | Der Code, der wiederholt wird |
| **Durchlauf** (Iteration) | Eine einzelne Ausführung des Rumpfs |
| **Schleifenvariable** | Variable, die sich bei jedem Durchlauf ändert |

</div>
</div>

<div v-click class="mt-4">

In C# lernen wir heute drei Schleifen kennen: **`while`** → **`do-while`** → **`for`**

</div>

---

# Die `while`-Schleife

`while` heißt **„solange“**: Der Rumpf wird wiederholt, **solange** die Bedingung `true` ist.

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

**Aufbau**

```csharp
while (Bedingung)
{
    // Schleifenrumpf
}
```

**Beispiel:** Zahlen von 1 bis 3 ausgeben

```csharp
int zahl = 1;
while (zahl <= 3)
{
    Console.WriteLine(zahl);
    zahl++;
}
Console.WriteLine("Fertig");
```

</div>
<div>

<v-clicks>

- Die Bedingung wird **vor** jedem Durchlauf geprüft → **kopfgesteuerte** Schleife
- `true` → Rumpf ausführen, danach **zurück zur Bedingung**
- `false` → Schleife verlassen, weiter nach `}`
- Ist die Bedingung gleich am Anfang `false`, läuft der Rumpf **kein einziges Mal**

</v-clicks>

<div v-click class="mt-4">

**Frage:** Welche Ausgabe erwartet ihr? Wie oft wird `zahl <= 3` geprüft?

</div>

</div>
</div>

---
title: Ablauf einer while-Schleife
layout: none
clicks: 13
---

<FlussAblauf szenario="while" :schritt="$clicks" />

---

# Die drei Zutaten jeder Zählschleife

Damit eine Schleife **richtig zählt** und **wieder aufhört**, braucht sie drei Dinge:

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

```csharp {1|2|5|all}
int zahl = 1;          // ① Startwert
while (zahl <= 3)      // ② Bedingung
{
    Console.WriteLine(zahl);
    zahl++;            // ③ Veränderung
}
```

</div>
<div>

<v-clicks>

- **① Startwert**: Womit fängt die Schleifenvariable an?
- **② Bedingung**: Wann wird noch einmal wiederholt?
- **③ Veränderung**: Was ändert sich in jedem Durchlauf?

</v-clicks>

</div>
</div>

<Merke v-click>

Die **Veränderung** muss die Bedingung irgendwann `false` machen. Sonst hört die Schleife nie auf.

</Merke>

---

# Die Endlosschleife

Was passiert, wenn wir `zahl++` vergessen?

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

```csharp
int zahl = 1;
while (zahl <= 3)
{
    Console.WriteLine(zahl);
    // zahl++ vergessen!
}
```

</div>
<div>

<v-clicks>

- `zahl` bleibt für immer `1`
- `1 <= 3` ist **immer** `true`
- Das Programm gibt endlos `1` aus und **hängt**
- Abbrechen in der Konsole mit **`Strg` + `C`**

</v-clicks>

</div>
</div>

<Achtung v-click title="⚠️ Weitere Endlosschleifen-Fallen">

`while (zahl <= 3);` mit Strichpunkt: Die Schleife hat einen **leeren Rumpf** und läuft für immer.<br>
`zahl--` statt `zahl++`: Die Zahl wird kleiner und kleiner, `zahl <= 3` bleibt immer `true`.

</Achtung>

---

# `while` mit unbekannter Anzahl

Die eigentliche Stärke von `while`: Wir wissen **vorher nicht**, wie oft wiederholt wird.

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

```csharp
int summe = 0;
Console.Write("Zahl (0 = Ende): ");
int eingabe = int.Parse(Console.ReadLine());

while (eingabe != 0)
{
    summe += eingabe;
    Console.Write("Zahl (0 = Ende): ");
    eingabe = int.Parse(Console.ReadLine());
}

Console.WriteLine($"Summe: {summe}");
```

</div>
<div>

<v-clicks>

- Der Benutzer entscheidet, **wann Schluss ist**
- Hier gibt es keinen Zähler: Die **Eingabe** ist die Schleifenvariable
- Die Eingabe steht **zweimal** im Code: einmal vor der Schleife (für die erste Prüfung) und einmal am Ende des Rumpfs (für die nächste Prüfung)

</v-clicks>

<div v-click class="mt-6 text-sm opacity-90">

Das doppelte Einlesen ist umständlich. Genau dafür gibt es die nächste Schleife.

</div>

</div>
</div>

---

# Die `do-while`-Schleife

`do` heißt **„mach“**: Zuerst wird der Rumpf ausgeführt, **danach** wird geprüft.

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

**Aufbau**

```csharp
do
{
    // Schleifenrumpf
}
while (Bedingung);
```

**Beispiel**

```csharp
int zahl = 1;
do
{
    Console.WriteLine(zahl);
    zahl++;
}
while (zahl <= 3);
Console.WriteLine("Fertig");
```

</div>
<div>

<v-clicks>

- Die Bedingung steht **am Ende** → **fußgesteuerte** Schleife
- Der Rumpf läuft **mindestens einmal**, auch wenn die Bedingung von Anfang an `false` ist
- Nach `while (…)` steht hier ein **Strichpunkt** `;`

</v-clicks>

<Achtung v-click title="⚠️ Achtung Strichpunkt">

Bei `do-while` **muss** nach der Bedingung ein `;` stehen.<br>
Bei `while` darf dort **keiner** stehen.

</Achtung>

</div>
</div>

---
title: Ablauf einer do-while-Schleife
layout: none
clicks: 12
---

<FlussAblauf szenario="dowhile" :schritt="$clicks" />

---

# `while` oder `do-while`: der Unterschied

Was passiert, wenn `zahl` mit **5** startet?

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

**`while`**: erst prüfen, dann machen

```csharp
int zahl = 5;
while (zahl <= 3)
{
    Console.WriteLine(zahl);
    zahl++;
}
```

<div v-click="1">

Ausgabe: *(nichts)*<br>
`5 <= 3` ist `false`, der Rumpf läuft **0-mal**.

</div>

</div>
<div>

**`do-while`**: erst machen, dann prüfen

```csharp
int zahl = 5;
do
{
    Console.WriteLine(zahl);
    zahl++;
}
while (zahl <= 3);
```

<div v-click="2">

Ausgabe: `5`<br>
Der Rumpf läuft, **bevor** geprüft wird: **1-mal**.

</div>

</div>
</div>

<Merke v-click="3">

Probiert es in den beiden Ablauf-Folien davor aus: Startwert **5** wählen und durchklicken!

</Merke>

---

# Typischer Einsatz: Eingaben prüfen

`do-while` passt perfekt, wenn etwas **mindestens einmal** passieren muss, zum Beispiel eine Eingabe:

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

```csharp
int note;
do
{
    Console.Write("Note (1-5): ");
    note = int.Parse(Console.ReadLine());
}
while (note < 1 || note > 5);

Console.WriteLine($"Gespeichert: {note}");
```

</div>
<div>

<v-clicks>

- Die Frage muss **sicher einmal** gestellt werden
- Ist die Eingabe ungültig, wird **erneut gefragt**
- Die Eingabe steht nur **einmal** im Code (vergleicht mit der `while`-Variante vorhin!)
- `note` wird **vor** dem `do` deklariert, damit die Bedingung sie sehen kann

</v-clicks>

</div>
</div>

<div v-click class="mt-4">

```text
Note (1-5): 7
Note (1-5): 0
Note (1-5): 2
Gespeichert: 2
```

</div>

---

# Die `for`-Schleife

Bei einer Zählschleife sind die drei Zutaten bei `while` über den Code **verstreut**. `for` sammelt sie **in einer Zeile**.

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

**Aufbau**

```csharp
for (Startwert; Bedingung; Veränderung)
{
    // Schleifenrumpf
}
```

**Beispiel**

```csharp
for (int i = 1; i <= 3; i++)
{
    Console.WriteLine(i);
}
Console.WriteLine("Fertig");
```

</div>
<div>

<v-clicks>

- Die drei Teile werden durch **Strichpunkte** `;` getrennt
- Ideal, wenn die **Anzahl der Durchläufe bekannt** ist
- Die Zählvariable heißt traditionell `i` (für *Index*)
- `for` ist wie `while` **kopfgesteuert**

</v-clicks>

</div>
</div>

---
title: for = while in kompakt
clicks: 3
---

# for = while in kompakt

<ForZerlegung :schritt="$clicks" />

---
title: Ablauf einer for-Schleife
layout: none
clicks: 13
---

<FlussAblauf szenario="for" :schritt="$clicks" />

---

# `for`-Schleifen in Variationen

<div class="grid grid-cols-2 gap-8">
<div>

**Rückwärts zählen**

```csharp
for (int i = 10; i >= 1; i--)
{
    Console.Write($"{i} ");
}
Console.WriteLine("Start! 🚀");
```

`10 9 8 7 6 5 4 3 2 1 Start! 🚀`

**In Zweierschritten**

```csharp
for (int i = 0; i <= 10; i += 2)
{
    Console.Write($"{i} ");
}
```

`0 2 4 6 8 10`

</div>
<div>

**Summe von 1 bis 100**

```csharp
int summe = 0;
for (int i = 1; i <= 100; i++)
{
    summe += i;
}
Console.WriteLine(summe);
```

`5050`

<v-click>

**Bis zu einer Eingabe**

```csharp
int n = int.Parse(Console.ReadLine());
for (int i = 1; i <= n; i++)
{
    Console.WriteLine($"{i}. Durchlauf");
}
```

</v-click>

</div>
</div>

---

# Typische Fehler bei `for`

<div class="grid grid-cols-2 gap-8">
<div>

<Achtung title="⚠️ Einer zu viel oder zu wenig">

```csharp
// soll 5-mal laufen
for (int i = 1; i < 5; i++)   // nur 4-mal!
for (int i = 0; i < 5; i++)   // 5-mal ✓
for (int i = 1; i <= 5; i++)  // 5-mal ✓
```

Dieser Fehler ist so häufig, dass er einen eigenen Namen hat: **Off-by-one-Fehler**.

</Achtung>

<Achtung title="⚠️ Strichpunkt nach dem Kopf">

```csharp
for (int i = 0; i < 5; i++);
{
    Console.WriteLine("Hallo");
}
```

Die Schleife läuft 5-mal **ohne Rumpf**, „Hallo“ kommt nur **einmal**.

</Achtung>

</div>
<div>

<Achtung title="⚠️ i nach der Schleife verwenden">

```csharp
for (int i = 0; i < 5; i++)
{
    Console.WriteLine(i);
}
Console.WriteLine(i); // Fehler!
```

Eine Variable, die im `for`-Kopf deklariert wird, **existiert nur innerhalb der Schleife**.

</Achtung>

<Merke>

Zählt im Kopf mit: Startwert, letzter Wert, der die Bedingung **noch** erfüllt, und daraus die **Anzahl der Durchläufe**.

</Merke>

</div>
</div>

---

# `break` und `continue`

Zwei Befehle steuern eine Schleife **von innen**:

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

**`break`**: Schleife **sofort verlassen**

```csharp
for (int i = 1; i <= 100; i++)
{
    if (i * i > 50)
    {
        break;
    }
    Console.Write($"{i} ");
}
```

`1 2 3 4 5 6 7`

</div>
<div>

**`continue`**: Rest des Durchlaufs **überspringen**, weiter mit dem nächsten

```csharp
for (int i = 1; i <= 10; i++)
{
    if (i % 3 == 0)
    {
        continue;
    }
    Console.Write($"{i} ");
}
```

`1 2 4 5 7 8 10`

</div>
</div>

<Merke v-click>

Sparsam einsetzen! Meist ist eine gut gewählte **Bedingung** im Schleifenkopf lesbarer als ein `break` mitten im Rumpf.

</Merke>

---

# Verschachtelte Schleifen

Eine Schleife kann **in** einer anderen Schleife stehen. Die innere läuft bei **jedem** Durchlauf der äußeren komplett durch.

<div class="grid grid-cols-2 gap-10 mt-4">
<div>

```csharp
for (int zeile = 1; zeile <= 3; zeile++)
{
    for (int spalte = 1; spalte <= 4; spalte++)
    {
        Console.Write("* ");
    }
    Console.WriteLine();
}
```

</div>
<div>

```text
* * * *
* * * *
* * * *
```

<v-clicks>

- Äußere Schleife: **3** Zeilen
- Innere Schleife: **4** Sterne pro Zeile
- Insgesamt: 3 · 4 = **12** Sterne
- Die innere Zählvariable braucht einen **anderen Namen**

</v-clicks>

</div>
</div>

---

# Welche Schleife wann?

| Schleife | Prüfung | Mindestens | Typischer Einsatz |
| -------- | ------- | ---------- | ----------------- |
| `while` | **vor** jedem Durchlauf | 0-mal | Anzahl unbekannt: „solange noch Eingaben kommen“ |
| `do-while` | **nach** jedem Durchlauf | 1-mal | Etwas muss sicher einmal passieren: Eingabe prüfen, Menü |
| `for` | **vor** jedem Durchlauf | 0-mal | Anzahl bekannt: „mach es 10-mal“, „von 1 bis n“ |

<div class="grid grid-cols-3 gap-4 mt-6 text-sm">
<div v-click class="p-3 rounded border-l-4 border-blue-500 bg-blue-500/10">

**Weiß ich, wie oft?**<br>→ `for`

</div>
<div v-click class="p-3 rounded border-l-4 border-amber-500 bg-amber-500/10">

**Muss es mindestens einmal laufen?**<br>→ `do-while`

</div>
<div v-click class="p-3 rounded border-l-4 border-violet-500 bg-violet-500/10">

**Sonst**<br>→ `while`

</div>
</div>

<div v-click class="mt-4 text-sm opacity-80">

Ausblick: Für Arrays gibt es zusätzlich die **`foreach`**-Schleife. Die lernen wir im Kapitel **Arrays** kennen.

</div>

---
hideInToc: true
---

<PraxisSlide block="1" title="Countdown und Einmaleins" time="15 min">

1. Gebt mit einer **`while`**-Schleife einen Countdown von 10 bis 1 aus, danach „Abflug!“.
2. Lest eine Zahl `n` ein und gebt mit einer **`for`**-Schleife das Einmaleins dieser Zahl aus:

```text
Zahl: 7
1 x 7 = 7
2 x 7 = 14
...
10 x 7 = 70
```

3. Schreibt Aufgabe 1 noch einmal, diesmal mit `for`. Welche Variante ist lesbarer?

<template #hinweis>

Überlegt euch zuerst die drei Zutaten: Startwert, Bedingung, Veränderung.

</template>

</PraxisSlide>

---
hideInToc: true
---

<PraxisSlide block="2" title="Zahlenraten" time="20 min">

Das Programm denkt sich eine Zufallszahl von 1 bis 100 aus. Der Benutzer rät so lange, bis er richtig liegt:

```text
Dein Tipp: 50
Zu groß!
Dein Tipp: 25
Zu klein!
Dein Tipp: 37
Richtig! Du hast 3 Versuche gebraucht.
```

1. Verwendet eine **`do-while`**-Schleife für das Raten.
2. Gebt mit `if` / `else if` die Hinweise „Zu groß!“ oder „Zu klein!“ aus.
3. Zählt die Versuche mit und gebt sie am Ende aus.

<template #hinweis>

Zufallszahl: `int geheim = Random.Shared.Next(1, 101);` (die obere Grenze 101 ist **nicht** enthalten).

</template>

</PraxisSlide>

---
hideInToc: true
---

<PraxisSlide block="3" title="Menü mit Schleife" time="20 min">

Kombiniert Schleifen und Bedingungen zu einem kleinen Menüprogramm:

```text
1) Summe von 1 bis n
2) Sternen-Rechteck zeichnen
0) Beenden
Auswahl:
```

1. Das Menü wird so lange angezeigt, bis der Benutzer **0** wählt (`do-while`).
2. Die Auswahl wird mit einem **`switch`** ausgewertet.
3. **Option 1:** `n` einlesen und die Summe mit `for` berechnen.
4. **Option 2:** Breite und Höhe einlesen und ein Rechteck aus `*` zeichnen (verschachtelte `for`).

<template #hinweis>

Unbekannte Auswahl? `default:` gibt „Ungültige Auswahl“ aus, danach erscheint das Menü erneut.

</template>

</PraxisSlide>

---

# Zusammenfassung

<div class="grid grid-cols-2 gap-10">
<div>

- Eine **Schleife** wiederholt einen Rumpf, solange eine Bedingung `true` ist
- **`while`**: prüft **vorher** → 0 bis n Durchläufe
- **`do-while`**: prüft **nachher** → mindestens 1 Durchlauf, `;` am Ende!
- **`for`**: Startwert, Bedingung und Veränderung **in einer Zeile** → ideal zum Zählen

</div>
<div>

- Jede Zählschleife braucht **Startwert**, **Bedingung** und **Veränderung**
- Fehlt die Veränderung → **Endlosschleife**
- `<` oder `<=`? → Durchläufe nachzählen (**Off-by-one**)
- `break` verlässt die Schleife, `continue` springt zum nächsten Durchlauf

</div>
</div>

<Merke title="💡 Als Nächstes">

Mit Schleifen können wir jetzt viele Werte verarbeiten. Damit wir sie auch **speichern** können, brauchen wir **Arrays**.

</Merke>
