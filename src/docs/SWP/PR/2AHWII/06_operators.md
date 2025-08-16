# Operatoren in C#

## Einführung

Ein **Operator** ist ein Symbol, das eine **Operation auf Variablen oder Werten** ausführt.  
Beispiele: `+`, `-`, `*`, `/`, `==`, `&&`, `++`

!!! note "Merksatz"
    Operatoren sind die „Werkzeuge“ für Berechnungen und Vergleiche.

## Arithmetische Operatoren

Verwenden wir für **Berechnungen mit Zahlen**.

| Operator | Bedeutung              | Beispiel | Ergebnis |
|----------|------------------------|----------|----------|
| `+`      | Addition               | `5 + 3`  | 8        |
| `-`      | Subtraktion            | `5 - 3`  | 2        |
| `*`      | Multiplikation         | `5 * 3`  | 15       |
| `/`      | Division               | `10 / 2` | 5        |
| `%`      | Modulo (Rest)          | `10 % 3` | 1        |

**Beispiel in C#:**
```csharp
int a = 10, b = 3;
Console.WriteLine(a + b); // 13
Console.WriteLine(a - b); // 7
Console.WriteLine(a % b); // 1 (Rest)
```

###  Verknüpfung von Operatoren

Operatoren können kombiniert werden.
Die Reihenfolge wird durch Operatorrangfolge bestimmt (wie in Mathe: Punktrechnung vor Strichrechnung).

```csharp
int ergebnis = 2 + 3 * 4; // 14, nicht 20

```

Klammern können zur Klarheit verwendet werden:

```csharp
int ergebnis = (2 + 3) * 4; // 20
```


## Zuweisungsoperatoren

Weisen einer Variablen einen Wert zu.

| Operator | Bedeutung                   | Beispiel | Ergebnis    |
| -------- | --------------------------- | -------- | ----------- |
| `=`      | einfache Zuweisung          | `a = 5`  | `a` wird 5  |
| `+=`     | addieren und zuweisen       | `a += 2` | `a = a + 2` |
| `-=`     | subtrahieren und zuweisen   | `a -= 2` | `a = a - 2` |
| `*=`     | multiplizieren und zuweisen | `a *= 3` | `a = a * 3` |
| `/=`     | dividieren und zuweisen     | `a /= 2` | `a = a / 2` |

### Inkrement und Dekrement

Spezielle Kurzschreibweise um eine Zahl (um den Wert 1) zu inkrementieren oder dekrementieren.

- `++` erhöht um 1
- `--` verringert um 1

**Beispiel:**

```csharp
int x = 5;
x++; // x = 6
x--; // x = 5
```

Es gibt zwei Varianten:

- Postfix (x++): erst verwenden, dann erhöhen
- Prefix (++x): erst erhöhen, dann verwenden

**Postfix Beispiel**:
```csharp
int a = 5;
Console.WriteLine(a++); // Ausgabe: 5, danach a=6
```

**Prefix Beispiel**:
```csharp
int a = 5;
Console.WriteLine(++a); // Ausgabe: 6, da `a` zuerst 6 wird
```

## Vergleichsoperatoren

Prüfen, ob zwei Werte in einer bestimmten Beziehung stehen.
Das Ergebnis ist immer ein bool (true oder false).

| Operator | Bedeutung           | Beispiel | Ergebnis |
| -------- | ------------------- | -------- | -------- |
| `==`     | gleich              | `5 == 5` | true     |
| `!=`     | ungleich            | `5 != 3` | true     |
| `<`      | kleiner als         | `3 < 5`  | true     |
| `>`      | größer als          | `7 > 5`  | true     |
| `<=`     | kleiner oder gleich | `5 <= 5` | true     |
| `>=`     | größer oder gleich  | `6 >= 7` | false    |


## Logische Operatoren

Verknüpfen Bedingungen miteinander. Ergebnis ist wieder true oder false.

| Operator | Bedeutung | Beispiel             | Ergebnis |
| -------- | --------- | -------------------- | -------- |
| `&&`     | UND       | `(5 > 3 && 2 < 4)`   | true     |
| `||`     | ODER      | `(5 > 3 || 2 > 4)`   | true     |
| `!`      | NICHT     | `!(5 > 3)`           | false    |


```csharp
int alter = 17;
bool istSchueler = true;

if (alter < 18 && istSchueler)
{
    Console.WriteLine("Schülerrabatt");
}
```

