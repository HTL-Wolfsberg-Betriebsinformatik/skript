---
theme: seriph
routerMode: hash
title: Arrays in C#
info: |
  ## Arrays in C#
background: https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true
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

#  Arrays

## Eine Variable. Viele Werte.
---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="2" />

---

# Das Problem

Oft gehören Variablen **logisch zusammen**. Zum Beispiel mehrere Noten einer Klasse oder mehrere Messwerte.

<br>

Speichern wir diese einzeln, wird der Code schnell unübersichtlich und schwer wartbar:

```csharp
int note1 = 2;
int note2 = 1;
int note3 = 3;
int note4 = 2;
int note5 = 4;
```

**Warum ist das unpraktisch?**

- Viele einzelne Variablen sind schwer erweiterbar
<br>
👉 Wenn statt 5 plötzlich 30 Werte benötigt werden, müssen 30 Variablen erstellt werden
- Auch Berechnungen wie Durchschnitt oder Maximum werden kompliziert

--- 

# Die Lösung: Ein Array

Ein Array ist eine **Sammlung von mehreren Werten gleichen Datentyps**. Alle Werte werden **unter einem gemeinsamen Namen gespeichert**.

<br>
Eine Sammlung von Integer (ganze Zahlen) kann wie folgt aussehen:

<br>
<br>
```csharp
int[] noten = new int[5];
```

---

# Die Syntax verstehen 

```csharp
int[] noten = new int[5];
```
<br>

<div v-click>

1. `int[]`
    - Bedeutet *ein Array von ganzen Zahlen*
    - `int`: Datentyp der einzelnen Elemente
    - `[]`: Kennzeichnet, dass es sich um ein Array handelt
</div>
<div v-click>

2. `noten`
    - Das ist der Name der Variable.
    - Unter diesem Namen wird das gesamte Array angesprochen
</div>
<div v-click>

3. `new int[5]`
    - `new`: Es wird Speicher reserviert
    - `int`: Der Speicher ist für ganze Zahlen
    - `[5]`: Es werden 5 Speicherplätze angelegt
</div>




---

# Der Speicher

Ein Array kann man sich wie eine Reihe von nummerierten Fächern vorstellen. Jedes Fach speichert genau einen Wert.

<br>
<br>

<ArrayViz label="int[] noten = new int[5]" :items="[0,0,0,0,0]" :showLength="false" :showIndices="false" />

<br>
<br>
<br>
<br>

> 💡Sofern keine Werte dem Array beim Erstellen zugewiesen werden, bekommt dieses die Standardwerte des Datentyps. Im Falle von `int` ist dieser `0`.

---

# Der Index

Der **Index ist die Positionsnummer eines Elements** im Array, über die man gezielt **auf einen bestimmten Speicherplatz zugreifen kann**.

<br>
<br>

<ArrayViz :items="[0,0,0,0,0]" :showLength="false" :showIndices="true" />

<br>

<div class="text-center border-2 border-red"> ❗❗❗Der Index startet immer bei 0 ❗❗❗</div>

---

# Werte speichern & lesen

Auf einzelne Elemente greift man mit dem Index zu. Die Syntax lautet: `arrayName[index]`.

```csharp
int[] noten = new int[5];

noten[0] = 2;
noten[1] = 1;
noten[2] = 3;
noten[3] = 2;
noten[4] = 4;
```


<ArrayViz :items="[2,1,3,2,4]" :showLength="false" :showIndices="true" />

```csharp
Console.WriteLine(noten[0]);
int erstes = noten[0];
int zweites = noten[1];
// ...
```
---

# Übung: Mein erstes Array

1. Erstelle ein Array der Größe 7
2. Speichere die Höchsttemperaturen der letzten 7 Tage.


<br>
<div v-click>

**Was passiert wenn wir ein 8.Element speichern wollen?**
</div>
---

# Varianten zur Initialisierung

<div v-click>
1. Nur Speicher reservieren

```csharp
int[] zahlen = new int[5];
```
</div>
<br>
<div v-click>
2. Direkt mit Werten befüllen (klassisch)

```csharp
int[] zahlen = new int[] { 2, 4, 6, 8, 10 }; // Größe wird automatisch bestimmt.
```
</div>
<br>
<div v-click>
3. Direkt mit Werten befüllen (modern)

```csharp
int[] zahlen = { 2, 4, 6, 8, 10 }; // Größe wird automatisch bestimmt.
```
</div>
<br>
<div v-click>
4. Spätere Zuweisung

```csharp
int[] zahlen; // Deklarieren

zahlen = new int[] { 2, 4, 6, 8, 10 }; // Initialisieren
```
</div>
---

# `Length` Eigenschaft

Jedes Array besitzt die Eigenschaft `Length`. Sie gibt an, **wie viele Elemente im Array vorhanden sind**.

<br>
<br>

```csharp {3}
int[] noten = new int[5];

Console.WriteLine(noten.Length);
```

<div v-click>

**Ausgabe:**

```bash
5
```

</div>

---

# Arrays und `for`-Schleifen

Arrays werden fast immer mit Schleifen kombiniert. Mit der `for`-Schleife können wir **alle Elemente durchlaufen**. Die `Length` Eigenschaft nutzen wir für die Abbruchbedingung.

```csharp
int[] noten = { 1, 2, 4, 3, 2 };

for (int i = 0; i < noten.Length; i++)
{
    Console.WriteLine(noten[i]);
}
```

<br>

<div class="grid grid-cols-2">
<div>

<v-switch at="0">
  <template #0>
    <ArrayViz label="i = 0" :items="[1, 2, 4, 3, 2]" :showLength="false" :showIndices="true" :highlightIndex="0"/>
  </template>
  <template #1>
    <ArrayViz label="i = 1" :items="[1, 2, 4, 3, 2]" :showLength="false" :showIndices="true" :highlightIndex="1"/>
  </template>
  <template #2>
    <ArrayViz label="i = 2" :items="[1, 2, 4, 3, 2]" :showLength="false" :showIndices="true" :highlightIndex="2"/>
  </template>
  <template #3>
    <ArrayViz label="i = 3" :items="[1, 2, 4, 3, 2]" :showLength="false" :showIndices="true" :highlightIndex="3"/>
  </template>
  <template #4>
    <ArrayViz label="i = 4" :items="[1, 2, 4, 3, 2]" :showLength="false" :showIndices="true" :highlightIndex="4"/>
  </template>
</v-switch>

</div>
<div>

**Ausgabe:**

```bash {1|1-2|1-3|1-4|1-5}
1
2
4
3
2
```

</div>
</div>

---

# Arrays und `foreach`-Schleifen

Mit `foreach` kann man ein Array einfacher durchlaufen. Sie eignet sich besonders **zum Ausgeben von Werten**.

<br>

```csharp {3-6}
int[] noten = new int {1, 2, 4, 3, 2}

foreach (int note in noten)
{
    Console.WriteLine(note);
}
```

---

# Beispiel: Berechnungen mit Array

Arrays erleichtern Berechnungen über viele Werte. Zum Beispiel die Summe oder den Durchschnitt.

<br>

```csharp
int summe = 0;

for (int i = 0; i < noten.Length; i++)
{
    summe += noten[i];
}

double durchschnitt = (double)summe / noten.Length;
```

---

# Beispiel: Werte vom Benutzer einlesen

Arrays können auch dynamisch befüllt werden. Oft geschieht das über eine Schleife.

<br>

```csharp
int[] zahlen = new int[3];

for (int i = 0; i < zahlen.Length; i++)
{
    Console.Write("Zahl eingeben: ");
    zahlen[i] = int.Parse(Console.ReadLine());
}
```

---

# Übung: Erstelle ein Namens-Array

1. Erstelle ein Array der Größe 5 vom Typ `string`
2. Lies 5 Namen über die Konsole ein.
3. Gib anschließend die Namen in einer Zeile, getrennt durch ein Leerzeichen, wieder aus.







