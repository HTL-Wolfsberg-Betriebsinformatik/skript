# Taschenrechner in C#

## Lernziele

- Zerlegen eines Problems in **kleine, wiederverwendbare Funktionen**
- Arbeiten mit **Rückgabewerten** und **Parameterübergabe**
- Nutzung der **Mathematik-Bibliothek** für komplexere Operationen
- Saubere Trennung von **Eingabe**, **Verarbeitung** und **Ausgabe**

---

## Aufgabe

Erstelle einen **Konsolen-Taschenrechner**, bei dem zuerst der **Operator** gewählt wird.  
Anschließend werden die notwendigen Werte vom Benutzer abgefragt und das Ergebnis berechnet.  

Das Programm soll sich in **Funktionen** gliedern, jede Funktion übernimmt genau eine Aufgabe.

---

## Programmablauf

1. Menü anzeigen → Benutzer wählt einen Operator  
2. Benötigte Werte abfragen  
3. Ergebnis berechnen  
4. Ergebnis anzeigen  
5. Zurück zum Menü (so lange, bis der Benutzer „Beenden“ wählt)

---

## Basis-Operatoren
Der Rechner soll mindestens folgende Operatoren unterstützen:

- **Addition**  
- **Subtraktion**  
- **Multiplikation**  
- **Division** (inkl. Fehlerbehandlung bei Division durch 0)  
- **Potenz** (`a^b`)  
- **Quadratwurzel**  
- **n-te Wurzel** (`n√x`)  
- **Fakultät** (nur ganze Zahlen, begrenzter Wertebereich)  
- **ggT** (größter gemeinsamer Teiler)  
- **kgV** (kleinstes gemeinsames Vielfaches)

---

## Erweiterungen
Wähle mindestens zwei zusätzliche Funktionen aus:

- Betrag  
- Runden auf bestimmte Nachkommastellen  
- Logarithmus mit beliebiger Basis  
- Sinus, Cosinus oder Tangens (Grad- oder Bogenmaß)  
- Prozentrechner („x Prozent von y“)  

---

## Fehlerfälle
Dein Programm muss auf typische Fehler reagieren:

- Division durch 0  
- Quadratwurzel von negativen Zahlen  
- Fakultät von negativen oder zu großen Zahlen  
- Logarithmus mit ungültigen Werten  
- n-te Wurzel mit unzulässigem Exponenten  

Das Programm darf **nicht abstürzen**, sondern soll eine **Fehlermeldung** ausgeben und die Eingabe erneut verlangen.

---

## Anforderungen
- Das Programm besteht aus vielen **Funktionen** (keine alles-in-einem-Methode).  
- **Lesbare Namen** für Funktionen und Variablen.  
- Ergebnisse werden **formatiert** mit höchstens 2–4 Nachkommastellen ausgegeben.  
- Benutzerführung erfolgt über ein **Menü**.  
- Das Programm läuft **so lange**, bis der Benutzer „Beenden“ auswählt.

!!! danger "Achtung"
    **Die Berechungsmethoden und das Ein- bzw Auslesen in der Konsole werden getrennt behandelt (also keine Funktion die berechnet und ein- bzw. ausliest)**

---

## Beispiel: Menüführung

```bash
=== Taschenrechner ===
1)  Addition (+)  
2)  Subtraktion (-)  
3)  Multiplikation (*)  
4)  Division (/)  
5)  Potenz (^)  
6)  Quadratwurzel (√)  
7)  n-te Wurzel (n√)  
8)  Fakultät (!)  
9)  Größter gemeinsamer Teiler (gcd)  
10) Kleinstes gemeinsames Vielfaches (lcm)  
11) Betrag (abs)  
12) Runden (round)  
13) Logarithmus (log)  
14) Sinus (sin)  
15) Cosinus (cos)  
16) Tangens (tan)  
17) Prozentrechnung (%)  
18) Winkelmodus wechseln (Grad/Rad)  
0)  Beenden 
```
