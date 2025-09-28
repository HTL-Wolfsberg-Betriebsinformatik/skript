# TicTacToe in C#

## Lernziele

- Anwenden von **Schleifen**, **Bedingungen**, **Methoden** und **mehrdimensionalen Arrays (`[,]`)**
- Arbeiten mit **Konsolein-/ausgabe** und **Eingabevalidierung**
- Erkennen und Prüfen von **Gewinnbedingungen** (Zeilen, Spalten, Diagonalen)

---

## Aufgabe

Implementiere das Spiel **Tic-Tac-Toe** (3×3).  
Zwei Spieler (X und O) setzen abwechselnd, bis **Sieg** oder **Unentschieden** erreicht ist.

---

## Spielregeln

1. Gespielt wird auf einem **3×3-Feld**.
2. Spieler **X** beginnt, dann **O**, abwechselnd.
3. Ein Feld darf **nur einmal** belegt werden.
4. **Sieg**, wenn ein Spieler **3 in einer Reihe** hat (Zeile, Spalte oder Diagonale).
5. **Unentschieden**, wenn alle 9 Felder belegt sind und niemand gewonnen hat.

---

## Startercode

Kopiere den Code nach `Program.cs` in ein leeres **Console App** Projekt (.NET 6/7/8/9).  
Der Code ist **sofort lauffähig** und enthält markierte Stellen zum Weitermachen.

```csharp
using System;

class Program
{
    static void Main()
    {
        // TODO: Spielfeld als 3x3 Array (vom Typ char)

        // TODO: Board initialisieren (alle Felder leer machen)

        char currentPlayer = 'X';
        bool running = true;

        while (running)
        {
            Console.Clear();

            // TODO: Spielfeld anzeigen

            Console.WriteLine($"Spieler {currentPlayer} ist am Zug.");
            if (!ReadMove(out int r, out int c))
            {
                Console.WriteLine("Ungültige Eingabe. Weiter mit Taste...");
                Console.ReadKey();
                continue;
            }

            // TODO: Eingabe in Zeile/Spalte umwandeln

            // TODO: prüfen ob Feld frei → setzen

            // TODO: Gewinn prüfen

            // TODO: Unentschieden prüfen

            // Spieler wechseln
            currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }

        Console.WriteLine("Spiel beendet.");
    }

    static bool ReadMove(out int row, out int col)
    {
        Console.Write("Gib Zeile (1-3) und Spalte (1-3) ein, z.B. \"2 3\": ");
        var line = Console.ReadLine();
        row = col = -1;
        if (string.IsNullOrWhiteSpace(line)) return false;

        var parts = line.Trim().Split(new[] { ' ', ';', ',', '\t' }, StringSplitOptions.RemoveEmptyEntries);
        if (parts.Length != 2) return false;
        if (!int.TryParse(parts[0], out row)) return false;
        if (!int.TryParse(parts[1], out col)) return false;

        if (row < 1 || row > 3 || col < 1 || col > 3) return false;
        return true;
    }
}
```