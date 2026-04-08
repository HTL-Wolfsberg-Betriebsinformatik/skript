---
theme: seriph
routerMode: hash
title: Dateien lesen u. schreiben in C#
info: |
  ## Dateien lesen u. schreiben in C#
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

# Dateien lesen & schreiben in C#

## Wie Programme Daten speichern und wieder laden

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Warum brauchen wir Dateien?

Programme verlieren Daten, wenn sie beendet werden.

- Daten werden während der Programmausführung im Arbeitsspeicher (RAM) gespeichert
- Beim Beenden des Programms wird dieser wieder freigegeben.

<br>

👉 *Dateien werden auf der Festplatte persistent gespeichert*

| **Speicher**         | **Verhalten**             |
| -------------------- | ------------------------- |
| RAM                  | schnell, aber vergänglich |
| Festplatte (Dateien) | langsam, aber dauerhaft   |

---

# `ReadAll` & `WriteAll` für Textdateien

Liest bzw schreibt gesamten Inhalt auf einmal

```csharp
// Erstellt Datei und schreibt Text hinein
File.WriteAllText("test.txt", "Hallo Welt!");

// Liest gesamten Inhalt auf einmal
string text = File.ReadAllText("test.txt");


// Mehrere Zeilen schreiben
string[] lines = { "Zeile 1", "Zeile 2", "Zeile 3" };
File.WriteAllLines("test.txt", lines);

// Mehrere Zeilen lesen
string[] lines = File.ReadAllLines("test.txt");
foreach (string line in lines)
{
    Console.WriteLine(line);
}
```

⚠️ `ReadAll...` und `WriteAll...` sind nur für kleine Dateien geeignet

---

# `StreamReader` & `StreamWriter` für Textdateien

Im Gegensatz zu `ReadAll` / `WriteAll` muss bei einem *Stream* nicht alles in den Arbeitsspeicher geladen werden. Bei einem *Stream* lesen und schreiben wir also laufend. 

```csharp
// Erstellen und Schreiben einer Textdatei
using (StreamWriter writer = new StreamWriter("test.txt"))
{
    writer.WriteLine("Hallo");
    writer.WriteLine("Welt");
}

// Lesen einer Textdatei
using (StreamReader reader = new StreamReader("test.txt"))
{
    string line;

    while ((line = reader.ReadLine()) != null)
    {
        Console.WriteLine(line);
    }
}
```

ℹ️ *Netflix und Co. "streamen" auch, d.h. sie laden laufend kleine Videosequenzen, aber nicht den ganzen Film auf einmal zu Beginn.*

---

# Binärdateien

Binärdateien werden als Rohdaten (Bytes) gespeichert und sind für Menschen nicht lesbar.

<br>

```bash
42 -> 00101010
```
<br>

<div class="grid grid-cols-2">
<div>

**Vorteile**

✔️ schneller

✔️ weniger Speicher

✔️ keine Umwandlung notwendig

</div>

<div>

**Nachteile**

❌ nicht lesbar

❌ Reihenfolge wichtig

❌ schwieriger zu debuggen

</div>
</div>

---

# `BinaryReader` & `BinaryWriter` für Binärdateien

Mit `BinaryReader` und `BinaryWriter` liest bzw schreibt C# nicht Text, sondern direkt Datentypen.

```csharp
// Schreiben einer Binärdatei
using (BinaryWriter writer = new BinaryWriter(File.Open("data.bin", FileMode.Create)))
{
    writer.Write(42);          // int
    writer.Write(3.14);        // double
    writer.Write("Hallo");     // string
}

// Lesen einer Binärdatei
using (BinaryReader reader = new BinaryReader(File.Open("data.bin", FileMode.Open)))
{
    int zahl = reader.ReadInt32();
    double d = reader.ReadDouble();
    string text = reader.ReadString();

    Console.WriteLine(zahl);
    Console.WriteLine(d);
    Console.WriteLine(text);
}
```

🚨*Reihenfolge muss identisch sein, ansonsten stürzt das Programm ab, oder liefert falsche Werte*

---

# Vergleich Text vs. Binär

| **Eigenschaft** | **Text**  | **Binär** |
| --------------- | --------- | --------- |
| Lesbarkeit      | ✔         | ❌       |
| Geschwindigkeit | langsamer | schneller |
| Speicher        | größer    | kleiner   |
| Debugging       | einfach   | schwer    |
