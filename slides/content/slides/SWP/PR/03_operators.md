---
theme: seriph

title: Operatoren in C#
info: |
  ## Operatoren in C#
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

# Operatoren in C#

---

# Inhalt

<Toc minDepth="1" maxDepth="2" />

---

# Was ist ein Operator?

Ein **Operator** ist ein Symbol, das eine **Operation auf Variablen oder Werten** ausführt.  

- **Beispiele:** `+`, `-`, `*`, `/`, `==`, `&&`, `++`

<br>

> Operatoren sind die „Werkzeuge“ `für Berechnungen und Vergleiche`. 

---

# Arithmetische Operatoren

Verwenden wir für **Berechnungen mit Zahlen**.

| Operator | Bedeutung              | Beispiel | Ergebnis |
|----------|------------------------|----------|----------|
| `+`      | Addition               | `5 + 3`  | 8        |
| `-`      | Subtraktion            | `5 - 3`  | 2        |
| `*`      | Multiplikation         | `5 * 3`  | 15       |
| `/`      | Division               | `10 / 2` | 5        |
| `%`      | Modulo (Rest)          | `10 % 3` | 1        |



---

# Arithmetische Operatoren

**Beispiel:**

```csharp
int a = 10;
int b = 3;
Console.WriteLine(a + b); // 13
Console.WriteLine(a - b); // 7
Console.WriteLine(a % b); // 1
```

<br>

## Operatorrangfolge

Es gilt **Punkt vor Strich** - wie in Mathematik.

```csharp
int ergebnis = 2 + 3 * 4; // 14
int korrekt = (2 + 3) * 4; // 20
```

---

# Zuweisungsoperatoren

| Operator | Bedeutung                   | Beispiel | Entspricht  |
| -------- | --------------------------- | -------- | ----------- |
| `=`      | einfache Zuweisung          | `a = 5`  |             |
| `+=`     | addieren und zuweisen       | `a += 2` | `a = a + 2` |
| `-=`     | subtrahieren und zuweisen   | `a -= 2` | `a = a - 2` |
| `*=`     | multiplizieren und zuweisen | `a *= 3` | `a = a * 3` |
| `/=`     | dividieren und zuweisen     | `a /= 2` | `a = a / 2` |


---

# Inkrement und Dekrement

Erhöhen oder verringern um den Wert `1`.

```cs
int x = 5;
x++; // 6
x--; // 5
```

**Achtung bei der Reihenfolge:**

<div class="grid grid-cols-2 gap-8">
<div>

```csharp
int a = 5;
// erst Ausgabe, danach inkrementieren
Console.WriteLine(a++); // 5
Console.WriteLine(a) // 6
```
</div>
<div>

```csharp
int a = 5;
// erst inkrementieren, danach Ausgabe
Console.WriteLine(++a); // 6
Console.WriteLine(a) // 6
```
</div>
</div>

---

# Vergleichsoperatoren

Vergleichsoperatoren liefern den Datentyp `bool` zurück. Also entweder wahr (`true`) oder falsch (`false`)

| Operator | Bedeutung           | Beispiel | Ergebnis |
| -------- | ------------------- | -------- | -------- |
| `==`     | gleich              | `5 == 5` | true     |
| `!=`     | ungleich            | `5 != 3` | true     |
| `<`      | kleiner als         | `3 < 5`  | true     |
| `>`      | größer als          | `7 > 5`  | true     |
| `<=`     | kleiner oder gleich | `5 <= 5` | true     |
| `>=`     | größer oder gleich  | `6 >= 7` | false    |

---

# Logische Operatoren

Logische Operatoren verknüpfen Bedingungen (z.B. Vergleichsoperatoren) miteinander


| Operator | Bedeutung | Beispiel            | Ergebnis |
| -------- | --------- | ------------------- | -------- | 
| `&&`     | UND       | `(5 > 3 && 2 < 4)`  | true     | 
| `\|\|`   | ODER      | `(5 > 3 \|\| 2 > 4)`| true     |
| `!`      | NICHT     | `!(5 > 3)`          | false    |



