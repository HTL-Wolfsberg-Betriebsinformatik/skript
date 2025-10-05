
Wir arbeiten mit **Microsoft SQL Server**. Es gibt **unterschiedliche Versionen** von diesem **Datenbanksystem**:

- SQL Server 20XX: volle kostenpflichtige Version für produktive Anwendungen
- SQL Server 20XX: volle gratis Version für reine Entwicklungszwecke
- SQL Server 20XX Express: Gratis Version für Entwicklung und Produktion von Desktop, Web und kleine Server Applikation
- LocalDB: Lernen, Üben, kleine Testprojekte, Einzelentwickler. Nur lokal nutzbar.

!!! tip "Merke"
    Egal welche Version verwendet wird, die Standard SQL Befehle funktioneren in jeder Version.

## Vergleich Versionen

| Merkmal                | **LocalDB**                                                                 | **SQL Server Express**                                                               | **SQL Server Developer / Standard**                                                                                    |
| ---------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| **Installation**       | Sehr klein, wird oft mit Visual Studio installiert                          | Separate Installation (ca. 200 MB)                                                   | Vollinstallation (GB-Bereich)                                                                                          |
| **Start / Laufzeit**   | Startet nur, wenn eine App/Verbindung sie braucht; läuft im Benutzerkontext | Läuft als **Windows-Dienst**, immer verfügbar                                        | Läuft als **Windows-Dienst**, dauerhaft verfügbar                                                                      |
| **Verbindung**         | `(localdb)\MSSQLLocalDB` oder eigene Instanz                                | `localhost\SQLEXPRESS` (oder per Port 1433)                                          | `localhost` oder `Servername\Instanz`                                                                                  |
| **Typischer Einsatz**  | Lernen, Üben, kleine Testprojekte, Einzelentwickler                         | Kleine Anwendungen, Lernumgebungen, Schulbetrieb, Webserver mit wenig Last           | Produktivsysteme in Firmen, Entwicklung mit allen Features                                                             |
| **Limitierungen**      | - Nur **lokal** nutzbar (kein Netzwerkzugriff)<br>- Max. 10 GB pro DB       | - Max. 10 GB pro DB<br>- Max. 1 GB RAM pro Instanz<br>- 1 CPU (max. 4 Kerne genutzt) | Developer: keine Limits, aber nur für Entwicklung/Tests<br>Standard/Enterprise: volle Produktivnutzung, je nach Lizenz |
| **Benutzerverwaltung** | Meist nur Windows-Login (integrierte Auth)                                  | Windows- und SQL-Logins                                                              | Vollumfänglich: Windows + SQL-Logins, Rollen, Rechte                                                                   |
| **Verwaltungstools**   | SQLCMD, Visual Studio, SSMS (optional)                                      | SSMS, SQLCMD, Tools                                                                  | SSMS, SQLCMD, alle Admin-Tools                                                                                         |
| **Kosten**             | Kostenlos                                                                   | Kostenlos                                                                            | Developer = kostenlos (nur Dev/Test)<br>Standard/Enterprise = kostenpflichtig                                          |


## Zusammenfassung Versionen

- **LocalDB** = „Meine private Spielwiese“ (nur ich, kein Netzwerk).
- **Express** = „Der kleine Bruder“ (leicht, aber dauerhaft erreichbar, auch im Netzwerk).
- **Developer** = „Vollausstattung für Übungszwecke“ (alles drin, aber nicht produktiv).
- **Standard/Enterprise** = „Für Firmen und Rechenzentren“ (teuer, aber für den echten Betrieb).


## Arbeiten mit MS SQL Server

### CLI (Command Line Interface)

Über die **CLI**, welche in Windows über **CMD (Kommandozeile)** oder **PowerShell** erreichbar ist, kann eine Verbindung zu MS SQL Server aufgebaut werden.

Dazu muss das Tool `sqlcmd` installiert sein.

Ob das Tool installiert ist kann über folgenden Befehl herausgefunden werden:

```bash
sqlcmd -?
```

Ausgabe
```bash
Microsoft (R) SQL Server Command Line Tool
Version 16.0.1000.6 NT
Copyright (C) 2022 Microsoft Corporation. All rights reserved.

...
```

`sqlcmd` ist einfach eine `.exe` Datei, welche in den Umgebungsvariablen hinzugefügt wurde, damit sie von überall ausführbar ist.


!!! tip "Tipp"
    `sqlcmd` kommt mit der SQL Server Installation (oder kann separat über die *SQL Server Command Line Utilities* installiert werden).


### LocalDB Instanz erstellen (optional)

Sofern es noch keine **lokale Instanz** gibt, bzw keine **MS SQL Server Express / Developer / Standard** installiert ist und man damit arbeiten möchte, kann diese **erstellt** werden.
Dazu benutzen wir den `sqllocaldb` Befehl.

```
sqllocaldb create <yourDBInstanceName>
```

Nachdem erstellen, muss diese **gestartet werden** um sich zu verbinden:

```
sqllocaldb start <yourDBInstanceName>
```

Um zu sehen, dass der lokale Datenbank Server **läuft**, kann folgender Befehl ausgeführt werden:

```
sqlcmd -S (localdb)\<yourDBInstanceName> -Q "SELECT @@VERSION;"
```

Ausgabe:

```bash
Microsoft SQL Server 2019 (RTM-CU27-GDR) (KB5040948) - 15.0.4382.1 (X64)
        Jul  1 2024 20:03:23
        Copyright (C) 2019 Microsoft Corporation
        Express Edition (64-bit) on Windows 10 Pro 10.0 <X64> (Build 26100: ) (Hypervisor)


(1 rows affected)
```

### Verbinden zu einer Instanz

Um sich mit einer Instanz zu verbinden, muss je nach MS SQL Version der `sqlcmd` Tool mit bestimmten Parametern ausgeführt werden:

```powershell
# Standardinstanz
sqlcmd -S localhost -E

# Expressinstanz
sqlcmd -S localhost\SQLEXPRESS -E

# Custom Instanz "<yourDBInstanceName>"
sqlcmd -S (localdb)\<yourDBInstanceName> -E
```

!!! tip "Merke"
    - `-S` ist ein Parameter und steht für "Server". Also welcher Server verwendet werden soll (e.g. `-S localhost\SQLEXPRESS`)
    - `-E` ist ein Parameter und steht für "trusted connection". Dieser benutzt die *Windows Authentifizierung*. 
    - Anstatt `-E` kann auch `-U/-P` verwendet und steht für **username** und **password**. e.g. `sqlcmd -S localhost -U sa -P MeinPasswort`

### Wechseln zwischen Instanzen

- Man kann nicht innerhalb von sqlcmd einfach sagen „wechsel die Instanz“.
- Stattdessen muss die Verbindung getrennt und eine neue Verbindung aufgebaut werden:

```powershell
EXIT    -- beendet die aktuelle sqlcmd-Sitzung

sqlcmd -S localhost\AndereInstanz -E
```

### SQL Befehle an Instanz schicken

!!! note "Info"
    **SQL Befehle** werden in späteren Kapiteln erklärt, die Beispiele dienen zur Verständnis wie der Server Befehle empfängt.

**Direkte Befehle in einer Instanz:**

Sobald eine Verbindung erfolgreich hergestellt ist, siehst du einen **Prompt**:

```shell
1>
```

`1>` bedeutet in dem Fall, dass die Instanz nun bereit ist den **ersten Befehl** einzulesen.

Beispiel:

```shell
1> CREATE DATABASE Schule;
```

!!! warning "Achtung"
    Befehle enden mit einem Strichpunkt `;`. Wenn dieser vergessen wird, weiß `SQL` nicht dass der Befehl abgeschlossen ist.
 
Sobald man ++Enter++ drückt, erscheint eine neue Zeile mit fortlaufender Nummerierung:

```shell
1> CREATE DATABASE Schule;
2>
```

Um den Befehl auszuführen, sendet man `GO`.

```shell
1> CREATE DATABASE Schule;
2> GO
```

> Danach startet der Prompt wieder bei `1>`.

**Befehle von außerhalb:** 

Um Befehle an die Datenbank Instanz zu senden ohne sich bereits verbunden zu haben, wird wieder der `sqlcmd` Befehl verwendet:

```bash
# Erstellt eine Datenbank in der Instanz namens "Nitflex"
sqlcmd -S "(localdb)\NewMSQLLocalDB" -Q "CREATE DATABASE Nitflex;"

# Erstellt eine Tabelle namens "Movie" in der "Nitflex" Datenbank
sqlcmd -S "(localdb)\NewMSQLLocalDB" -d Nitflex -Q "CREATE TABLE Movie(Id int);"

# Anstelle von direkten Befehlen, kann auch eine Datei die diese Befehle beinhaltet verwendet werden (-i steht für inputfile)
sqlcmd -S "(localdb)\NewMSQLLocalDB" -i create_db.sql
```

### Good to Know

Mit dem Befehl `sqlcmd -?` werden die Paramater des kurz Tools erklärt

```powershell
usage: Sqlcmd            [-U login id]          [-P password]
  [-S server]            [-H hostname]          [-E trusted connection]
  [-N Encrypt Connection][-C Trust Server Certificate]
  [-d use database name] [-l login timeout]     [-t query timeout]
  [-h headers]           [-s colseparator]      [-w screen width]
  [-a packetsize]        [-e echo input]        [-I Enable Quoted Identifiers]
  [-c cmdend]            [-L[c] list servers[clean output]]
  [-q "cmdline query"]   [-Q "cmdline query" and exit]
  [-m errorlevel]        [-V severitylevel]     [-W remove trailing spaces]
  [-u unicode output]    [-r[0|1] msgs to stderr]
  [-i inputfile]         [-o outputfile]        [-z new password]
  [-f <codepage> | i:<codepage>[,o:<codepage>]] [-Z new password and exit]
  [-k[1|2] remove[replace] control characters]
  [-y variable length type display width]
  [-Y fixed length type display width]
  [-p[1] print statistics[colon format]]
  [-R use client regional setting]
  [-K application intent]
  [-M multisubnet failover]
  [-b On error batch abort]
  [-v var = "value"...]  [-A dedicated admin connection]
  [-X[1] disable commands, startup script, environment variables [and exit]]
  [-x disable variable substitution]
  [-j Print raw error messages]
  [-g enable column encryption]
  [-G use Azure Active Directory for authentication]
  [-? show syntax summary]
```












