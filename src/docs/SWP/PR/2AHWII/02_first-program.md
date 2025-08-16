
## CLI (Command Line Interface)

Bevor wir unser erstes Programm schreiben, müssen wir zuerst ein .NET Projekt erstellen.
Ein solches Projekt kann entweder über 

- **Microsoft Visual Studio** (also einer IDE) oder 
- der .NET CLI (Command Line Interface) erstellt werden.


Eine **CLI (Command Line Interface, auf Deutsch: Befehlszeilenoberfläche)** ist eine Textoberfläche, über die man Befehle direkt durch Eingabe von Text in einer Konsole oder einem Terminal ausführt.

- **Bedienung:** Der Benutzer tippt Befehle ein und erhält die Ausgabe ebenfalls als Text.
- **Vorteile:** Schnell, ressourcenschonend, oft mehr Funktionen als grafische Oberflächen.
- **Beispiel:** In Windows die PowerShell oder die Eingabeaufforderung, unter Linux das Terminal.

!!! hint "Hinweis"
    Für .NET-Entwicklung gibt es z. B. das `dotnet`-CLI-Tool, um Projekte zu erstellen, zu bauen und auszuführen.

--- 

## Neues Projekt erstellen

```powershell
dotnet new <TYP> -n <Projektname>
```

| Projekttyp              | CLI-Befehl                | Beschreibung                 |
| ----------------------- | ------------------------- | ---------------------------- |
| **Konsolenanwendung**   | `dotnet new console`      | Einfaches Terminal-Programm  |
| **Klassbibliothek**     | `dotnet new classlib`     | Bibliothek ohne Main-Methode |
| **Web-App (MVC)**       | `dotnet new mvc`          | ASP.NET Core MVC Webprojekt  |
| **Web-API**             | `dotnet new webapi`       | REST-API-Backend             |
| **Blazor Server**       | `dotnet new blazorserver` | Serverseitige Blazor-App     |
| **Blazor WebAssembly**  | `dotnet new blazorwasm`   | Clientseitige Blazor-App     |
| **Worker Service**      | `dotnet new worker`       | Hintergrunddienst            |
| **Testprojekt (xUnit)** | `dotnet new xunit`        | Unit-Test-Projekt            |


Wir starten mit einer **Konsolenanwendung**:

```powershell
dotnet new console -n HelloWorld
```

Nach dem dieser Befehl ausgeführt wurde, wird eine .NET Konsolenanwendung erstellt:

```powershell
Die Vorlage "Konsolen-App" wurde erfolgreich erstellt.

Aktionen nach der Erstellung werden verarbeitet...
Wiederherstellung C:\Users\dwidn\Projects\HTL\PRPE\HelloWorld\HelloWorld.csproj:
Wiederherstellung erfolgreich.
```

### Verzeichnisstruktur

Gehe nun in den `HelloWorld` Ordner. Folgende Ordner/Dateien-Struktur sollte auffindbar sein:
```bash
HelloWorld/
│
├── HelloWorld.csproj     # Projektdatei
├── Program.cs            # Hauptprogramm (Startpunkt)
└── obj/                  # Build-Zwischendateien (vom System erstellt)
```

### Erklärung der einzelnen Elemente

`HelloWorld.csproj`:

- XML-Datei mit den Projekteinstellungen
- Enthält:
    - Ziel-Framework (<TargetFramework>net9.0</TargetFramework>)
    - Abhängigkeiten (NuGet-Pakete)
    - Konfigurationen für Build & Ausführung

Beispielinhalt:

```xml
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net9.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>

</Project>
```

`Program.cs`:

- Startpunkt des Programms
- Standardcode:

```csharp
// Automatisch generiertes Minimalprogramm
Console.WriteLine("Hello, World!");
```

`obj/` Ordner:

- Wird automatisch beim ersten Build angelegt
- Enthält temporäre Dateien, z. B.:
- Kompilierte Zwischenversionen
- Projekt-Cache

!!! hint "Hinweis"
    Dieser Ordner gehört zur Entwicklungsumgebung, wird nicht manuell bearbeitet

`bin/` Ordner

Nach dem ersten `dotnet build` oder `dotnet run` kommt zusätzlich der Ordner `bin/` hinzu:

```bash
bin/
 └── Debug/
     └── net9.0/
         ├── HelloWorld.dll  # Kompilierte Anwendung
         ├── HelloWorld.pdb  # Debug-Infos
         └── ... weitere Laufzeitdateien
```

---

## Erstes Programm

Öffnen wir nun mit dem Windows Editor unser `Program.cs`.

Der Inhalt sollte wie folgt aussehen:

```csharp
// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");
```

**Erklärung:**

- `// See https://...`: Ist nur ein Kommentar, und wird nicht als Teil des Programms ausgeführt 
- `Console.WriteLine()`:  Gibt Text auf der Konsole aus.

### Ausführen des Programms bzw Projektes

Um ein Programm bzw Projekt zu auszühren, benötigen wir folgenden CLI Befehl:

```
dotnet run
```
> Dieser Befehl baut und startet das Projekt in einem Schritt

**Spezifisches Projekt ausführen:**

```
dotnet run --project ./Pfad/Zum/Projekt.csproj
```

### Build (Kompilieren)

**Build** bzw. **kompilieren** bedeutet, den von dir geschriebenen **Quellcode** (Text in einer Programmiersprache wie C#) in **Maschinencode** oder eine **Zwischenform** umzuwandeln, die der Computer ausführen kann.

**Ablauf bei .NET / C#:**

1. Schreiben: Du erstellst C#-Code in .cs-Dateien.
2. Kompilieren: Der C#-Compiler (csc) wandelt den Code in IL-Code (Intermediate Language) um.
3. Build-Prozess: Neben dem Kompilieren werden auch alle benötigten Dateien und Bibliotheken zusammengepackt.
4. Ergebnis: Eine .dll oder .exe im bin/-Ordner.
5. Ausführen: Die .NET-Laufzeit (CLR) übersetzt IL-Code zur Laufzeit in Maschinensprache, die der Prozessor versteht.

!!! hint "Hinweis"
    Kompilieren = Aus Text für Menschen wird Code, den der Computer versteht.

```powershell
dotnet build --configuration Release
```

