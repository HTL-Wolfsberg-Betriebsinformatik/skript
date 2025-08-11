# 📜 JavaScript Fundamentals – Block 1

## 🌍 Was ist JavaScript?

JavaScript (JS) ist eine **Skriptsprache**, die ursprünglich entwickelt wurde, um Webseiten **interaktiv** zu machen.  
Heute wird JavaScript nicht nur im Browser, sondern auch auf Servern (z. B. mit Node.js) und in vielen anderen Umgebungen genutzt.

### 🖥 Einbindung in HTML

=== "Im `<script>`-Tag"

    ```html
    <script>
      console.log("Hallo JavaScript!");
    </script>
    ```

=== "Externe Datei"

    ```html
    <script src="script.js"></script>
    ```

💡 **Tipp:**  
Am besten wird JavaScript in einer **externen Datei** gespeichert und am Ende des `<body>` eingebunden, damit der HTML-Inhalt zuerst geladen wird.

---

## 🗃 Variablen

Variablen speichern Werte, auf die man später zugreifen oder die man ändern kann.

```javascript
let name = "Anna";
const pi = 3.1415;
var alter = 17;
```

# 📜 JavaScript Fundamentals – Block 1

## 🌍 Was ist JavaScript?

JavaScript (JS) ist eine **Skriptsprache**, die ursprünglich entwickelt wurde, um Webseiten **interaktiv** zu machen.  
Heute wird JavaScript nicht nur im Browser, sondern auch auf Servern (z. B. mit Node.js) und in vielen anderen Umgebungen genutzt.

### 🖥 Einbindung in HTML

=== "Im `<script>`-Tag"

    ```html
    <script>
      console.log("Hallo JavaScript!");
    </script>
    ```

=== "Externe Datei"

    ```html
    <script src="script.js"></script>
    ```

💡 **Tipp:**  
Am besten wird JavaScript in einer **externen Datei** gespeichert und am Ende des `<body>` eingebunden, damit der HTML-Inhalt zuerst geladen wird.

---

## Variablen

Variablen speichern Werte, auf die man später zugreifen oder die man ändern kann.

```javascript
let name = "Anna";
const pi = 3.1415;
var alter = 17;
```

| Schlüsselwort | Besonderheit                                |
| ------------- | ------------------------------------------- |
| `let`         | veränderbarer Wert (Blockscope)             |
| `const`       | konstanter Wert (nicht neu zuweisbar)       |
| `var`         | veränderbar, aber veraltet (Funktionsscope) |

## Datentypen

| Typ       | Beispiel                      |
| --------- | ----------------------------- |
| String    | `"Hallo"`                     |
| Number    | `42`                          |
| Boolean   | `true`, `false`               |
| Null      | `null`                        |
| Undefined | `undefined`                   |
| Array     | `["rot", "blau"]`             |
| Object    | `{ name: "Anna", alter: 17 }` |

```javascript
let text = "Hallo";
let zahl = 42;
let aktiv = true;
let farben = ["rot", "blau"];
let person = { name: "Anna", alter: 17 };

console.log(typeof text); // "string"
```

## Operatoren

**Arithmetisch:** `+`, `-`, `*`, `/`, `%`

**Vergleich:** `==`, `!=`, `===`, `!==`, `>`, `<`, `>=`, `<=`

**Logisch:** `&&` (und), `||` (oder), `!` (nicht)

```javascript
let a = 10;
let b = 5;

console.log(a + b); // 15
console.log(a > b); // true
```

## Kontrollstrukturen

### if / else

```javascript
let alter = 17;

if (alter >= 18) {
  console.log("Volljährig");
} else {
  console.log("Minderjährig");
}
```

### switch

```javascript
let tag = "Montag";

switch (tag) {
  case "Montag":
    console.log("Wochenstart");
    break;
  case "Freitag":
    console.log("Fast Wochenende");
    break;
  default:
    console.log("Irgendein Tag");
}
```

## Schleifen

### for

```javascript
for (let i = 1; i <= 5; i++) {
  console.log(i);
}
```

### while

```javascript
let z = 1;
while (z <= 5) {
  console.log(z);
  z++;
}
```

## Funktionen

```javascript
function quadrat(x) {
  return x * x;
}

console.log(quadrat(4)); // 16
```

!!! note
    Parameter: Werte, die an die Funktion übergeben werden.
    Return: Gibt einen Wert zurück.

## Konsolenmethoden

| Methode           | Zweck            |
| ----------------- | ---------------- |
| `console.log()`   | Normale Ausgabe  |
| `console.table()` | Tabelle ausgeben |
| `console.error()` | Fehlermeldung    |

```javascript
let personen = [
  { name: "Anna", alter: 17 },
  { name: "Tom", alter: 18 }
];

console.table(personen);
```