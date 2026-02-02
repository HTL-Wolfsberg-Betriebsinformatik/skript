---
theme: seriph
routerMode: hash
title: Einlesen und Ausgeben in C#
info: |
  ## Einlesen und Ausgeben in C#
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

#  Einlesen und Ausgeben

## in C# Konsolenprogrammen

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="2" />

---

# Was ist Ein- und Ausgabe?

Unter **Ein- und Ausgabe** versteht man:

- **Eingabe**: Daten, die der Benutzer ins Programm eingibt  
- **Ausgabe**: Informationen, die das Programm an den Benutzer ausgibt  

---

# Konsolenprogramme in C#
 
**Konsolenprogrammen** sind die einfachste Art strukturierte Programmierung zu erlernen.

Die wichtigsten Befehle zum Einlesen und Ausgeben sind:

| Methode | Zweck |
|-------|------|
| `Console.Write()` | Ausgabe **ohne** Zeilenumbruch |
| `Console.WriteLine()` | Ausgabe **mit** Zeilenumbruch |
| `Console.ReadLine()` | Eine **Textzeile** einlesen |
| `Console.ReadKey()` | **Ein einzelnes Zeichen** einlesen |

---

# Ausgabe – `Write` vs. `WriteLine`

- `WriteLine()` fügt automatisch einen Zeilenumbruch (`\n`) hinzu
- `Write()` nicht (Mehrere `Write()` bleiben in derselben Zeile)

<br>

```csharp
Console.WriteLine("Hallo HTL!");
Console.Write("Dies ist ");
Console.Write("eine Zeile");
```

---

# Variablen ausgeben

In C# gibt es **mehrere Möglichkeiten**, Variablen in Texten auszugeben.

```csharp
string name = "Max";
int alter = 16;
```


**Variante 1: Verkettung**

```csharp
Console.WriteLine("Name: " + name + ", Alter: " + alter);
```

<div class="mt-12 grid grid-cols-2 gap-16">

<div class="">

**Was passiert hier?**

- Der `+` Operator verbindet (verkettet) Strings
- Zahlen (`alter`) werden **automatisch in Text umgewandelt**
- Alles wird zu **einem großen String**

</div>
<div>

**Nachteile:**

- unübersichtlich bei vielen Variablen
- viele `+` Zeichen → schwer zu lesen
- Leerzeichen werden vergessen (e.g. `"Name: "`)

</div>
</div>

---
hideInToc: true
---

# Variablen ausgeben

In C# gibt es **mehrere Möglichkeiten**, Variablen in Texten auszugeben.

```csharp
string name = "Max";
int alter = 16;
```


**Variante 2: String-Interpolation (mit `$`)**

```csharp
Console.WriteLine($"Name: {name}, Alter: {alter}");
```

<div class="mt-12 grid grid-cols-2 gap-16">

<div class="">

**Was bedeutet das $?**

- Das `$` sagt C#: *"In diesem String sind Variablen eingebaut"*
- Variablen werden in `{ }` geschrieben
- C# setzt die Werte automatisch ein

</div>
<div>

**Vorteile:**

- sehr lesbar
- kaum Fehler
- Standard-Methode in modernem C#

✅ Empfohlen!
</div>
</div>

---

# Eingabe - Text einlesen

Mit `Console.ReadLine()` kann ein Text von der Konsole eingelesen werden. Diese Funktion liefert **immer einen String** zurück.

<br>

```csharp
Console.Write("Wie heißt du? ");
string name = Console.ReadLine();

Console.WriteLine($"Hallo {name}!");
```

---

# Eingabe - Einzelnes Zeichen einlesen

`Console.ReadKey()` liest nur das nächste eingegebene Zeichen ein.

<br>

```csharp
Console.Write("Beliebige Taste drücken...");
Console.ReadKey();
```

---

# Eingabe - Zahl einlesen

Über die Konsole lesen wir immer Strings ein, anschließend können wir eine **Typumwandlung durchführen**

| Methode          | Beschreibung    |
| ---------------- | --------------- |
| `int.Parse()`    | String → int    |
| `double.Parse()` | String → double |
| `bool.Parse()`   | String → bool   |

<br>

**Beispiel:**

```csharp
Console.Write("Wie alt bist du? ");
int alter = int.Parse(Console.ReadLine());

Console.WriteLine($"Du bist {alter} Jahre alt.");

```






