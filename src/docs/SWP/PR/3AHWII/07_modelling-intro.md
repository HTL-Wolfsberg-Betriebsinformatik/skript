# Modellierung in der Softwareentwicklung

## Warum Modellierung?

- **Programmieren = Probleme lösen.**
- Bevor wir Code schreiben, müssen wir das Problem **verstehen** und **strukturieren**.
- **Modelle** helfen uns dabei, komplexe Systeme **einfacher darzustellen** – ähnlich wie Baupläne beim Hausbau.

!!! tip "Merke"
    Ein Modell ist eine vereinfachte Darstellung der Wirklichkeit, damit Menschen und Computer besser damit arbeiten können.

## Arten von Modellen

### Textuelle Modelle

- Beschreibungen in **Pseudocode** oder **Schritt-für-Schritt-Listen**.
- Gut **für einfache Algorithmen**, aber bei komplexeren Problemen **schnell unübersichtlich**.

**Beispiel für Pseudocode: Lineare Suche**

```csharp
ALGORITHM LineareSuche(Liste, Ziel)

    FÜR i VON 0 BIS Länge(Liste)-1
        WENN Liste[i] == Ziel
            GIB "Gefunden an Position i" ZURÜCK
        ENDE WENN
    ENDE FÜR

    GIB "Nicht gefunden" ZURÜCK

ENDE ALGORITHM
```

**Beispiel für Schritt-für-Schritt Listen: Lineare Suche**

```
1. Starte beim ersten Element der Liste.
2. Vergleiche jedes Element mit dem gesuchten Wert (Ziel).
3. Wenn gleich → Erfolg, gib die Position zurück.
4. Wenn Ende der Liste erreicht und nichts gefunden → „Nicht gefunden“.
```

**Umsetzung in C#**

```csharp
using System;

class Program
{
    static int LineareSuche(int[] liste, int ziel)
    {
        for (int i = 0; i < liste.Length; i++)
        {
            if (liste[i] == ziel)
                return i; // Index zurückgeben
        }
        return -1; // -1 = nicht gefunden
    }

    static void Main()
    {
        int[] zahlen = { 3, 7, 5, 9, 2 };

        int gesucht = 9;
        int pos = LineareSuche(zahlen, gesucht);

        if (pos != -1)
            Console.WriteLine($"{gesucht} gefunden an Position {pos}.");
        else
            Console.WriteLine($"{gesucht} nicht gefunden.");
    }
}
```

Ausgabe:
```bash
9 gefunden an Position 3.
```

### Grafische Modelle

- Probleme und Systeme werden **visuell** dargestellt.
- Bessere Übersicht, leichter für Teams zu verstehen.
- Standardisierte Symbole und Regeln → **Modellierungssprache**.



## Überblick Modellierungssprachen

- **UML (Unified Modeling Language)**: Standard in der Softwaretechnik.
    Wichtige Diagramme:
    - **Klassendiagramme** (Struktur: Klassen, Attribute, Methoden, Beziehungen)
    - **Use-Case-Diagramme** (Funktionen aus Sicht des Anwenders)
    - **Aktivitätsdiagramme** (Abläufe/Prozesse, ähnlich Flussdiagrammen)
    - **Sequenzdiagramme** (Kommunikation zwischen Objekten im Zeitverlauf)
- **ER-Diagramme** (Entity-Relationship)
    Speziell für Datenbanken → Tabellen, Spalten, Beziehungen.
- **Flowcharts** (Flussdiagramme)
    Für einfache Algorithmen → Rechtecke (Aktionen), Rauten (Entscheidungen).
