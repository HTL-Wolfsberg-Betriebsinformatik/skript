## Einführung

- Ein Interface ist ein **Vertrag**: Es sagt, welche Methoden oder Eigenschaften eine Klasse **bereitstellen muss**.
- Ein Interface hat keine Implementierung (ab C# 8 kann man *default implementations* machen, aber das ist fortgeschritten).
- Eine Klasse kann mehrere Interfaces implementieren = Mehrfachvererbung von Verhalten (nicht von Code).

!!! tip "Merke"
    Ein Interface ist wie ein „Steckdosen-Standard“: Wer den Stecker passend baut, passt in die Dose – egal welches Gerät dahintersteckt.


## Syntax

```csharp
interface IFahrbar
{
    void Bewege(int km);
}
```

- statt `class` wird das Schlüsselwort `interface` benutzt
- Methoden sind **immer public** (kein Access Modifier nötig)
- keien Logik, nur Signaturen


## Interface implementieren

```csharp
class Auto : IFahrbar
{
    public void Bewege(int km)
    {
        Console.WriteLine($"Auto fährt {km} km.");
    }
}

class Fahrrad : IFahrbar
{
    public void Bewege(int km)
    {
        Console.WriteLine($"Fahrrad rollt {km} km.");
    }
}
```

## Nutzung - Polymorphie über Interface

```csharp
class Program
{
    static void Main()
    {
        List<IFahrbar> flotte = new List<IFahrbar>
        {
            new Auto(),
            new Fahrrad()
        };

        foreach (var f in flotte)
        {
            f.Bewege(10); // gleicher Aufruf, unterschiedliches Verhalten
        }
    }
}
```

Ausgabe:

```bash
Auto fährt 10 km.
Fahrrad rollt 10 km.
```

## Unterschied Interfaces und abstrakte Klasse

| Abstrakte Klasse                                   | Interface                             |
| -------------------------------------------------- | ------------------------------------- |
| Kann Felder + Logik + abstrakte Methoden enthalten | Nur Methodensignaturen (kein Zustand) |
| Nur **eine** Basisklasse erlaubt                   | Beliebig viele Interfaces möglich     |
| „Was ist es?“ (is-a)                               | „Was kann es?“ (can-do)               |


!!! tip "Tipp"
    - Abstrakte Klasse = wenn gemeinsame Daten + Verhalten geteilt werden sollen
    - Interface = wenn nur ein Vertrag („kann etwas tun“) gefordert wird


## Beispiel: Interfaces für Zahlungsschnittstelle

- Stell dir vor, wir entwickeln ein Online-Shop-Programm.
- Wir wollen verschiedene Zahlungsmethoden (Kreditkarte, PayPal, Gutschein).
- Damit der Shop egal welche Methode nutzen kann, brauchen wir einen gemeinsamen Vertrag.

```csharp
interface IZahlungsmethode
{
    bool Zahle(double betrag);
}
```

!!! info "Info"
    Jede Zahlungsmethode muss die Funktion Zahle(betrag) haben.
    Ob sie das mit Kreditkarte, PayPal oder Gutscheinen macht, ist egal – Hauptsache die Methode existiert.

**Verschiedene Implementierungen:**

```csharp
class Kreditkarte : IZahlungsmethode
{
    public bool Zahle(double betrag)
    {
        Console.WriteLine($"Kreditkarte belastet mit {betrag} €.");
        return true;
    }
}

class PayPal : IZahlungsmethode
{
    public bool Zahle(double betrag)
    {
        Console.WriteLine($"PayPal überweist {betrag} €.");
        return true;
    }
}

class Gutschein : IZahlungsmethode
{
    public bool Zahle(double betrag)
    {
        Console.WriteLine($"Gutschein in Höhe von {betrag} € eingelöst.");
        return true;
    }
}
```

**Nutzung im Shop:**

```csharp
class Shop
{
    public void KaufeArtikel(double preis, IZahlungsmethode methode)
    {
        if (methode.Zahle(preis))
            Console.WriteLine("Kauf erfolgreich!");
        else
            Console.WriteLine("Zahlung fehlgeschlagen!");
    }
}

class Program
{
    static void Main()
    {
        var shop = new Shop();

        shop.KaufeArtikel(49.99, new Kreditkarte());
        shop.KaufeArtikel(19.99, new PayPal());
        shop.KaufeArtikel(10.00, new Gutschein());
    }
}
```

Ausgabe
```bash
Kreditkarte belastet mit 49,99 €.
Kauf erfolgreich!
PayPal überweist 19,99 €.
Kauf erfolgreich!
Gutschein in Höhe von 10 € eingelöst.
Kauf erfolgreich!
```

**Erklärung:**

- **API = Vertrag:** Der Shop „verlangt“ nur: „Es muss ein Zahle(betrag) geben“.
- **Implementierungen:** Jede Zahlungsmethode entscheidet selbst, wie gezahlt wird.
- **Erweiterbarkeit:** Neue Zahlungsmethoden (z. B. KryptoWährung) können jederzeit hinzugefügt werden, ohne den Shop-Code ändern zu müssen.
