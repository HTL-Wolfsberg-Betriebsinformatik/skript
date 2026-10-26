# Foliensatz „Datenbanken in C#: vom DataReader zu EF Core“ – Struktur für Slidev

> **Für Claude Code:** Diese Datei beschreibt Aufbau, Inhalt und Code aller Folien. Setze sie als Slidev-Präsentation um. Die Code-Snippets sind fachlich abgestimmt: Übernimm sie unverändert, kürze höchstens Kommentare. Erfinde keine neuen Inhalte. Wo etwas zu prüfen ist, steht **[PRÜFEN]**.

---

## 1. Rahmen

| | |
|---|---|
| Zielgruppe | 5. Jahrgang HTL, Schwerpunkt Betriebsinformatik, Fach Softwareentwicklung |
| Vorwissen | SQL-Abfragen (SELECT, JOIN, GROUP BY, INSERT/UPDATE/DELETE), strukturierte Programmierung, OOP in C# (Klassen, Eigenschaften, Interfaces, `List<T>`) |
| Neu für die Klasse | ADO.NET, Parameter, Transaktionen in C#, async/await im Datenzugriff, Lambdas/LINQ, ORM, EF Core |
| Technik | .NET 10, C# 14, SQL Server (LocalDB), `Microsoft.Data.SqlClient`, EF Core 10 |
| Sprache | Deutsch (österreichisch: „Jänner“, „Lagerstand“). Code-Bezeichner deutsch, ohne Umlaute |
| Umfang | 86 Folien (inkl. Abschnittsfolien), gedacht für 10 bis 13 Unterrichtseinheiten zu 50 Minuten, aufgeteilt auf 4 Teile |

**Durchgehendes Beispiel: OnlineShop** mit Kunde, Artikel, Bestellung und Bestellposition. Jede Folie mit Code verwendet dieses Modell, es kommen keine anderen Beispieldomänen vor.

**Didaktische Linie**
1. **Teil A:** Die Schüler schreiben den Datenzugriff von Hand. Jeder Schritt bringt genau eine neue Idee, geordnet nach dem Ergebnistyp: ein Wert, dann Anzahl betroffener Zeilen, dann Tabelle.
2. **Teil A, Schluss:** Sie spüren den Schmerz: viel wiederholter Code, Mapping von Hand, SQL in Strings.
3. **Teil B:** Ein ORM als Antwort darauf, mit ehrlichen Vor- und Nachteilen.
4. **Teil C:** LINQ, zuerst auf Listen im Speicher, wo es einfach ist.
5. **Teil D:** EF Core. Immer wieder wird das erzeugte SQL gezeigt, damit EF Core keine Blackbox wird und an das SQL-Vorwissen anschließt.

Das Thema „verbindungslos“ (DataSet, DataTable, DataAdapter) kommt bewusst **nicht** vor.

---

## 2. Technische Vorgaben für Slidev

- **Dateistruktur:** Ein Foliensatz `22_database_integration.md` Titel. Behalte das Design wie in den anderen Slides.
- **Abschnittsfolien:** `layout: section`
- **Vergleiche** (vorher/nachher, SQL/C#): `layout: two-cols` mit `::right::`
- **Code schrittweise aufdecken:** Zeilenmarkierungen mit Klicks, z. B. ```` ```csharp {1-2|4|5-6|all} ````
- **Code-Entwicklung über mehrere Stände:** Shiki Magic Move (```` ````md magic-move ````). In dieser Datei steht dann „Magic Move: Stand 1 → Stand 2“, und die Stände folgen als einzelne Codeblöcke.
- **Aufzählungen schrittweise:** `<v-clicks>`
- **Diagramme:** Mermaid (` ```mermaid `), unterstützt Slidev nativ
- **Sprechernotizen:** als HTML-Kommentar `<!-- ... -->` am Ende jeder Folie. Der Text unter „Notizen“ gehört dorthin, nicht auf die Folie.
- **Code-Regeln:**
  - Höchstens ca. 18 Zeilen pro Block. Bei längeren Blöcken entweder Zeilenmarkierung verwenden oder auf zwei Folien teilen.
  - Schriftgröße notfalls mit `<style>` auf der Folie verkleinern, niemals den Code kürzen.
- **Wiederkehrende Kästen:**
  - „⚠️ Häufiger Fehler“ in Rot
  - „💡 Merke“ in Grün
  - „🔁 Kennst du aus SQL“, eine Brücke zum Vorwissen, in Blau

  Als kleine Vue-Komponenten umsetzen, z. B. `components/Merke.vue`, `Achtung.vue`, `SqlBruecke.vue`.

---

## 3. Das Beispiel: Datenbank OnlineShop

Dieses Skript gehört als Anhang in den Foliensatz und zusätzlich als `setup.sql` in den Projektordner.

```sql
CREATE DATABASE OnlineShop;
GO
USE OnlineShop;
GO
CREATE TABLE Kunde (
    Id        INT IDENTITY PRIMARY KEY,
    Vorname   NVARCHAR(50)  NOT NULL,
    Nachname  NVARCHAR(50)  NOT NULL,
    Email     NVARCHAR(100) NULL,
    Ort       NVARCHAR(50)  NOT NULL
);
CREATE TABLE Artikel (
    Id          INT IDENTITY PRIMARY KEY,
    Bezeichnung NVARCHAR(100) NOT NULL,
    Preis       DECIMAL(10,2) NOT NULL,
    Lagerstand  INT NOT NULL DEFAULT 0
);
CREATE TABLE Bestellung (
    Id       INT IDENTITY PRIMARY KEY,
    KundeId  INT NOT NULL REFERENCES Kunde(Id),
    Datum    DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
CREATE TABLE Bestellposition (
    Id            INT IDENTITY PRIMARY KEY,
    BestellungId  INT NOT NULL REFERENCES Bestellung(Id),
    ArtikelId     INT NOT NULL REFERENCES Artikel(Id),
    Menge         INT NOT NULL CHECK (Menge > 0),
    Einzelpreis   DECIMAL(10,2) NOT NULL
);

INSERT INTO Kunde (Vorname, Nachname, Email, Ort) VALUES
 ('Anna','Berger','anna.berger@example.at','Wolfsberg'),
 ('Lukas','Pichler',NULL,'Wolfsberg'),
 ('Sophie','Wallner','s.wallner@example.at','St. Andrä'),
 ('Tobias','Krenn','tobias.krenn@example.at','Klagenfurt'),
 ('Lena','Fuchs','lena.fuchs@example.at','Villach');

INSERT INTO Artikel (Bezeichnung, Preis, Lagerstand) VALUES
 ('USB-Stick 64 GB', 12.90, 50),
 ('Funkmaus', 24.90, 30),
 ('Mechanische Tastatur', 89.00, 12),
 ('27-Zoll-Monitor', 229.00, 5),
 ('HDMI-Kabel 2 m', 7.50, 100),
 ('Webcam Full HD', 49.90, 0);

INSERT INTO Bestellung (KundeId, Datum) VALUES
 (1,'2026-09-14'), (1,'2026-10-02'), (3,'2026-10-05'), (4,'2026-10-06');

INSERT INTO Bestellposition (BestellungId, ArtikelId, Menge, Einzelpreis) VALUES
 (1,1,2,12.90), (1,5,1,7.50),
 (2,4,1,229.00), (2,2,1,24.90),
 (3,3,1,89.00),
 (4,1,5,12.90), (4,5,3,7.50);
```

**Connection-String** für alle Folien in Teil A:

```text
Server=(localdb)\MSSQLLocalDB;Database=OnlineShop;Integrated Security=true;TrustServerCertificate=true
```

**C#-Modellklassen in Teil A** (in Teil D kommen Navigationseigenschaften dazu):

```csharp
public class Kunde
{
    public int Id { get; set; }
    public string Vorname { get; set; } = "";
    public string Nachname { get; set; } = "";
    public string? Email { get; set; }
    public string Ort { get; set; } = "";
}

public class Artikel
{
    public int Id { get; set; }
    public string Bezeichnung { get; set; } = "";
    public decimal Preis { get; set; }
    public int Lagerstand { get; set; }
}
```

---

## 4. Folien

### Folie 0.1 – Titel
- **Layout:** `cover`
- **Titel:** Datenbanken in C#
- **Untertitel:** Vom DataReader zu EF Core · am Beispiel OnlineShop
- **Fußzeile:** Softwareentwicklung · 5. Jahrgang · HTL Wolfsberg

### Folie 0.2 – Worum geht's?
- **Inhalt:** Eine Gegenüberstellung in zwei Spalten.
  - **Links: „Das könnt ihr schon“**
    - SQL im Management Studio (Screenshot-Platzhalter: Ergebnis von `SELECT * FROM Artikel`)
    - Klassen und Objekte in C# (`List<Artikel>`)
  - **Rechts: „Das fehlt noch“**
    - ein großes Fragezeichen zwischen beiden, darunter: „Wie kommt die Zeile aus der Tabelle in ein Objekt, und wieder zurück?“
- **Notizen:** Mit dieser Lücke steigen wir ein. Jede Technik in diesem Foliensatz ist eine Antwort auf genau diese Frage.

### Folie 0.3 – Fahrplan
- **Inhalt:** vier Etappen als horizontale Zeitleiste oder Mermaid-Flowchart (LR):
  1. **A** Datenzugriff von Hand: Connection, Command, DataReader
  2. **B** Was ist ein ORM?
  3. **C** LINQ
  4. **D** Entity Framework Core
- **Notizen:** Teil A ist die Grundlage. EF Core verwendet intern genau das, was wir in Teil A lernen.

### Folie 0.4 – Unser OnlineShop
- **Inhalt:** Mermaid-ER-Diagramm:
  ```mermaid
  erDiagram
      Kunde ||--o{ Bestellung : "gibt auf"
      Bestellung ||--|{ Bestellposition : enthaelt
      Artikel ||--o{ Bestellposition : "kommt vor in"
      Kunde {
          int Id PK
          nvarchar Vorname
          nvarchar Nachname
          nvarchar Email "NULL erlaubt"
          nvarchar Ort
      }
      Artikel {
          int Id PK
          nvarchar Bezeichnung
          decimal Preis
          int Lagerstand
      }
      Bestellung {
          int Id PK
          int KundeId FK
          datetime2 Datum
      }
      Bestellposition {
          int Id PK
          int BestellungId FK
          int ArtikelId FK
          int Menge
          decimal Einzelpreis
      }
  ```
- **Notizen:**
  - Das Skript `setup.sql` liegt im Projektordner.
  - Warum hat die Bestellposition einen eigenen Einzelpreis? Weil sich der Artikelpreis später ändern kann. Die Rechnung muss aber den Preis zum Bestellzeitpunkt zeigen. Gute Frage an die Klasse.

---

## Teil A – Datenzugriff von Hand (ca. 4–5 EH)

Datei: `pages/a-ado-net.md`

### Folie A.0 – Abschnitt
- **Layout:** `section`
- **Titel:** Teil A · Datenzugriff von Hand
- **Untertitel:** Connection · Command · DataReader

### Folie A.1 – ADO.NET im Überblick
- **Inhalt:** Mermaid-Flowchart (LR):
  ```mermaid
  flowchart LR
      App["Deine C#-Anwendung"] --> Con["SqlConnection<br/>Leitung zur DB"]
      Con --> Cmd["SqlCommand<br/>SQL + Parameter"]
      Cmd --> DB[("SQL Server<br/>OnlineShop")]
      DB --> R["SqlDataReader<br/>Ergebnis Zeile für Zeile"]
      R --> App
  ```
- Darunter drei Merkzeilen (`<v-clicks>`):
  - **Connection:** die Leitung zur Datenbank
  - **Command:** der Auftrag, also SQL plus Parameter
  - **DataReader:** liest das Ergebnis, eine Zeile nach der anderen
- **Notizen:**
  - Analogie Telefonat: Verbindung aufbauen, Frage stellen, Antwort anhören, auflegen.
  - ADO.NET ist der Name der Klassenbibliothek. Diese Klassen sind keine Steuerelemente.

### Folie A.2 – Projekt vorbereiten
- **Inhalt:**
  ```bash
  dotnet new console -n OnlineShop
  cd OnlineShop
  dotnet add package Microsoft.Data.SqlClient
  ```
  ```csharp
  using System.Data;               // SqlDbType
  using Microsoft.Data.SqlClient;  // SqlConnection, SqlCommand, …
  ```
- **Kasten „⚠️ Häufiger Fehler“:** `System.Data.SqlClient` ist veraltet. Immer `Microsoft.Data.SqlClient` von NuGet verwenden. In alten Tutorials steht meist noch der alte Namespace.
- **Notizen:** In Visual Studio geht es auch über „NuGet-Pakete verwalten“.

### Folie A.3 – Der Connection-String
- **Inhalt:** Der Connection-String groß dargestellt. Die vier Teile werden per Klick nacheinander farbig markiert und erklärt:
  ```text
  Server=(localdb)\MSSQLLocalDB;Database=OnlineShop;Integrated Security=true;TrustServerCertificate=true
  ```
  | Teil | Bedeutung |
  |---|---|
  | `Server=(localdb)\MSSQLLocalDB` | Welcher SQL Server? Hier LocalDB, alternativ `.\SQLEXPRESS` |
  | `Database=OnlineShop` | Welche Datenbank auf diesem Server? |
  | `Integrated Security=true` | Anmeldung mit dem Windows-Benutzer, kein Passwort im Code |
  | `TrustServerCertificate=true` | Die Verbindung ist standardmäßig verschlüsselt. Bei lokalen Servern ohne Zertifikat braucht man diese Angabe. |
- **Kasten „💡 Merke“:** Connection-Strings gehören in eine Konfigurationsdatei (`appsettings.json`), nicht in den Code. Für den Anfang reicht eine Konstante.
- **Notizen:** Ohne `TrustServerCertificate=true` kommt die Fehlermeldung „The certificate chain was issued by an authority that is not trusted“. Das ist der häufigste Fehler beim ersten Start.

### Folie A.4 – Verbindung öffnen und schließen
- **Inhalt:**
  ```csharp {1|3|4|5-6|all}
  const string ConnStr = "Server=(localdb)\\MSSQLLocalDB;Database=OnlineShop;Integrated Security=true;TrustServerCertificate=true";

  using var con = new SqlConnection(ConnStr);
  con.Open();
  Console.WriteLine($"Status: {con.State}");   // Open
  // … hier arbeiten …
  // Ende des Blocks: using schließt die Verbindung automatisch
  ```
- **Kasten „💡 Merke“:** Spät öffnen, früh schließen. Das Connection-Pooling sorgt dafür, dass erneutes Öffnen billig ist.
- **Notizen:**
  - `using` ruft am Ende `Dispose()` auf, auch bei einer Exception. Das ist die moderne Kurzform von `try`/`finally`.
  - Der Pool hält physische Verbindungen offen und vergibt sie wieder. Eine Verbindung „offen lassen“ bringt daher nichts und blockiert nur den Pool.

### Folie A.5 – Drei Arten zu fragen
- **Inhalt:** Tabelle (Kernfolie für Teil A, später darauf zurückverweisen):

  | Methode | Liefert | Typisches SQL | Beispiel im Shop |
  |---|---|---|---|
  | `ExecuteScalar()` | **einen** Wert (`object?`) | `SELECT COUNT(*)`, `SUM(…)` | Wie viele Artikel gibt es? |
  | `ExecuteNonQuery()` | Anzahl betroffener Zeilen (`int`) | `INSERT`, `UPDATE`, `DELETE` | Neuen Artikel anlegen |
  | `ExecuteReader()` | einen `SqlDataReader` (Tabelle) | `SELECT …` mit mehreren Zeilen/Spalten | Alle Artikel anzeigen |
- **Notizen:** Wir gehen genau in dieser Reihenfolge vor, vom einfachsten Ergebnis zum komplexesten.

### Folie A.6 – Schritt 1: ExecuteScalar
- **Titel:** Schritt 1 · Ein einzelner Wert
- **Inhalt:**
  ```csharp {1-2|4|5|6|all}
  using var con = new SqlConnection(ConnStr);
  con.Open();

  using var cmd = new SqlCommand("SELECT COUNT(*) FROM Artikel", con);
  int anzahl = (int)cmd.ExecuteScalar()!;
  Console.WriteLine($"Im Shop gibt es {anzahl} Artikel.");
  ```
- **Kasten „🔁 Kennst du aus SQL“:** Dasselbe SELECT, das du im Management Studio schreibst. Neu ist nur, dass es als String im C#-Code steht.
- **Notizen:**
  - `ExecuteScalar` liefert die erste Spalte der ersten Zeile als `object?`, daher der Cast.
  - `COUNT(*)` liefert in SQL Server `int`, also passt `(int)`.

### Folie A.7 – ExecuteScalar und NULL
- **Inhalt:** Lagerwert aller Artikel einer Preisklasse:
  ```csharp {1-2|3|4|all}
  using var cmd = new SqlCommand(
      "SELECT SUM(Preis * Lagerstand) FROM Artikel WHERE Preis > 1000", con);
  object? ergebnis = cmd.ExecuteScalar();
  decimal lagerwert = ergebnis is DBNull ? 0 : (decimal)ergebnis!;
  ```
- **Kasten „⚠️ Häufiger Fehler“:** `SUM` über keine Zeilen ergibt in SQL `NULL`. In C# kommt dann `DBNull.Value` an, nicht `null`. Ein direkter Cast `(decimal)` wirft eine `InvalidCastException`.
- **Notizen:** `DBNull` ist ein eigener Typ für „NULL aus der Datenbank“. Diese Unterscheidung kommt beim DataReader wieder.

### Folie A.8 – Schritt 2: ExecuteNonQuery
- **Titel:** Schritt 2 · Daten ändern
- **Inhalt:**
  ```csharp {1-3|4|all}
  using var cmd = new SqlCommand(
      "INSERT INTO Artikel (Bezeichnung, Preis, Lagerstand) " +
      "VALUES ('Laptop-Ständer', 34.90, 20)", con);
  int betroffen = cmd.ExecuteNonQuery();
  Console.WriteLine($"{betroffen} Zeile(n) eingefügt.");   // 1
  ```
- Darunter per Klick die Frage, groß: **„Und wenn der Benutzer die Werte eingibt?“**
- **Notizen:** `ExecuteNonQuery` liefert keine Daten, nur die Anzahl der betroffenen Zeilen. Diese Zahl ist bei UPDATE und DELETE wichtig: 0 bedeutet „nicht gefunden“.

### Folie A.9 – Der naheliegende Weg
- **Inhalt:** Eingaben per String-Verkettung einbauen:
  ```csharp
  Console.Write("Bezeichnung: ");
  string bez = Console.ReadLine()!;
  Console.Write("Preis: ");
  decimal preis = decimal.Parse(Console.ReadLine()!);

  string sql = "INSERT INTO Artikel (Bezeichnung, Preis, Lagerstand) " +
               "VALUES ('" + bez + "', " + preis + ", 0)";
  using var cmd = new SqlCommand(sql, con);
  cmd.ExecuteNonQuery();
  ```
- **Klicks:** Nacheinander drei Probleme einblenden:
  1. Eingabe `12,90`, und auf einem deutschsprachigen Windows entsteht `VALUES ('Maus', 12,90, 0)`. Das sind 4 Werte für 3 Spalten, also ein SQL-Fehler.
  2. Eingabe `Kinder's Maus`: Das Apostroph beendet den String, und es entsteht ein Syntaxfehler.
  3. Es geht noch schlimmer, siehe nächste Folie.
- **Notizen:** Diesen Code bewusst live schreiben und mit den Eingaben scheitern lassen. Das Kulturproblem beim Dezimalkomma überrascht fast alle.

### Folie A.10 – SQL-Injection
- **Layout:** `two-cols`
- **Links:** Kundensuche per Verkettung:
  ```csharp
  string name = Console.ReadLine()!;
  string sql = "SELECT Id, Vorname, Nachname FROM Kunde " +
               "WHERE Nachname = '" + name + "'";
  ```
- **Rechts:** Eingaben und das daraus entstehende SQL (`<v-clicks>`):
  - Eingabe `Berger` ergibt `… WHERE Nachname = 'Berger'`. Das funktioniert wie gewünscht.
  - Eingabe `x' OR '1'='1` ergibt `… WHERE Nachname = 'x' OR '1'='1'`. Damit erscheinen **alle Kunden**.
  - Eingabe `x'; DELETE FROM Bestellposition; --` führt **zwei Befehle** aus, und die Bestellpositionen sind gelöscht.
- **Kasten „⚠️“:** SQL-Injection gehört seit Jahren zu den häufigsten Sicherheitslücken in Webanwendungen (OWASP Top 10).
- **Notizen:**
  - Live vorführen, aber nur auf der Testdatenbank.
  - Danach mit `setup.sql` neu aufsetzen.
  - Optional den xkcd-Comic „Exploits of a Mom“ (Little Bobby Tables) verlinken. Nur verlinken, nicht als Bild einbetten: https://xkcd.com/327/

### Folie A.11 – Die Lösung: Parameter
- **Inhalt:** Magic Move von der Verkettung zu Parametern.
  - Stand 1:
    ```csharp
    string sql = "SELECT Id, Vorname, Nachname FROM Kunde " +
                 "WHERE Nachname = '" + name + "'";
    using var cmd = new SqlCommand(sql, con);
    ```
  - Stand 2:
    ```csharp
    string sql = "SELECT Id, Vorname, Nachname FROM Kunde " +
                 "WHERE Nachname = @nachname";
    using var cmd = new SqlCommand(sql, con);
    cmd.Parameters.Add("@nachname", SqlDbType.NVarChar, 50).Value = name;
    ```
- Darunter (`<v-clicks>`):
  - Das SQL enthält nur noch einen **Platzhalter** `@nachname`.
  - Der Wert wird **getrennt** vom SQL an den Server geschickt. Er wird nie als SQL-Code ausgeführt.
  - Typ und Länge entsprechen der Spalte (`NVARCHAR(50)`).
- **Kasten „💡 Merke“:** Benutzereingaben kommen **nie** per `+` ins SQL, ausnahmslos.

### Folie A.12 – Parameter im Detail
- **Inhalt:** Der INSERT aus A.9, jetzt richtig:
  ```csharp {1-3|4|5|6|7}
  using var cmd = new SqlCommand(
      "INSERT INTO Artikel (Bezeichnung, Preis, Lagerstand) " +
      "VALUES (@bez, @preis, @lager)", con);
  cmd.Parameters.Add("@bez", SqlDbType.NVarChar, 100).Value = bez;
  cmd.Parameters.Add("@preis", SqlDbType.Decimal).Value = preis;
  cmd.Parameters.Add("@lager", SqlDbType.Int).Value = 0;
  cmd.ExecuteNonQuery();
  ```
- Darunter eine Gegenüberstellung in zwei kurzen Spalten:
  - **`Parameters.Add(name, typ, länge)`:** Typ genau wie in der Tabelle, so empfohlen.
  - **`Parameters.AddWithValue(name, wert)`:** Der Typ wird erraten. Das funktioniert, kann aber zu falschen Typen und langsameren Abfragen führen. In alten Tutorials sehr häufig.
- **Notizen:**
  - Dezimalkomma und Apostroph sind mit Parametern automatisch kein Problem mehr. Die Probleme aus A.9 noch einmal durchspielen.
  - Hintergrund zu AddWithValue: Ein `string` wird z. B. als `nvarchar` mit der Länge des aktuellen Werts gesendet. Das erzeugt viele verschiedene Abfragepläne, und bei `varchar`-Spalten nutzt SQL Server unter Umständen den Index nicht.

### Folie A.13 – NULL-Werte als Parameter
- **Inhalt:**
  ```csharp
  // kunde.Email ist string? – kann null sein
  cmd.Parameters.Add("@email", SqlDbType.NVarChar, 100).Value =
      (object?)kunde.Email ?? DBNull.Value;
  ```
- **Kasten „⚠️ Häufiger Fehler“:** C#-`null` als Parameterwert bedeutet für SqlClient „Parameter fehlt“ und führt zu einem Fehler. Für SQL-NULL braucht man `DBNull.Value`.
- **Notizen:** Das ist das Gegenstück zu Folie A.7. In beide Richtungen gilt: `null` in C# ist nicht dasselbe wie `NULL` in der Datenbank.

### Folie A.14 – Die neue Id zurückbekommen
- **Inhalt:**
  ```csharp {2-3|5-7|8}
  using var cmd = new SqlCommand("""
      INSERT INTO Artikel (Bezeichnung, Preis, Lagerstand)
      OUTPUT INSERTED.Id
      VALUES (@bez, @preis, @lager)
      """, con);
  cmd.Parameters.Add("@bez", SqlDbType.NVarChar, 100).Value = artikel.Bezeichnung;
  cmd.Parameters.Add("@preis", SqlDbType.Decimal).Value = artikel.Preis;
  cmd.Parameters.Add("@lager", SqlDbType.Int).Value = artikel.Lagerstand;
  artikel.Id = (int)cmd.ExecuteScalar()!;
  ```
- **Kasten „🔁 Kennst du aus SQL“:** `OUTPUT INSERTED.Id` liefert die von `IDENTITY` vergebene Id. Weil das genau ein Wert ist, verwenden wir `ExecuteScalar`.
- **Notizen:** `"""…"""` ist ein Raw-String-Literal (ab C# 11). Damit lässt sich mehrzeiliges SQL gut lesbar schreiben.

### Folie A.15 – Schritt 3: ExecuteReader
- **Titel:** Schritt 3 · Eine ganze Tabelle lesen
- **Inhalt:**
  ```csharp {1-2|4|5|7-9|10|all}
  using var cmd = new SqlCommand(
      "SELECT Id, Bezeichnung, Preis, Lagerstand FROM Artikel ORDER BY Bezeichnung", con);

  using SqlDataReader reader = cmd.ExecuteReader();
  while (reader.Read())
  {
      int id = reader.GetInt32(0);
      string bez = reader.GetString(1);
      decimal preis = reader.GetDecimal(2);
      Console.WriteLine($"{id,3}  {bez,-25} {preis,10:C}");
  }
  ```
- **Notizen:**
  - `Read()` springt zur nächsten Zeile und liefert `false`, wenn keine mehr da ist.
  - Vor dem ersten `Read()` steht der Reader **vor** der ersten Zeile.
  - Die Zahl in `GetInt32(0)` ist die Spaltenposition im SELECT.

### Folie A.16 – So arbeitet der DataReader
- **Inhalt:** Eine Grafik (Tabelle mit 4 Zeilen und einem Pfeil als Cursor), bei der jeder Klick den Pfeil eine Zeile weiter bewegt. Als einfache HTML-Tabelle mit `v-click`-Hervorhebung umsetzen:

  | | Id | Bezeichnung | Preis |
  |---|---|---|---|
  | ➜ | 4 | 27-Zoll-Monitor | 229,00 |
  | | 1 | USB-Stick 64 GB | 12,90 |
  | | … | … | … |

- Darunter die drei Regeln (`<v-clicks>`):
  - **Nur vorwärts:** Man kann nicht zurückspringen.
  - **Nur lesen:** Änderungen laufen über eigene Commands.
  - **Die Verbindung bleibt offen, solange gelesen wird:** erst lesen, dann schließen.
- **Notizen:** Live mit einem Haltepunkt in der `while`-Schleife zeigen. Nach jedem Schritt im Debugger ist eine neue Zeile da.

### Folie A.17 – Spalten über den Namen ansprechen
- **Inhalt:** Magic Move von der Position zum Namen.
  - Stand 1:
    ```csharp
    int id = reader.GetInt32(0);
    string bez = reader.GetString(1);
    decimal preis = reader.GetDecimal(2);
    ```
  - Stand 2:
    ```csharp
    int iId = reader.GetOrdinal("Id");
    int iBez = reader.GetOrdinal("Bezeichnung");
    int iPreis = reader.GetOrdinal("Preis");
    while (reader.Read())
    {
        int id = reader.GetInt32(iId);
        string bez = reader.GetString(iBez);
        decimal preis = reader.GetDecimal(iPreis);
    }
    ```
- **Kasten „⚠️ Häufiger Fehler“:** Wenn jemand im SELECT die Reihenfolge der Spalten ändert, liefern feste Zahlen plötzlich falsche Daten oder eine `InvalidCastException`.
- **Notizen:** `GetOrdinal` einmal vor der Schleife aufrufen, nicht in jeder Zeile. Die Kurzform `(string)reader["Bezeichnung"]` erwähnen: Sie funktioniert auch, kostet aber etwas mehr.

### Folie A.18 – NULL beim Lesen
- **Inhalt:** Kunden lesen. `Email` darf NULL sein.
  ```csharp
  int iEmail = reader.GetOrdinal("Email");
  // …
  string? email = reader.IsDBNull(iEmail) ? null : reader.GetString(iEmail);
  ```
- **Kasten „⚠️ Häufiger Fehler“:** `GetString` auf einer NULL-Spalte wirft eine `SqlNullValueException`. Vorher immer `IsDBNull` prüfen, wenn die Spalte NULL erlaubt.

### Folie A.19 – Von Zeilen zu Objekten
- **Titel:** Mapping: aus Zeilen werden Objekte
- **Inhalt:**
  ```csharp {1|3-5|7-15|16}
  static List<Artikel> AlleArtikel(SqlConnection con)
  {
      using var cmd = new SqlCommand(
          "SELECT Id, Bezeichnung, Preis, Lagerstand FROM Artikel ORDER BY Bezeichnung", con);
      using var reader = cmd.ExecuteReader();

      var liste = new List<Artikel>();
      while (reader.Read())
      {
          liste.Add(new Artikel
          {
              Id          = reader.GetInt32(reader.GetOrdinal("Id")),
              Bezeichnung = reader.GetString(reader.GetOrdinal("Bezeichnung")),
              Preis       = reader.GetDecimal(reader.GetOrdinal("Preis")),
              Lagerstand  = reader.GetInt32(reader.GetOrdinal("Lagerstand"))
          });
      }
      return liste;
  }
  ```
- **Notizen:**
  - Hier schließt sich die Lücke von Folie 0.2: Die Tabelle ist jetzt eine `List<Artikel>`.
  - Diese Übertragung Spalte für Spalte heißt **Mapping**. Das Wort merken, es kommt beim ORM wieder.

### Folie A.20 – JOINs: Ergebnisse, die zu keiner Tabelle passen
- **Layout:** `two-cols`
- **Links: SQL** (Bestellübersicht eines Kunden):
  ```sql
  SELECT b.Id, b.Datum,
         k.Vorname + ' ' + k.Nachname AS Kunde,
         SUM(p.Menge * p.Einzelpreis) AS Summe
  FROM Bestellung b
  JOIN Kunde k           ON k.Id = b.KundeId
  JOIN Bestellposition p ON p.BestellungId = b.Id
  WHERE k.Id = @kundeId
  GROUP BY b.Id, b.Datum, k.Vorname, k.Nachname
  ORDER BY b.Datum DESC
  ```
- **Rechts: C#**
  ```csharp
  public record BestellUebersicht(
      int BestellungId, DateTime Datum, string Kunde, decimal Summe);

  // in der Leseschleife:
  liste.Add(new BestellUebersicht(
      reader.GetInt32(0),
      reader.GetDateTime(1),
      reader.GetString(2),
      reader.GetDecimal(3)));
  ```
- **Kasten „💡 Merke“:** Für Abfrageergebnisse, die keiner Tabelle entsprechen, legt man eine eigene kleine Klasse an, ein **DTO** (Data Transfer Object). `record` ist dafür ideal.
- **Notizen:** Die SQL-Abfrage können die Schüler schon. Neu ist nur, wohin das Ergebnis kommt.

### Folie A.21 – UPDATE und DELETE
- **Inhalt:**
  ```csharp {1-4|5|7-9|all}
  using var cmd = new SqlCommand(
      "UPDATE Artikel SET Preis = @preis WHERE Id = @id", con);
  cmd.Parameters.Add("@preis", SqlDbType.Decimal).Value = 19.90m;
  cmd.Parameters.Add("@id", SqlDbType.Int).Value = 2;
  int betroffen = cmd.ExecuteNonQuery();

  if (betroffen == 0)
      Console.WriteLine("Artikel nicht gefunden.");
  ```
- **Notizen:**
  - DELETE funktioniert genauso.
  - Frage an die Klasse: Was passiert bei `DELETE FROM Artikel WHERE Id = 1`? Antwort: Es gibt einen Fehler wegen des Fremdschlüssels, weil der Artikel in Bestellpositionen vorkommt. Die Exception ist eine `SqlException` mit der Nummer 547.

### Folie A.22 – Transaktionen: alles oder nichts
- **Inhalt:** Eine Bestellung aufgeben besteht aus mehreren Schritten:
  1. Bestellung anlegen
  2. pro Artikel eine Bestellposition anlegen
  3. pro Artikel den Lagerstand verringern
- Darunter per Klick: **„Was passiert, wenn Schritt 3 beim zweiten Artikel scheitert?“** Dann gäbe es eine halbe Bestellung in der Datenbank.
- **Kasten „🔁 Kennst du aus SQL“:** `BEGIN TRANSACTION … COMMIT` bzw. `ROLLBACK`
- **Notizen:** Das ist das wichtigste Geschäftsbeispiel im Teil A. In der Betriebsinformatik sind fast alle relevanten Vorgänge mehrstufig: Buchung, Lieferung, Rechnung.

### Folie A.23 – Transaktion in C# (1/2)
- **Inhalt:**
  ```csharp {1-3|5-8|9|all}
  public record Position(int ArtikelId, int Menge);

  static int BestellungAufgeben(SqlConnection con, int kundeId, List<Position> positionen)
  {
      using SqlTransaction tx = con.BeginTransaction();
      try
      {
          using var cmdBest = new SqlCommand(
              "INSERT INTO Bestellung (KundeId) OUTPUT INSERTED.Id VALUES (@kunde)", con, tx);
          cmdBest.Parameters.Add("@kunde", SqlDbType.Int).Value = kundeId;
          int bestellungId = (int)cmdBest.ExecuteScalar()!;
          // weiter auf der nächsten Folie …
  ```
- **Kasten „⚠️ Häufiger Fehler“:** Jedes Command innerhalb der Transaktion braucht `tx` als dritten Parameter. Fehlt er, gibt es eine `InvalidOperationException`.

### Folie A.24 – Transaktion in C# (2/2)
- **Inhalt:**
  ```csharp {1-8|10-15|16-17|19|21-25}
          foreach (var pos in positionen)
          {
              using var cmdPos = new SqlCommand("""
                  INSERT INTO Bestellposition (BestellungId, ArtikelId, Menge, Einzelpreis)
                  SELECT @best, Id, @menge, Preis FROM Artikel WHERE Id = @artikel
                  """, con, tx);
              cmdPos.Parameters.Add("@best", SqlDbType.Int).Value = bestellungId;
              cmdPos.Parameters.Add("@menge", SqlDbType.Int).Value = pos.Menge;
              cmdPos.Parameters.Add("@artikel", SqlDbType.Int).Value = pos.ArtikelId;
              cmdPos.ExecuteNonQuery();

              using var cmdLager = new SqlCommand(
                  "UPDATE Artikel SET Lagerstand = Lagerstand - @menge " +
                  "WHERE Id = @artikel AND Lagerstand >= @menge", con, tx);
              cmdLager.Parameters.Add("@menge", SqlDbType.Int).Value = pos.Menge;
              cmdLager.Parameters.Add("@artikel", SqlDbType.Int).Value = pos.ArtikelId;
              if (cmdLager.ExecuteNonQuery() == 0)
                  throw new InvalidOperationException($"Artikel {pos.ArtikelId} ist nicht lagernd.");
          }
          tx.Commit();
          return bestellungId;
      }
      catch
      {
          tx.Rollback();
          throw;
      }
  }
  ```
- **Notizen:**
  - Den Einzelpreis per `INSERT … SELECT` direkt aus der Tabelle Artikel nehmen. So steht der aktuelle Preis zum Bestellzeitpunkt in der Position.
  - `AND Lagerstand >= @menge` verhindert einen negativen Lagerstand. 0 betroffene Zeilen bedeutet „nicht genug lagernd“.
  - Testfall: eine Bestellung mit Artikel 6 (Webcam, Lagerstand 0). Danach in SSMS zeigen, dass weder Bestellung noch Position angelegt wurde.

### Folie A.25 – async/await: Warum?
- **Inhalt:** (`<v-clicks>`)
  - Eine Datenbankabfrage dauert, das Programm **wartet**.
  - In WinForms/WPF friert die Oberfläche ein.
  - Ein Webserver blockiert pro Anfrage einen Thread, bei vielen Benutzern wird das zum Problem.
  - Mit **async/await** gibt das Programm die Kontrolle ab, während die Datenbank arbeitet.
- **Notizen:** Keine Theorie zu Threads, nur das Prinzip: „Während ich warte, darf etwas anderes passieren.“ Das reicht hier völlig.

### Folie A.26 – Von sync zu async
- **Inhalt:** Magic Move von `AlleArtikel` (A.19) zur asynchronen Version.
  - Stand 1: der Code aus A.19 (gekürzt auf Signatur, `using`-Zeilen, `while`-Kopf, `return`)
  - Stand 2:
    ```csharp
    static async Task<List<Artikel>> AlleArtikelAsync(SqlConnection con)
    {
        await using var cmd = new SqlCommand(
            "SELECT Id, Bezeichnung, Preis, Lagerstand FROM Artikel ORDER BY Bezeichnung", con);
        await using var reader = await cmd.ExecuteReaderAsync();

        var liste = new List<Artikel>();
        while (await reader.ReadAsync())
        {
            // Mapping unverändert
        }
        return liste;
    }
    ```
- Darunter eine Tabelle der Umstellungen:

  | sync | async |
  |---|---|
  | `con.Open()` | `await con.OpenAsync()` |
  | `ExecuteScalar()` | `await ExecuteScalarAsync()` |
  | `ExecuteNonQuery()` | `await ExecuteNonQueryAsync()` |
  | `ExecuteReader()` | `await ExecuteReaderAsync()` |
  | `reader.Read()` | `await reader.ReadAsync()` |
  | `using var` | `await using var` |
  | `List<Artikel>` als Rückgabe | `async Task<List<Artikel>>` |
- **Kasten „💡 Merke“:** Ab jetzt schreiben wir den Datenzugriff asynchron. EF Core arbeitet genauso, dort heißt es `ToListAsync()` und `SaveChangesAsync()`.

### Folie A.27 – Ordnung: das Repository
- **Inhalt:** Ziel: Kein SQL in `Main` oder in Button-Klicks. Der gesamte Datenzugriff für Artikel steckt in einer Klasse.
  ```csharp
  public class ArtikelRepository(string connStr)
  {
      public async Task<List<Artikel>> GetAllAsync() { … }
      public async Task<Artikel?> GetByIdAsync(int id) { … }
      public async Task<int> InsertAsync(Artikel artikel) { … }     // liefert neue Id
      public async Task<bool> UpdateAsync(Artikel artikel) { … }    // false = nicht gefunden
      public async Task<bool> DeleteAsync(int id) { … }
  }
  ```
  ```csharp
  // Verwendung – das Programm sieht kein SQL mehr
  var repo = new ArtikelRepository(ConnStr);
  foreach (var a in await repo.GetAllAsync())
      Console.WriteLine($"{a.Bezeichnung}: {a.Preis:C}");
  ```
- **Notizen:**
  - Jede Methode öffnet ihre eigene Verbindung, so wie auf Folie A.4 beschrieben.
  - Ausblick: Mit einem Interface `IArtikelRepository` lässt sich die Implementierung später gegen EF Core tauschen. Dazu passt die Konsolen-Demo „DatenzugriffDemo“.
  - Übungsaufgabe: `ArtikelRepository` vollständig implementieren.

### Folie A.28 – Häufige Fehler in Teil A
- **Inhalt:** Tabelle:

  | Symptom | Ursache | Lösung |
  |---|---|---|
  | „certificate chain … not trusted“ | lokale Verschlüsselung ohne Zertifikat | `TrustServerCertificate=true` |
  | `InvalidCastException` bei `ExecuteScalar` | `DBNull` statt Wert | auf `DBNull` prüfen |
  | `SqlNullValueException` beim Lesen | `GetString` auf NULL-Spalte | `IsDBNull` prüfen |
  | „Parameter wurde nicht angegeben“ | C#-`null` als Wert | `DBNull.Value` verwenden |
  | „There is already an open DataReader …“ | zweites Command, während der Reader noch offen ist | erst fertig lesen bzw. Reader schließen |
  | `InvalidOperationException` in Transaktion | Command ohne `tx` | `new SqlCommand(sql, con, tx)` |
  | Syntaxfehler bei Preisen, Apostroph | String-Verkettung | Parameter |

### Folie A.29 – Was nervt? (Überleitung)
- **Inhalt:** Ehrliche Bilanz von Teil A (`<v-clicks>`):
  - 😩 Für jede Tabelle dieselben Zeilen: Verbindung, Command, Parameter, Schleife.
  - 😩 **Mapping von Hand:** `reader.GetString(reader.GetOrdinal("Bezeichnung"))` für jede Spalte.
  - 😩 **SQL steht in Strings.** Ein Tippfehler (`Bezeichung`) fällt erst zur Laufzeit auf.
  - 😩 Wird eine Spalte umbenannt, muss man jedes SQL im Projekt suchen.
  - 😩 **Beziehungen** (Kunde → Bestellungen → Positionen) muss man selbst zusammenbauen.
  - 😩 Für INSERT und UPDATE muss man selbst wissen, **was sich geändert hat**.
- Darunter groß, per Klick: **„Kann das nicht jemand automatisch machen?“**
- **Notizen:**
  - Zum Zeilenvergleich: Die Methode `AlleArtikel` hat rund 20 Zeilen, davon eine Zeile SQL.
  - Den Schmerz bewusst stehen lassen, er ist die Motivation für Teil B.

---

## Teil B – Was ist ein ORM? (ca. 1 EH)

Datei: `pages/b-orm.md`

### Folie B.0 – Abschnitt
- **Layout:** `section`
- **Titel:** Teil B · Object-Relational Mapping
- **Untertitel:** Die Brücke zwischen Tabellen und Objekten

### Folie B.1 – Zwei Welten
- **Layout:** `two-cols`
- **Inhalt:** Gegenüberstellung als Tabelle über beide Spalten, jede Zeile mit `v-click`:

  | Datenbank (relational) | C# (objektorientiert) |
  |---|---|
  | Tabelle `Artikel` | Klasse `Artikel` |
  | Zeile | Objekt |
  | Spalte | Eigenschaft |
  | Fremdschlüssel `KundeId` | Referenz `bestellung.Kunde` |
  | 1:n über JOIN | Liste `kunde.Bestellungen` |
  | `NVARCHAR(50)`, `DECIMAL(10,2)`, `NULL` | `string`, `decimal`, `null` |
  | Identität über Primärschlüssel | Identität über Referenz im Speicher |
- **Notizen:** Diese Unterschiede nennt man den **Object-Relational Impedance Mismatch**. Den Begriff nur nennen, nicht abprüfen. In Teil A haben wir diese Lücke von Hand überbrückt.

### Folie B.2 – Was ist ein ORM?
- **Inhalt:**
  - **Definition (groß):** Ein **Object-Relational Mapper** ist eine Bibliothek, die Objekte automatisch in Tabellenzeilen übersetzt und umgekehrt.
  - Mermaid-Flowchart (LR):
    ```mermaid
    flowchart LR
        C["C#-Objekte<br/>List&lt;Artikel&gt;"] <-->|"ORM übersetzt"| S["SQL<br/>SELECT / INSERT / UPDATE"]
        S <--> DB[("Datenbank")]
    ```
  - Darunter: „Du arbeitest mit Objekten, das ORM erzeugt das SQL.“
- **Notizen:** Wichtig: Ein ORM ersetzt die Datenbank nicht, und es ersetzt auch das SQL-Wissen nicht. Es schreibt das SQL für uns, aber es bleibt SQL.

### Folie B.3 – Was ein ORM übernimmt
- **Inhalt:** Jeder Punkt zeigt auf ein Problem von Folie A.29 zurück (`<v-clicks>`):

  | Problem aus Teil A | Das macht das ORM |
  |---|---|
  | Mapping von Hand | **Mapping:** Spalten werden automatisch zu Eigenschaften |
  | SQL in Strings | **Abfragen in C#** (LINQ), vom Compiler geprüft |
  | Selbst merken, was sich geändert hat | **Change Tracking:** erkennt geänderte Objekte und erzeugt INSERT/UPDATE/DELETE |
  | Beziehungen zusammenbauen | **Navigation:** `kunde.Bestellungen` |
  | Tabellen per Skript anlegen | **Migrations:** Datenbankschema aus dem C#-Code |

### Folie B.4 – Ein Spektrum, kein Entweder-oder
- **Inhalt:** Horizontale Achse „wie viel nimmt mir die Technik ab?“ mit drei Stationen:
  ```mermaid
  flowchart LR
      A["<b>ADO.NET</b><br/>DataReader<br/>alles selbst"] --> B["<b>Micro-ORM</b><br/>z. B. Dapper<br/>SQL selbst,<br/>Mapping automatisch"] --> C["<b>Full ORM</b><br/>z. B. EF Core<br/>LINQ, Change Tracking,<br/>Migrations"]
  ```
- Darunter: Mini-Codevergleich (dieselbe Abfrage, „alle Artikel unter 20 €“), drei kleine Blöcke nebeneinander bzw. als Magic Move:
  ```csharp
  // ADO.NET – siehe Teil A, ca. 20 Zeilen
  ```
  ```csharp
  // Dapper
  var liste = await con.QueryAsync<Artikel>(
      "SELECT * FROM Artikel WHERE Preis < @max", new { max = 20m });
  ```
  ```csharp
  // EF Core
  var liste = await db.Artikel.Where(a => a.Preis < 20).ToListAsync();
  ```
- **Notizen:** Auch Dapper und EF Core verwenden intern einen DataReader. Teil A war also keine Zeitverschwendung, sondern die Grundlage für alles Weitere.

### Folie B.5 – ORMs in C#/.NET
- **Inhalt:** Tabelle:

  | Bibliothek | Art | Kurz gesagt |
  |---|---|---|
  | **Entity Framework Core** | Full ORM | Von Microsoft, Standard in neuen .NET-Projekten. Das verwenden wir. |
  | **Dapper** | Micro-ORM | Sehr schnell. SQL selbst schreiben, Mapping automatisch. Vom Team hinter Stack Overflow. |
  | **NHibernate** | Full ORM | .NET-Portierung des Java-ORMs Hibernate. Vor allem in älteren Enterprise-Projekten. |
  | **linq2db** | leichtgewichtig | LINQ-Abfragen ohne Change Tracking, nahe am SQL |
  | **RepoDB** | Hybrid | zwischen Micro- und Full-ORM |
- Zusätzlich als graue Fußzeile „Historisch, nicht mehr für neue Projekte“: LINQ to SQL, Entity Framework 6
- **[PRÜFEN]:** Aktualität von linq2db und RepoDB (letzte Releases) kurz auf NuGet bzw. GitHub prüfen und gegebenenfalls streichen.
- **Notizen:** Keine Namen auswendig lernen lassen. Wichtig ist der Unterschied zwischen Micro-ORM und Full ORM.

### Folie B.6 – Das Prinzip gibt es überall
- **Inhalt:** Kleine Tabelle bzw. Logo-freie Kacheln (nur Text):

  | Sprache | ORM |
  |---|---|
  | Java | Hibernate / JPA |
  | Python | SQLAlchemy, Django ORM |
  | JavaScript/TypeScript | Prisma, TypeORM |
  | PHP | Eloquent (Laravel), Doctrine |
- **Kasten „💡 Merke“:** Wer die Konzepte von EF Core versteht (Entity, Context, Change Tracking, Migration, Lazy/Eager Loading), findet sich auch in diesen Frameworks schnell zurecht. Das ist relevant für Diplomarbeiten in anderen Sprachen.

### Folie B.7 – Vorteile von ORMs
- **Inhalt:** (`<v-clicks>`)
  - ✅ **Weniger Code:** kein Mapping, kein wiederholter Verbindungs-Code
  - ✅ **Typsicherheit:** Der Compiler prüft Abfragen und Eigenschaftsnamen. Tippfehler fallen sofort auf.
  - ✅ **Refactoring:** Eine Eigenschaft umbenennen ändert alle Abfragen mit.
  - ✅ **Change Tracking:** `SaveChanges()` speichert alle Änderungen in einer Transaktion.
  - ✅ **Beziehungen** als Objekte: `bestellung.Kunde.Ort`
  - ✅ **Migrations:** Code und Datenbankschema bleiben synchron, versioniert in Git.
  - ✅ **Sicherheit:** Parameter werden automatisch verwendet, SQL-Injection ist im Normalfall ausgeschlossen.
  - ✅ **Datenbankunabhängigkeit:** Der Provider lässt sich tauschen (SQL Server, PostgreSQL, SQLite …).

### Folie B.8 – Nachteile und Risiken
- **Inhalt:** (`<v-clicks>`)
  - ⚠️ **Blackbox:** Man sieht das SQL nicht, ohne es bewusst einzuschalten.
  - ⚠️ **Performance-Fallen:** Das N+1-Problem, zu viele geladene Daten, ineffizientes SQL. Kommt in Teil D.
  - ⚠️ **Overhead:** etwas langsamer als handgeschriebenes SQL mit DataReader
  - ⚠️ **Lernkurve:** viele neue Konzepte (Tracking, Loading-Strategien, Migrations)
  - ⚠️ **Grenzen:** komplexe Berichte, Massenänderungen oder datenbankspezifische Features sind in SQL oft einfacher.
  - ⚠️ **„Leaky Abstraction“:** Wenn es klemmt, muss man trotzdem SQL und die Datenbank verstehen.
- **Kasten „💡 Merke“:** Ein ORM ersetzt SQL-Wissen nicht, es setzt es voraus.
- **Notizen:** Darum haben wir mit Teil A begonnen. Wer nie gesehen hat, was ein ORM erzeugt, kann seine Probleme nicht lösen.

### Folie B.9 – Wann was?
- **Inhalt:** Entscheidungshilfe als Tabelle:

  | Situation | Empfehlung |
  |---|---|
  | Typische Geschäftsanwendung: Stammdaten, Bestellungen, CRUD | **EF Core** |
  | Komplexe Berichte, viel handoptimiertes SQL | **Dapper** oder SQL in EF Core (`FromSql`) |
  | Massendaten, Import/Export, maximale Geschwindigkeit | **DataReader** bzw. `SqlBulkCopy` |
  | Bestehende Anwendung | das, was schon verwendet wird |
- **Notizen:** In der Praxis wird oft gemischt: EF Core für den Alltag, Dapper oder eigenes SQL für die wenigen kritischen Stellen.

---

## Teil C – LINQ (ca. 1–2 EH)

Datei: `pages/c-linq.md`

### Folie C.0 – Abschnitt
- **Layout:** `section`
- **Titel:** Teil C · LINQ
- **Untertitel:** Abfragen direkt in C#

### Folie C.1 – Was ist LINQ?
- **Inhalt:**
  - **LINQ = Language Integrated Query**, also Abfragen als Teil der Sprache C#.
  - Funktioniert auf **allem, was man durchlaufen kann:** Listen, Arrays, und über EF Core auch auf Datenbanken.
  - Wir lernen es zuerst auf einer `List<Artikel>` im Speicher, ganz ohne Datenbank.
- **Testdaten** für alle Folien in Teil C:
  ```csharp
  List<Artikel> artikel =
  [
      new() { Id = 1, Bezeichnung = "USB-Stick 64 GB",      Preis = 12.90m,  Lagerstand = 50 },
      new() { Id = 2, Bezeichnung = "Funkmaus",             Preis = 24.90m,  Lagerstand = 30 },
      new() { Id = 3, Bezeichnung = "Mechanische Tastatur", Preis = 89.00m,  Lagerstand = 12 },
      new() { Id = 4, Bezeichnung = "27-Zoll-Monitor",      Preis = 229.00m, Lagerstand = 5 },
      new() { Id = 5, Bezeichnung = "HDMI-Kabel 2 m",       Preis = 7.50m,   Lagerstand = 100 },
      new() { Id = 6, Bezeichnung = "Webcam Full HD",       Preis = 49.90m,  Lagerstand = 0 },
  ];
  ```

### Folie C.2 – Ohne und mit LINQ
- **Layout:** `two-cols`
- **Links: „So kennt ihr es“**
  ```csharp
  var guenstige = new List<Artikel>();
  foreach (var a in artikel)
  {
      if (a.Preis < 20)
          guenstige.Add(a);
  }
  guenstige.Sort((x, y) =>
      x.Bezeichnung.CompareTo(y.Bezeichnung));
  ```
- **Rechts: „Mit LINQ“**
  ```csharp
  var guenstige = artikel
      .Where(a => a.Preis < 20)
      .OrderBy(a => a.Bezeichnung)
      .ToList();
  ```
- **Kasten „🔁 Kennst du aus SQL“:** `SELECT * FROM Artikel WHERE Preis < 20 ORDER BY Bezeichnung`
- **Notizen:** LINQ beschreibt, **was** man will, nicht **wie** es Schritt für Schritt gemacht wird. Genau wie SQL.

### Folie C.3 – Lambda-Ausdrücke
- **Inhalt:**
  - Ein **Lambda** ist eine kleine, namenlose Funktion: `a => a.Preis < 20`
  - Aufbau mit Klick-Hervorhebung: `a` ist der Parameter (ein Artikel), `=>` heißt „wird zu“, `a.Preis < 20` ist das Ergebnis (`bool`).
  - Vergleich mit einer normalen Methode:
    ```csharp
    // als Methode
    static bool IstGuenstig(Artikel a) { return a.Preis < 20; }

    // als Lambda
    Func<Artikel, bool> istGuenstig = a => a.Preis < 20;
    ```
  - `Where` ruft das Lambda für jeden Artikel auf und behält jene, bei denen `true` herauskommt.
- **Notizen:** Für LINQ reicht dieses Verständnis völlig. `Func<…>` nur kurz zeigen, nicht vertiefen.

### Folie C.4 – Die wichtigsten Operatoren
- **Inhalt:** Tabelle mit SQL-Brücke (Kernfolie für Teil C):

  | LINQ | SQL | Beispiel |
  |---|---|---|
  | `Where(a => …)` | `WHERE` | `.Where(a => a.Lagerstand > 0)` |
  | `Select(a => …)` | Spaltenliste im `SELECT` | `.Select(a => a.Bezeichnung)` |
  | `OrderBy` / `OrderByDescending` / `ThenBy` | `ORDER BY` | `.OrderBy(a => a.Preis)` |
  | `Count` / `Sum` / `Average` / `Min` / `Max` | Aggregatfunktionen | `.Sum(a => a.Preis * a.Lagerstand)` |
  | `First` / `FirstOrDefault` | `TOP 1` | `.FirstOrDefault(a => a.Id == 3)` |
  | `Any` | `EXISTS` | `.Any(a => a.Lagerstand == 0)` |
  | `GroupBy` | `GROUP BY` | `.GroupBy(a => a.Preis > 50)` |
  | `Take` / `Skip` | `TOP` / `OFFSET … FETCH` | `.Skip(10).Take(10)` |
  | `ToList` | Ausführen und Ergebnis holen | `.ToList()` |

### Folie C.5 – Beispiele im Shop
- **Inhalt:** Jeweils eine Frage, darunter per Klick die LINQ-Antwort:
  ```csharp
  // Wie viel ist das Lager wert?
  decimal lagerwert = artikel.Sum(a => a.Preis * a.Lagerstand);

  // Gibt es Artikel, die ausverkauft sind?
  bool ausverkauft = artikel.Any(a => a.Lagerstand == 0);

  // Der teuerste Artikel
  Artikel teuerster = artikel.OrderByDescending(a => a.Preis).First();

  // Nur die Bezeichnungen der lagernden Artikel, alphabetisch
  List<string> namen = artikel
      .Where(a => a.Lagerstand > 0)
      .OrderBy(a => a.Bezeichnung)
      .Select(a => a.Bezeichnung)
      .ToList();
  ```
- **Notizen:** Live mit den Testdaten ausprobieren, vorher Ergebnisse vorhersagen lassen (Predict → Run).

### Folie C.6 – First, FirstOrDefault, Single
- **Inhalt:** Tabelle:

  | Methode | 0 Treffer | 1 Treffer | mehrere Treffer |
  |---|---|---|---|
  | `First` | Exception | das Element | das erste |
  | `FirstOrDefault` | `null` | das Element | das erste |
  | `Single` | Exception | das Element | Exception |
  | `SingleOrDefault` | `null` | das Element | Exception |
- **Kasten „💡 Merke“:** Suche nach Id (es kann höchstens einen geben): `SingleOrDefault` oder `FirstOrDefault`, und danach auf `null` prüfen.

### Folie C.7 – Projektion: nur was man braucht
- **Inhalt:**
  ```csharp
  // anonymer Typ – nur innerhalb der Methode verwendbar
  var preisliste = artikel
      .Select(a => new { a.Bezeichnung, Brutto = a.Preis * 1.2m })
      .ToList();

  // DTO – auch als Rückgabewert verwendbar
  public record PreisZeile(string Bezeichnung, decimal Brutto);

  List<PreisZeile> liste = artikel
      .Select(a => new PreisZeile(a.Bezeichnung, a.Preis * 1.2m))
      .ToList();
  ```
- **Notizen:** Ein DTO kennen wir schon von Folie A.20. Bei EF Core wird `Select` später wichtig, weil dann nur diese Spalten aus der Datenbank geholt werden.

### Folie C.8 – GroupBy
- **Inhalt:**
  ```csharp
  var gruppen = artikel
      .GroupBy(a => a.Preis >= 50 ? "ab 50 €" : "unter 50 €")
      .Select(g => new { Klasse = g.Key, Anzahl = g.Count(), Lagerwert = g.Sum(a => a.Preis * a.Lagerstand) });

  foreach (var g in gruppen)
      Console.WriteLine($"{g.Klasse}: {g.Anzahl} Artikel, Lagerwert {g.Lagerwert:C}");
  ```
- **Kasten „🔁 Kennst du aus SQL“:** `GROUP BY` mit `COUNT` und `SUM`. `g.Key` ist der Gruppierungswert.

### Folie C.9 – Zwei Schreibweisen
- **Layout:** `two-cols`
- **Links: Methodensyntax** (verwenden wir)
  ```csharp
  var namen = artikel
      .Where(a => a.Preis < 20)
      .OrderBy(a => a.Bezeichnung)
      .Select(a => a.Bezeichnung);
  ```
- **Rechts: Abfragesyntax**
  ```csharp
  var namen = from a in artikel
              where a.Preis < 20
              orderby a.Bezeichnung
              select a.Bezeichnung;
  ```
- **Notizen:** Beide Varianten ergeben dasselbe. In der Praxis und in der Microsoft-Dokumentation zu EF Core überwiegt die Methodensyntax. Die Abfragesyntax sollen die Schüler nur lesen können.

### Folie C.10 – Verzögerte Ausführung
- **Inhalt:**
  ```csharp {1|2|3}
  var abfrage = artikel.Where(a => a.Preis < 20);        // noch NICHTS passiert
  artikel.Add(new Artikel { Bezeichnung = "Mauspad", Preis = 4.90m });
  Console.WriteLine(abfrage.Count());                     // 3 – das Mauspad ist dabei!
  ```
- **Kasten „💡 Merke“:** Eine LINQ-Abfrage ist zuerst nur eine **Beschreibung**. Ausgeführt wird sie erst, wenn man das Ergebnis braucht: `ToList()`, `Count()`, `First()`, `foreach` …
- **Notizen:**
  - Vorhersagen lassen. Die meisten tippen auf 2, richtig ist 3 (USB-Stick, HDMI-Kabel, Mauspad).
  - Das wird bei EF Core entscheidend: Bis zum `ToList()` kann man die Abfrage noch erweitern, und erst dann geht **ein** SQL an die Datenbank.

### Folie C.11 – LINQ auf Listen vs. LINQ auf der Datenbank
- **Inhalt:** Mermaid-Flowchart, zwei Wege nebeneinander:
  ```mermaid
  flowchart TB
      subgraph obj["LINQ to Objects · IEnumerable&lt;T&gt;"]
          L1["artikel.Where(a => a.Preis < 20)"] --> L2["C# durchläuft die Liste<br/>im Arbeitsspeicher"]
      end
      subgraph ef["LINQ mit EF Core · IQueryable&lt;T&gt;"]
          E1["db.Artikel.Where(a => a.Preis < 20)"] --> E2["EF Core übersetzt<br/>in SQL"] --> E3["SELECT … FROM Artikel<br/>WHERE Preis < 20"] --> E4[("SQL Server")]
      end
  ```
- **Kasten „💡 Merke“:** Gleicher Code, ganz anderer Ablauf. Bei EF Core wird das Lambda **nicht ausgeführt**, sondern in SQL **übersetzt**.
- **Notizen:** Darum kann nicht jeder C#-Ausdruck in EF Core verwendet werden: Eine eigene Methode `IstGuenstig(a)` kennt SQL Server nicht. Das ist die Überleitung zu Teil D.

---

## Teil D – Entity Framework Core (ca. 4–5 EH)

Datei: `pages/d-ef-core.md`

### Folie D.0 – Abschnitt
- **Layout:** `section`
- **Titel:** Teil D · Entity Framework Core
- **Untertitel:** Der OnlineShop mit einem ORM

### Folie D.1 – Die Bausteine
- **Inhalt:** Mermaid-Flowchart (LR):
  ```mermaid
  flowchart LR
      E["<b>Entities</b><br/>Kunde, Artikel,<br/>Bestellung, Bestellposition"] --- Ctx["<b>DbContext</b><br/>ShopContext<br/>DbSet je Tabelle"]
      Ctx --> P["<b>Provider</b><br/>SqlServer<br/>(nutzt SqlClient)"]
      P --> DB[("OnlineShopEf")]
      M["<b>Migrations</b><br/>Schema aus Code"] -.-> DB
  ```
- Darunter eine Begriffstabelle:

  | Begriff | Bedeutung | aus Teil A bekannt als |
  |---|---|---|
  | Entity | Klasse, die einer Tabelle entspricht | `Artikel`-Klasse |
  | DbContext | Sitzung mit der Datenbank, verwaltet Entities | Connection + Repository |
  | DbSet&lt;T&gt; | Zugriff auf eine Tabelle | `FROM Artikel` |
  | Provider | übersetzt für eine bestimmte Datenbank | `Microsoft.Data.SqlClient` |
  | Migration | versionierte Schemaänderung | `setup.sql` |
- **Notizen:** Der Provider für SQL Server verwendet intern genau den `Microsoft.Data.SqlClient` aus Teil A.

### Folie D.2 – Code First oder Database First?
- **Layout:** `two-cols`
- **Links: Code First** (machen wir)
  - Zuerst die C#-Klassen schreiben
  - EF Core erzeugt per Migration die Datenbank
  - Schemaänderungen laufen über neue Migrationen
- **Rechts: Database First**
  - Die Datenbank existiert schon
  - EF Core erzeugt die Klassen daraus („Scaffolding“):
    ```bash
    dotnet ef dbcontext scaffold "<ConnectionString>" Microsoft.EntityFrameworkCore.SqlServer -o Models
    ```
- **Notizen:**
  - Für neue Projekte und Diplomarbeiten ist Code First üblich.
  - Database First ist praktisch, wenn man an eine bestehende Firmendatenbank andocken muss. Das kommt in der Betriebsinformatik oft vor.
  - Wir legen eine **neue** Datenbank `OnlineShopEf` an, damit die Datenbank aus Teil A unberührt bleibt.

### Folie D.3 – Projekt vorbereiten
- **Inhalt:**
  ```bash
  dotnet new console -n OnlineShopEf
  cd OnlineShopEf
  dotnet add package Microsoft.EntityFrameworkCore.SqlServer
  dotnet add package Microsoft.EntityFrameworkCore.Design
  dotnet tool install --global dotnet-ef
  ```
  | Paket | Wozu |
  |---|---|
  | `…EntityFrameworkCore.SqlServer` | EF Core samt Provider für SQL Server |
  | `…EntityFrameworkCore.Design` | wird für Migrationen gebraucht |
  | `dotnet-ef` | Kommandozeilenwerkzeug für Migrationen |
- **Notizen:**
  - Die Versionen von EF Core, `.Design` und `dotnet-ef` sollten zusammenpassen (alle 10.x).
  - In Visual Studio gibt es alternativ die Paket-Manager-Konsole mit `Add-Migration` und `Update-Database`.

### Folie D.4 – Die Entities
- **Inhalt:** Magic Move über zwei Folienstände.
  - Stand 1, die Klassen aus Teil A, ergänzt um Bestellung:
    ```csharp
    public class Kunde
    {
        public int Id { get; set; }
        public string Vorname { get; set; } = "";
        public string Nachname { get; set; } = "";
        public string? Email { get; set; }
        public string Ort { get; set; } = "";
    }

    public class Bestellung
    {
        public int Id { get; set; }
        public DateTime Datum { get; set; } = DateTime.Now;
        public int KundeId { get; set; }
    }
    ```
  - Stand 2, mit **Navigationseigenschaften**:
    ```csharp
    public class Kunde
    {
        public int Id { get; set; }
        public string Vorname { get; set; } = "";
        public string Nachname { get; set; } = "";
        public string? Email { get; set; }
        public string Ort { get; set; } = "";
        public List<Bestellung> Bestellungen { get; set; } = [];
    }

    public class Bestellung
    {
        public int Id { get; set; }
        public DateTime Datum { get; set; } = DateTime.Now;
        public int KundeId { get; set; }
        public Kunde Kunde { get; set; } = null!;
        public List<Bestellposition> Positionen { get; set; } = [];
    }
    ```
- **Notizen:**
  - `KundeId` ist der Fremdschlüssel wie in der Tabelle, `Kunde` ist das Objekt dazu.
  - `= null!` bedeutet: „Wird von EF Core befüllt, wenn man es lädt.“ Das beruhigt den Nullable-Compiler.

### Folie D.5 – Die Entities (Fortsetzung)
- **Inhalt:**
  ```csharp
  using Microsoft.EntityFrameworkCore;   // für [Precision]

  public class Artikel
  {
      public int Id { get; set; }
      public string Bezeichnung { get; set; } = "";
      [Precision(10, 2)] public decimal Preis { get; set; }
      public int Lagerstand { get; set; }
  }

  public class Bestellposition
  {
      public int Id { get; set; }
      public int BestellungId { get; set; }
      public Bestellung Bestellung { get; set; } = null!;
      public int ArtikelId { get; set; }
      public Artikel Artikel { get; set; } = null!;
      public int Menge { get; set; }
      [Precision(10, 2)] public decimal Einzelpreis { get; set; }
  }
  ```
- **Kasten „⚠️ Häufiger Fehler“:** Ohne `[Precision]` legt EF Core `decimal(18,2)` an und gibt eine Warnung aus. Bei Geldbeträgen die Genauigkeit immer bewusst festlegen.
- **Notizen:** Das ER-Diagramm von Folie 0.4 einblenden. Jede Linie im Diagramm ist jetzt eine Navigationseigenschaft.

### Folie D.6 – Konventionen: was EF Core von selbst erkennt
- **Inhalt:** Tabelle:

  | Im Code | erkennt EF Core als |
  |---|---|
  | Eigenschaft `Id` (oder `ArtikelId` in Klasse `Artikel`) | Primärschlüssel, bei `int` mit `IDENTITY` |
  | `KundeId` + `Kunde Kunde` | Fremdschlüssel zur Tabelle Kunde |
  | `List<Bestellung> Bestellungen` | 1:n-Beziehung |
  | `string` (nicht nullable) | `nvarchar(max) NOT NULL` |
  | `string?` | `nvarchar(max) NULL` |
  | `DbSet<Kunde> Kunden` | Tabellenname `Kunden` |
- **Kasten „💡 Merke“:** Wo die Konventionen nicht passen, konfiguriert man selbst: mit **Attributen** (`[Precision]`, `[MaxLength]`, `[Required]`) oder mit der **Fluent API** in `OnModelCreating`.
- **Notizen:** Der Tabellenname ergibt sich aus dem Namen der DbSet-Eigenschaft. Darum heißt die Tabelle in der EF-Datenbank `Kunden`, nicht `Kunde` wie in Teil A. Mit `.ToTable("Kunde")` ließe sich das ändern.

### Folie D.7 – Der DbContext
- **Inhalt:**
  ```csharp {3|5-8|10-14|all}
  using Microsoft.EntityFrameworkCore;

  public class ShopContext : DbContext
  {
      public DbSet<Kunde> Kunden => Set<Kunde>();
      public DbSet<Artikel> Artikel => Set<Artikel>();
      public DbSet<Bestellung> Bestellungen => Set<Bestellung>();
      public DbSet<Bestellposition> Bestellpositionen => Set<Bestellposition>();

      protected override void OnConfiguring(DbContextOptionsBuilder options)
      {
          options.UseSqlServer(
              "Server=(localdb)\\MSSQLLocalDB;Database=OnlineShopEf;Integrated Security=true;TrustServerCertificate=true");
      }
  }
  ```
- **Notizen:**
  - Der Context ist die „Sitzung“ mit der Datenbank. Wie bei einer Connection gilt: kurz verwenden, dann wegwerfen (`await using`).
  - In ASP.NET Core wird der Context nicht selbst erzeugt, sondern per Dependency Injection bereitgestellt. Das ist ein Ausblick auf D.26.

### Folie D.8 – Fluent API (Alternative zu Attributen)
- **Inhalt:**
  ```csharp
  protected override void OnModelCreating(ModelBuilder modelBuilder)
  {
      modelBuilder.Entity<Artikel>(e =>
      {
          e.Property(a => a.Bezeichnung).HasMaxLength(100);
          e.Property(a => a.Preis).HasPrecision(10, 2);
      });

      modelBuilder.Entity<Kunde>(e =>
      {
          e.Property(k => k.Vorname).HasMaxLength(50);
          e.Property(k => k.Nachname).HasMaxLength(50);
          e.HasIndex(k => k.Email).IsUnique();
      });
  }
  ```
- **Notizen:** Attribute sind kürzer, die Fluent API kann mehr (z. B. Indizes, zusammengesetzte Schlüssel). Beides ist korrekt, im Projekt sollte man sich auf einen Stil einigen.

### Folie D.9 – Migrations: Datenbank aus Code
- **Inhalt:**
  ```bash
  dotnet ef migrations add Initial     # erzeugt Migrations/…_Initial.cs
  dotnet ef database update            # führt sie auf der Datenbank aus
  ```
  Mermaid-Flowchart (LR):
  ```mermaid
  flowchart LR
      K["C#-Klassen<br/>ändern"] --> A["migrations add<br/>Name"] --> F["Migrationsdatei<br/>(C#-Code)"] --> U["database update"] --> D[("Datenbank")]
      F -.->|"in Git einchecken"| G["Versionsverwaltung"]
  ```
- **Notizen:**
  - EF Core legt zusätzlich die Tabelle `__EFMigrationsHistory` an. Darin steht, welche Migrationen schon ausgeführt wurden.
  - In SSMS zeigen.

### Folie D.10 – Was steht in einer Migration?
- **Inhalt:** Ausschnitt aus der erzeugten Datei:
  ```csharp
  migrationBuilder.CreateTable(
      name: "Artikel",
      columns: table => new
      {
          Id = table.Column<int>(type: "int", nullable: false)
              .Annotation("SqlServer:Identity", "1, 1"),
          Bezeichnung = table.Column<string>(type: "nvarchar(max)", nullable: false),
          Preis = table.Column<decimal>(type: "decimal(10,2)", precision: 10, scale: 2, nullable: false),
          Lagerstand = table.Column<int>(type: "int", nullable: false)
      },
      constraints: table => table.PrimaryKey("PK_Artikel", x => x.Id));
  ```
- **Kasten „🔁 Kennst du aus SQL“:** Das ist ein `CREATE TABLE` in C#-Form. Mit `dotnet ef migrations script` sieht man das SQL dazu.
- **Notizen:** Auf `nvarchar(max)` hinweisen. Das ist zu großzügig und die Überleitung zur nächsten Folie.
- **[PRÜFEN]:** Den Ausschnitt mit der tatsächlich von EF Core 10 erzeugten Migration abgleichen, Formatierung und Annotationen können leicht abweichen.

### Folie D.11 – Das Modell ändern
- **Inhalt:**
  1. In `Artikel` ergänzen: `[MaxLength(100)] public string Bezeichnung { get; set; } = "";`
  2. ```bash
     dotnet ef migrations add BezeichnungLaenge
     dotnet ef database update
     ```
  3. Die neue Migration enthält nur die Änderung:
     ```csharp
     migrationBuilder.AlterColumn<string>(
         name: "Bezeichnung", table: "Artikel",
         type: "nvarchar(100)", maxLength: 100, nullable: false,
         oldClrType: typeof(string), oldType: "nvarchar(max)");
     ```
- **Kasten „💡 Merke“:** Niemals die Datenbank von Hand ändern, wenn man mit Migrationen arbeitet. Sonst passen Code und Datenbank nicht mehr zusammen.
- **Notizen:** `[MaxLength]` steht im Namespace `System.ComponentModel.DataAnnotations`.

### Folie D.12 – SQL sichtbar machen
- **Inhalt:**
  ```csharp
  options.UseSqlServer(connStr)
         .LogTo(Console.WriteLine, LogLevel.Information);   // using Microsoft.Extensions.Logging;
  ```
  oder für eine einzelne Abfrage:
  ```csharp
  var abfrage = db.Artikel.Where(a => a.Preis < 20);
  Console.WriteLine(abfrage.ToQueryString());
  ```
- **Kasten „💡 Merke“:** Ab jetzt ist das Logging im Unterricht **immer eingeschaltet**. Zu jeder LINQ-Abfrage schauen wir uns das SQL an.
- **Notizen:** Das ist die wichtigste Gewohnheit gegen die Blackbox (Folie B.8).

### Folie D.13 – CRUD: Create
- **Layout:** `two-cols`
- **Links: EF Core**
  ```csharp
  await using var db = new ShopContext();

  var stick = new Artikel
  {
      Bezeichnung = "USB-Stick 64 GB",
      Preis = 12.90m,
      Lagerstand = 50
  };
  db.Artikel.Add(stick);
  await db.SaveChangesAsync();

  Console.WriteLine($"Neue Id: {stick.Id}");
  ```
- **Rechts: erzeugtes SQL** (aus dem Log, vereinfacht)
  ```sql
  INSERT INTO [Artikel] ([Bezeichnung], [Lagerstand], [Preis])
  OUTPUT INSERTED.[Id]
  VALUES (@p0, @p1, @p2);
  ```
- **Notizen:**
  - Das SQL sieht fast genauso aus wie das auf Folie A.14, inklusive `OUTPUT INSERTED.Id` und Parametern.
  - `Add` allein schreibt noch nichts. Erst `SaveChangesAsync` geht zur Datenbank.

### Folie D.14 – CRUD: Read
- **Inhalt:**
  ```csharp {1-4|6|8-9|all}
  List<Artikel> guenstige = await db.Artikel
      .Where(a => a.Preis < 20)
      .OrderBy(a => a.Bezeichnung)
      .ToListAsync();

  Artikel? artikel = await db.Artikel.FindAsync(3);          // nach Primärschlüssel

  Kunde? anna = await db.Kunden
      .FirstOrDefaultAsync(k => k.Email == "anna.berger@example.at");
  ```
- **Kasten „🔁 Kennst du aus Teil C“:** Exakt dieselben LINQ-Methoden. Neu ist nur `Async` am Ende, weil die Datenbank gefragt wird.
- **Notizen:** `FindAsync` schaut zuerst, ob das Objekt schon im Context geladen ist. Nur wenn nicht, fragt es die Datenbank.

### Folie D.15 – CRUD: Update und Delete
- **Layout:** `two-cols`
- **Links: Update**
  ```csharp
  var maus = await db.Artikel.FindAsync(2);
  if (maus is not null)
  {
      maus.Preis = 19.90m;          // nur das Objekt ändern
      await db.SaveChangesAsync();  // EF erkennt die Änderung
  }
  ```
  ```sql
  UPDATE [Artikel] SET [Preis] = @p0
  WHERE [Id] = @p1;
  ```
- **Rechts: Delete**
  ```csharp
  var webcam = await db.Artikel.FindAsync(6);
  if (webcam is not null)
  {
      db.Artikel.Remove(webcam);
      await db.SaveChangesAsync();
  }
  ```
- **Notizen:**
  - Beim Update kein SQL, kein Parameter, kein „welche Spalte?“. EF Core schreibt nur die geänderte Spalte. Wie macht es das? Das zeigt die nächste Folie.
  - Delete eines Artikels mit Bestellpositionen scheitert wie in Teil A am Fremdschlüssel. Es kommt eine `DbUpdateException`, darin steckt die `SqlException`.

### Folie D.16 – Change Tracking
- **Inhalt:** Zustandsdiagramm (Mermaid `stateDiagram-v2`):
  ```mermaid
  stateDiagram-v2
      [*] --> Detached : new Artikel()
      Detached --> Added : Add()
      [*] --> Unchanged : aus DB geladen
      Unchanged --> Modified : Eigenschaft geändert
      Unchanged --> Deleted : Remove()
      Added --> Unchanged : SaveChanges()
      Modified --> Unchanged : SaveChanges()
      Deleted --> Detached : SaveChanges()
  ```
  Darunter:
  ```csharp
  var a = await db.Artikel.FindAsync(1);
  Console.WriteLine(db.Entry(a!).State);   // Unchanged
  a!.Preis += 1;
  Console.WriteLine(db.Entry(a).State);    // Modified
  ```
- **Kasten „💡 Merke“:** Der Context merkt sich beim Laden eine Kopie der Werte (Snapshot). `SaveChanges()` vergleicht und schreibt nur die Unterschiede, und zwar alle in **einer Transaktion**.
- **Notizen:** `db.ChangeTracker.DebugView.LongView` zeigt alle verfolgten Objekte samt Zustand. Das eignet sich gut zum Live-Vorführen.

### Folie D.17 – Nur lesen? AsNoTracking
- **Inhalt:**
  ```csharp
  var preisliste = await db.Artikel
      .AsNoTracking()               // keine Snapshots, schneller, weniger Speicher
      .OrderBy(a => a.Bezeichnung)
      .ToListAsync();
  ```
- **Kasten „💡 Merke“:** Für reine Anzeigen (Listen, Berichte) `AsNoTracking()` verwenden. Änderungen an diesen Objekten speichert `SaveChanges()` **nicht**.

### Folie D.18 – Die Bestellung mit EF Core
- **Inhalt:** Gegenstück zu A.23 und A.24. Bei Bedarf auf zwei Folien teilen oder Zeilen markieren.
  ```csharp
  public record Position(int ArtikelId, int Menge);

  static async Task<int> BestellungAufgebenAsync(ShopContext db, int kundeId, List<Position> positionen)
  {
      var kunde = await db.Kunden.FindAsync(kundeId)
                  ?? throw new InvalidOperationException("Kunde nicht gefunden.");
      var bestellung = new Bestellung { Kunde = kunde };

      foreach (var (artikelId, menge) in positionen)
      {
          var artikel = await db.Artikel.FindAsync(artikelId)
                        ?? throw new InvalidOperationException($"Artikel {artikelId} nicht gefunden.");
          if (artikel.Lagerstand < menge)
              throw new InvalidOperationException($"{artikel.Bezeichnung} ist nicht lagernd.");

          artikel.Lagerstand -= menge;
          bestellung.Positionen.Add(new Bestellposition
              { Artikel = artikel, Menge = menge, Einzelpreis = artikel.Preis });
      }

      db.Bestellungen.Add(bestellung);
      await db.SaveChangesAsync();      // alles in EINER Transaktion
      return bestellung.Id;
  }
  ```
- **Notizen:**
  - Vergleich mit A.23/A.24: keine `BeginTransaction`, kein `Commit`/`Rollback`, keine Ids von Hand. Wird vor `SaveChanges` eine Exception geworfen, kommt **nichts** in die Datenbank.
  - Im Log zeigen: ein INSERT für die Bestellung, INSERTs für die Positionen, UPDATEs für die Artikel. EF Core setzt `BestellungId` automatisch.
  - Für Fortgeschrittene: Bestellen zwei Benutzer gleichzeitig, kann der Lagerstand trotzdem falsch werden. Dagegen helfen Concurrency Tokens (`[Timestamp]`). Nur erwähnen.

### Folie D.19 – Beziehungen laden: Include
- **Inhalt:**
  ```csharp {1-2|3|4|5|6|all}
  var anna = await db.Kunden
      .Include(k => k.Bestellungen)
          .ThenInclude(b => b.Positionen)
              .ThenInclude(p => p.Artikel)
      .AsNoTracking()
      .FirstAsync(k => k.Id == 1);

  foreach (var b in anna.Bestellungen)
      Console.WriteLine($"{b.Datum:d}: {b.Positionen.Count} Positionen");
  ```
- **Kasten „⚠️ Häufiger Fehler“:** Ohne `Include` ist `anna.Bestellungen` einfach **leer**, ohne Fehlermeldung. EF Core lädt Beziehungen nicht automatisch.
- **Notizen:** Im Log zeigen: Aus `Include` werden JOINs. Genau die JOINs, die die Schüler in SQL selbst schreiben würden.

### Folie D.20 – Das N+1-Problem
- **Layout:** `two-cols`
- **Links: so nicht**
  ```csharp
  var bestellungen = await db.Bestellungen.ToListAsync();   // 1 Abfrage
  foreach (var b in bestellungen)
  {
      await db.Entry(b).Collection(x => x.Positionen).LoadAsync();  // + 1 Abfrage PRO Bestellung
      Console.WriteLine($"{b.Id}: {b.Positionen.Sum(p => p.Menge * p.Einzelpreis):C}");
  }
  ```
- **Rechts: so**
  ```csharp
  var bestellungen = await db.Bestellungen
      .Include(b => b.Positionen)                             // 1 Abfrage mit JOIN
      .ToListAsync();
  ```
- **Klick:** großer Hinweis „4 Bestellungen ergeben 5 Abfragen. 10.000 Bestellungen ergeben 10.001 Abfragen.“
- **Notizen:** Im Log die Abfragen zählen lassen. Das ist der häufigste Performance-Fehler mit ORMs, und ohne Logging bemerkt man ihn nicht. Dieselbe Falle gibt es bei Lazy Loading. In EF Core ist Lazy Loading standardmäßig aus, und das ist gut so.

### Folie D.21 – Projektion: genau die Daten, die man braucht
- **Inhalt:** Die Bestellübersicht aus A.20, jetzt mit EF Core:
  ```csharp
  public record BestellUebersicht(int BestellungId, DateTime Datum, string Kunde, decimal Summe);

  var uebersicht = await db.Bestellungen
      .Where(b => b.KundeId == 1)
      .OrderByDescending(b => b.Datum)
      .Select(b => new BestellUebersicht(
          b.Id,
          b.Datum,
          b.Kunde.Vorname + " " + b.Kunde.Nachname,
          b.Positionen.Sum(p => p.Menge * p.Einzelpreis)))
      .ToListAsync();
  ```
- **Kasten „💡 Merke“:** Mit `Select` holt EF Core nur die benötigten Spalten. Ein `Include` ist dabei nicht nötig, weil Navigationen im `Select` automatisch zu JOINs bzw. Unterabfragen werden.
- **Notizen:** Das erzeugte SQL neben das handgeschriebene von A.20 legen. EF Core verwendet für die Summe eventuell eine Unterabfrage statt `GROUP BY`. Das Ergebnis ist gleich.

### Folie D.22 – Auswertungen mit GroupBy
- **Inhalt:** Umsatz pro Ort, eine typische Frage aus der Betriebsinformatik:
  ```csharp
  var umsatzProOrt = await db.Bestellpositionen
      .GroupBy(p => p.Bestellung.Kunde.Ort)
      .Select(g => new
      {
          Ort = g.Key,
          Umsatz = g.Sum(p => p.Menge * p.Einzelpreis)
      })
      .OrderByDescending(x => x.Umsatz)
      .ToListAsync();
  ```
- **Kasten „🔁 Kennst du aus SQL“:** `SELECT k.Ort, SUM(p.Menge * p.Einzelpreis) … JOIN … GROUP BY k.Ort ORDER BY 2 DESC`
- **Notizen:** Das SQL im Log zeigen. EF Core erzeugt die JOINs über die Navigationen selbst.

### Folie D.23 – Vorsicht: Wo wird gerechnet?
- **Layout:** `two-cols`
- **Links: falsch**
  ```csharp
  var teure = (await db.Artikel.ToListAsync())   // ALLE Artikel laden
      .Where(a => a.Preis > 100)                 // dann im Speicher filtern
      .ToList();
  ```
- **Rechts: richtig**
  ```csharp
  var teure = await db.Artikel
      .Where(a => a.Preis > 100)                 // WHERE in SQL
      .ToListAsync();
  ```
- **Kasten „💡 Merke“:** Alles vor `ToListAsync()` wird zu SQL, alles danach läuft in C#. Darum `ToListAsync()` so spät wie möglich aufrufen. Das ist die verzögerte Ausführung aus C.10.
- **Notizen:** Methoden, die EF Core nicht übersetzen kann (z. B. eine eigene `IstGuenstig(a)`), führen zu einer Exception „could not be translated“. Das ist gewollt, denn sonst würde heimlich alles geladen.

### Folie D.24 – Wenn LINQ nicht reicht: SQL in EF Core
- **Inhalt:**
  ```csharp
  // eigenes SQL, Ergebnis als Entities – {ort} wird automatisch ein Parameter
  string ort = "Wolfsberg";
  var kunden = await db.Kunden
      .FromSql($"SELECT * FROM Kunden WHERE Ort = {ort}")
      .ToListAsync();

  // Massenänderung ohne Laden: ein einziges UPDATE
  await db.Artikel
      .Where(a => a.Lagerstand == 0)
      .ExecuteUpdateAsync(s => s.SetProperty(a => a.Preis, a => a.Preis * 0.9m));
  ```
- **Kasten „⚠️ Häufiger Fehler“:** `FromSqlRaw("… WHERE Ort = '" + ort + "'")` ist wieder SQL-Injection wie in A.10. `FromSql` mit `$"…"` ist sicher, weil EF Core die Platzhalter in Parameter umwandelt.
- **Notizen:**
  - `ExecuteUpdateAsync` und `ExecuteDeleteAsync` umgehen das Change Tracking. Sie sind schnell, aber geladene Objekte im Context erfahren nichts davon.
- **[PRÜFEN]:** Die Signatur von `ExecuteUpdateAsync` hat sich in EF Core 10 geändert (Setter jetzt als normales Lambda statt Expression). Das gezeigte Beispiel sollte weiterhin kompilieren, bitte trotzdem kurz testen.

### Folie D.25 – Häufige Fehler mit EF Core
- **Inhalt:** Tabelle:

  | Symptom | Ursache | Lösung |
  |---|---|---|
  | Änderungen nicht in der DB | `SaveChangesAsync()` vergessen | aufrufen |
  | Navigation ist leer bzw. `null` | nicht geladen | `Include` oder `Select` |
  | sehr viele SQL-Abfragen | N+1 | `Include` oder Projektion |
  | langsam, viel Speicher | `ToList()` zu früh, Tracking bei reinen Listen | spät materialisieren, `AsNoTracking()` |
  | „could not be translated“ | C#-Methode im LINQ-Ausdruck | auf übersetzbare Ausdrücke umbauen |
  | „Invalid object name …“ | Migration nicht ausgeführt | `dotnet ef database update` |
  | Warnung zu `decimal` | keine Genauigkeit angegeben | `[Precision(10, 2)]` |
  | Fehler bei parallelen Zugriffen | ein DbContext für alles bzw. mehrere Threads | pro Vorgang ein neuer Context |

### Folie D.26 – Ausblick: EF Core in der Diplomarbeit
- **Inhalt:**
  - In **ASP.NET Core** (Web-API, Blazor) wird der Context registriert und automatisch übergeben:
    ```csharp
    // Program.cs
    builder.Services.AddDbContext<ShopContext>(o =>
        o.UseSqlServer(builder.Configuration.GetConnectionString("Shop")));

    // in einem Controller oder Service
    public class ArtikelService(ShopContext db)
    {
        public Task<List<Artikel>> AlleAsync() => db.Artikel.AsNoTracking().ToListAsync();
    }
    ```
  - Connection-String in `appsettings.json`, Passwörter in **User Secrets**
  - Andere Datenbank? Provider tauschen: `UseNpgsql` (PostgreSQL), `UseSqlite` …
- **Notizen:**
  - Für `AddDbContext` braucht `ShopContext` einen Konstruktor mit `DbContextOptions<ShopContext>`, statt `OnConfiguring` zu verwenden. Nur erwähnen.
  - Das ist das Muster, das in fast jeder .NET-Diplomarbeit vorkommt.

### Folie D.27 – Vergleich: Teil A und Teil D
- **Inhalt:** Tabelle, dieselbe Aufgabe im OnlineShop:

  | Aufgabe | Command + DataReader | EF Core |
  |---|---|---|
  | Alle Artikel lesen | ca. 20 Zeilen (A.19) | 1 Zeile |
  | Artikel anlegen, Id zurück | ca. 10 Zeilen (A.14) | 3 Zeilen |
  | Preis ändern | SQL + 2 Parameter (A.21) | Eigenschaft setzen + `SaveChanges` |
  | Bestellung mit Transaktion | ca. 45 Zeilen (A.23/A.24) | ca. 20 Zeilen, Transaktion automatisch |
  | SQL-Kontrolle | vollständig | über Logging, `FromSql` bei Bedarf |
  | Geschwindigkeit | am schnellsten | etwas Overhead |
- **Notizen:** Keine Technik ist „besser“, sie haben unterschiedliche Stärken. Das ist die Brücke zu Folie B.9.

### Folie D.28 – Zusammenfassung
- **Inhalt:** Drei Spalten, je 3 bis 4 Merksätze:
  - **ADO.NET**
    - Connection, Command, DataReader
    - Scalar, NonQuery, Reader
    - Immer Parameter
    - Transaktion bei mehreren Schritten
  - **ORM**
    - übersetzt zwischen Objekten und Tabellen
    - Micro- vs. Full-ORM
    - ersetzt SQL-Wissen nicht
  - **EF Core**
    - Entities, DbContext, Migrations
    - LINQ wird zu SQL
    - `SaveChanges` mit Change Tracking
    - SQL immer im Blick (Logging)

### Folie D.29 – Quellen und Weiterlesen
- **Inhalt:**
  - Microsoft Learn: ADO.NET mit SqlClient – https://learn.microsoft.com/sql/connect/ado-net/
  - Microsoft Learn: EF Core Überblick – https://learn.microsoft.com/ef/core/
  - Microsoft Learn: LINQ – https://learn.microsoft.com/dotnet/csharp/linq/
  - OWASP: SQL Injection – https://owasp.org/www-community/attacks/SQL_Injection
- **[PRÜFEN]:** Links auf Erreichbarkeit prüfen.

---

## 5. Anhang: Übungsideen passend zu den Teilen

Diese Ideen gehören nicht auf Folien. Sie dienen nur als Notiz für die Lehrkraft und kommen als `uebungen.md` in den Projektordner.

- **Nach A.14:** Artikel anlegen per Konsoleneingabe, mit Parametern. Testeingaben: `12,90` und `Kinder's Maus`.
- **Nach A.20:** Eine Methode `KundenMitUmsatz()`, die eine `List<KundeUmsatz>` liefert (DTO, JOIN, GROUP BY).
- **Nach A.24:** Die Bestellung mit einem nicht lagernden Artikel testen und in SSMS prüfen, dass nichts angelegt wurde.
- **Nach A.27:** `ArtikelRepository` vollständig implementieren, danach `KundenRepository` selbstständig.
- **Nach C.8:** LINQ-Kärtchen: SQL-Abfrage auf der einen Seite, LINQ auf der anderen, zuordnen lassen.
- **Nach D.11:** `[MaxLength]` für alle Strings ergänzen, Migration erzeugen und das erzeugte SQL mit `dotnet ef migrations script` ansehen.
- **Nach D.21:** Die Übungen von A.20 mit EF Core lösen und das erzeugte SQL mit dem eigenen vergleichen.
- **Nach D.27:** `IArtikelRepository` mit zwei Implementierungen (ADO.NET und EF Core), austauschbar im Programm.
