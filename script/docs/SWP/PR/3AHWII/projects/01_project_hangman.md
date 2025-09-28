## Lernziele

- Anwenden von **Schleifen**, **Bedingungen** und **Arrays** in einem größeren Projekt  
- Arbeiten mit **Zeichenketten** (`string`) und **Zeichen** (`char`)  
- Spielerisches Üben durch ein **Konsolenspiel**  

---

## Aufgabe

Implementiere das bekannte Spiel **Hangman (Galgenmännchen)**.  
Ein Wort wird vom Computer ausgewählt, der Spieler versucht es durch Eingabe von Buchstaben zu erraten.  
Falsche Versuche werden gezählt, das Spiel endet nach einer bestimmten Anzahl.

---

## Spielregeln

1. Der Computer wählt ein **zufälliges Wort** aus einer Wortliste.  
2. Das Wort wird **verdeckt** angezeigt (z. B. `_ R R A Y`).  
3. Der Spieler gibt **Buchstaben** ein:  
   - Wenn der Buchstabe im Wort vorkommt → er wird aufgedeckt.  
   - Wenn nicht → der Fehlerzähler steigt.  
4. Das Spiel endet, wenn  
   - das Wort erraten wurde (**Sieg**), oder  
   - die maximale Zahl an Fehlern erreicht ist (**Verlust**).  

---

## Startercode

Kopiere folgenden Code in deine `Program.cs`.  
Er enthält die Grundstruktur mit einer **Wortliste** und einem zufälligen Startwort:

```csharp

string[] woerter = {
    "SCHULE","COMPUTER","PROGRAMMIEREN",
    "ALGORITHMUS","SCHLEIFE","ARRAY"
};

Random rnd = new Random();
int index = rnd.Next(0, woerter.Length);
string loesung = woerter[index].ToUpper();

// verdecktes Wort vorbereiten
char[] sichtbar = new char[loesung.Length];
for (int i = 0; i < sichtbar.Length; i++)
{
    sichtbar[i] = '_';
}

// TODO: Spiellogik ergänzen!
```

## Arbeitsschritte

1. Anzeige des Spielfelds
    - Gib das verdeckte Wort (sichtbar) in der Konsole aus.
    - Teste, ob es funktioniert.
2. Eingabe eines Buchstabens
    - Lies einen Buchstaben von der Konsole ein.
    - Achte darauf, Großbuchstaben (ToUpper()) zu verwenden.
3. Prüfen, ob der Buchstabe enthalten ist
    - Durchlaufe das Lösungswort mit einer Schleife.
    - Falls Treffer → in sichtbar eintragen.
    - Falls kein Treffer → Fehlerzähler erhöhen.
4. Wiederholen mit Schleife
    - Solange das Wort nicht erraten und die Fehler < maxFehler sind.
5. Spielende ausgeben
    - Sieg → „Glückwunsch, du hast das Wort erraten!“
    - Niederlage → „Leider verloren, das Wort war …“

## Erweiterungen (optional)

- Liste falscher Buchstaben anzeigen.
- ASCII-Galgen zeichnen (Strichmännchen wächst mit Fehlerzahl).

```csharp
// Fehler = 0
Console.WriteLine(" +---+");
Console.WriteLine(" |   |");
Console.WriteLine("     |");
Console.WriteLine("     |");
Console.WriteLine("     |");
Console.WriteLine("     |");
Console.WriteLine("=========");
```

```csharp
// Fehler = 6
Console.WriteLine(" +---+");
Console.WriteLine(" |   |");
Console.WriteLine(" O   |");
Console.WriteLine("/|\  |");
Console.WriteLine("/ \  |");
Console.WriteLine("     |");
Console.WriteLine("=========");
```




- Mehr Wörter in die Liste aufnehmen.
- Mehrere Runden spielen und Highscore zählen.
