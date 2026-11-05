---
theme: seriph
routerMode: hash
title: Asynchroner Datenzugriff
info: |
  ## Asynchroner Datenzugriff
  async/await und Repository · am Beispiel OnlineShop
background: https://raw.githubusercontent.com/HTL-Wolfsberg-Betriebsinformatik/skript/refs/heads/main/slides/content/slides/background-cover-16-9.webp
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

# Asynchroner Datenzugriff

## *async/await · Repository*

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---
layout: section
---

# Von sync zu async

## async/await im Datenzugriff

---
hideInToc: true
---

# async/await: Warum?

<v-clicks>

- Eine Datenbankabfrage dauert, das Programm **wartet**.
- In WinForms/WPF friert die Oberfläche ein.
- Ein Webserver blockiert pro Anfrage einen Thread, bei vielen Benutzern wird das zum Problem.
- Mit **async/await** gibt das Programm die Kontrolle ab, während die Datenbank arbeitet.

</v-clicks>

<!--
Wiederholung aus dem Foliensatz „Threads, Tasks und async/await“. Hier genügt das Prinzip: „Während ich warte, darf etwas anderes passieren.“
-->

---
hideInToc: true
---

# Von sync zu async

<div style="--slidev-code-font-size: 0.64rem; --slidev-code-line-height: 1.35;">

````md magic-move
```csharp
static List<Artikel> AlleArtikel(SqlConnection con)
{
    using var cmd = new SqlCommand(
        "SELECT Id, Bezeichnung, Preis, Lagerstand FROM Artikel ORDER BY Bezeichnung", con);
    using var reader = cmd.ExecuteReader();

    var liste = new List<Artikel>();
    while (reader.Read())
    {
        // Mapping unverändert
    }
    return liste;
}
```
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
````

<div v-click class="mt-2">

<p class="text-sm !my-1">Aufruf im Hauptprogramm (<code>Program.cs</code>):</p>

```csharp
await using var con = new SqlConnection(ConnStr);
await con.OpenAsync();

List<Artikel> artikel = await AlleArtikelAsync(con);
foreach (var a in artikel)
    Console.WriteLine($"{a.Bezeichnung}: {a.Preis:C}");
```

</div>

</div>

---
hideInToc: true
---

# Von sync zu async: die Umstellungen

<div class="text-sm">

| sync | async |
|---|---|
| `con.Open()` | `await con.OpenAsync()` |
| `ExecuteScalar()` | `await ExecuteScalarAsync()` |
| `ExecuteNonQuery()` | `await ExecuteNonQueryAsync()` |
| `ExecuteReader()` | `await ExecuteReaderAsync()` |
| `reader.Read()` | `await reader.ReadAsync()` |
| `using var` | `await using var` |
| `List<Artikel>` als Rückgabe | `async Task<List<Artikel>>` |

</div>

<Merke>

Ab jetzt schreiben wir den Datenzugriff asynchron.

</Merke>

---
layout: section
---

# Aufräumen

## Repository

---
hideInToc: true
---

# Ordnung: das Repository

Ziel: Kein SQL in `Main` oder in Button-Klicks. Der gesamte Datenzugriff für Artikel steckt in einer Klasse.

<div style="--slidev-code-font-size: 0.64rem; --slidev-code-line-height: 1.35;">

<div class="grid grid-cols-2 gap-4">
<div>

```csharp [ArtikelRepository.cs]
public class ArtikelRepository
{
    private readonly string connStr;

    public ArtikelRepository(string connStr)
    {
        this.connStr = connStr;
    }

    public async Task<List<Artikel>> GetAllAsync() { … }
    public async Task<Artikel?> GetByIdAsync(int id) { … }
    public async Task<int> InsertAsync(Artikel artikel) { … }     
    public async Task<bool> UpdateAsync(Artikel artikel) { … }
    public async Task<bool> DeleteAsync(int id) { … }
}
```

</div>
<div>

```csharp [Program.cs]
// Verwendung – das Programm sieht kein SQL mehr
var repo = new ArtikelRepository(ConnStr);
foreach (Artikel a in await repo.GetAllAsync())
    Console.WriteLine($"{a.Bezeichnung}: {a.Preis:C}");
```

</div>
</div>
<Merke>

**"Repository"** ist ein Entwurfsmuster (*en: Design Pattern*), das den Zugriff auf Datenquellen abstrahiert und eine klare Trennung zwischen Geschäftslogik und Datenzugriffsschicht ermöglicht.

</Merke>

</div>

<!--
- Jede Methode öffnet ihre eigene Verbindung, so wie im Foliensatz „Datenbanken in C#“ auf „Verbindung öffnen und schließen“ beschrieben.
- Bezug zu den Threads: `SqlConnection` ist nicht threadsicher. Darum gilt: pro Vorgang eine eigene Verbindung.
- Ausblick: Mit einem Interface `IArtikelRepository` lässt sich die Implementierung später gegen EF Core tauschen. Dazu passt die Konsolen-Demo „DatenzugriffDemo“.
- Übungsaufgabe: `ArtikelRepository` vollständig implementieren.
-->

---
hideInToc: true
---

# Was nervt?

<div class="text-sm">

<v-clicks>

- 😩 Für jede Tabelle dieselben Zeilen: Verbindung, Command, Parameter, Schleife.
- 😩 **Mapping von Hand:** `reader.GetString(reader.GetOrdinal("Bezeichnung"))` für jede Spalte.
- 😩 **SQL steht in Strings.** Ein Tippfehler (`Bezeichung`) fällt erst zur Laufzeit auf.
- 😩 Wird eine Spalte umbenannt, muss man jedes SQL im Projekt suchen.

</v-clicks>

</div>

<div v-click class="mt-6 text-3xl font-bold text-center">
„Geht das nicht besser?“
</div>

<!--
- Zum Zeilenvergleich: Die Methode `AlleArtikel` hat rund 20 Zeilen, davon eine Zeile SQL.
- Den Schmerz bewusst stehen lassen, er ist die Motivation für den Foliensatz „ORM & Entity Framework Core“.
-->


