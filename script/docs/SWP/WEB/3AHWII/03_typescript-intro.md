## Von JavaScript zu TypeScript

Nachdem wir nun JavaScript kennengelernt haben, wollen wir uns einer Sprache widmen, die darauf aufbaut: **TypeScript**.

### Was ist TypeScript?

TypeScript ist eine von Microsoft entwickelte Programmiersprache, die **eine Obermenge von JavaScript** darstellt.  
Das bedeutet: **Jedes gültige JavaScript ist auch gültiges TypeScript** – aber TypeScript bietet zusätzliche Funktionen, insbesondere **statische Typisierung**.

TypeScript wird nicht direkt vom Browser ausgeführt. Stattdessen wird der Code **vorab in JavaScript transpiliert** (übersetzt), damit er überall läuft, wo JavaScript funktioniert.

---

### Vorteile von TypeScript

- **Statische Typprüfung**: Fehler werden bereits beim Kompilieren gefunden, nicht erst zur Laufzeit.
- **Bessere Code-Vervollständigung**: IDEs wie VS Code verstehen durch Typen den Code besser.
- **Klarere Schnittstellen**: Datentypen und Strukturen können explizit festgelegt werden.
- **Große Community**: Weit verbreitet, viele Bibliotheken liefern Typdefinitionen mit.

---

### Nachteile von TypeScript

- **Kompilierung nötig**: TypeScript muss in JavaScript transpiliert werden, bevor es lauffähig ist.
- **Zusätzlicher Lernaufwand**: Typen, Interfaces und generische Programmierung erfordern Einarbeitung.
- **Nicht alle Typen sind strikt**: Durch `any` oder ungenaue Typdefinitionen kann Typsicherheit verloren gehen.
- **Build-Setup**: Erfordert oft zusätzliche Konfiguration (tsconfig, Build-Tools).

### Vergleich: JavaScript vs. TypeScript

=== "JavaScript"

    ```javascript
    // Funktion ohne Typprüfung
    function greet(name) {
        return "Hallo, " + name.toUpperCase();
    }

    console.log(greet("Max"));    // OK
    console.log(greet(42));       // Laufzeitfehler!
    ```

=== "TypeScript"

    ```typescript
    // Funktion mit statischer Typprüfung
    function greet(name: string): string {
        return "Hallo, " + name.toUpperCase();
    }

    console.log(greet("Max"));    // OK
    console.log(greet(42));       // ❌ Fehler: Argument ist keine Zeichenkette
    ```

### Warum TypeScript in modernen Projekten?

Gerade bei größeren Projekten hilft TypeScript, Fehler früh zu erkennen und Code besser zu strukturieren.  
Viele Frameworks wie **Angular**, **NestJS** oder auch **React (mit Hooks)** profitieren stark von den Typinformationen.

!!! note "Merke"  
    - TypeScript ist kein Ersatz für JavaScript, sondern eine Erweiterung.  
    - Wer JavaScript versteht, kann schnell in TypeScript einsteigen.

