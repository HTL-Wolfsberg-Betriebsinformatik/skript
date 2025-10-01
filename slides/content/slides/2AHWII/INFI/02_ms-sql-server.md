---
theme: seriph

title: Microsoft SQL Server – Varianten & CLI
info: Überblick über Editionen, Verbindungen und sqlcmd
background: https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true
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

# Microsoft SQL Server

## Varianten & Arbeiten mit der CLI

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Varianten von Microsoft SQL Server

Wir arbeiten mit **Microsoft SQL Server**. Es gibt unterschiedliche **Editionen**:

- **SQL Server 20XX (Standard/Enterprise)** – kostenpflichtig für produktive Anwendungen  
- **SQL Server 20XX Developer** – volle Funktionen, **gratis** für Entwicklung/Tests  
- **SQL Server 20XX Express** – **gratis** für Entwicklung & kleine Produktionsszenarien  
- **LocalDB** – Lernen, Üben, kleine Tests, **nur lokal** nutzbar

<br/>

> **Merke:** Standard-SQL-Befehle funktionieren in **allen** Editionen.

---

# Vergleich der Editionen

|                        | **LocalDB**                                                                 | **SQL Server Express**                                                               | **SQL Server Developer / Standard**                                                                                    |
| ---------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| **Installation**       | Sehr klein, oft mit Visual Studio                                           | Separate Installation (~200 MB)                                                      | Vollinstallation (GB-Bereich)                                                                                          |
| **Start / Laufzeit**   | Startet bei Bedarf, läuft im Benutzerkontext                                | Läuft als **Windows-Dienst**, immer verfügbar                                       | Läuft als **Windows-Dienst**, dauerhaft verfügbar                                                                      |
| **Verbindung**         | `(localdb)\MSSQLLocalDB` oder eigene Instanz                                | `localhost\SQLEXPRESS` (oder Port 1433)                                             | `localhost` oder `Servername\Instanz`                                                                                  |
| **Typischer Einsatz**  | Lernen, Üben, kleine Testprojekte, Einzelentwickler                         | Kleine Apps, Lernumgebungen, Schulbetrieb, leichte Webserver                        | Produktivsysteme in Firmen; Entwicklung mit allen Features                                                             |
| **Limitierungen**      | Nur **lokal** (kein Netzwerk), max. **10 GB/DB**                            | Max. **10 GB/DB**, ~**1 GB RAM/Instanz**, **1 CPU** (bis 4 Kerne)                   | Developer: keine Limits (nur Dev/Test); Standard/Enterprise: volle Produktivnutzung (lizenzpflichtig)                 |
| **Benutzerverwaltung** | Meist Windows-Login (integrierte Auth)                                      | Windows- und SQL-Logins                                                              | Voll: Windows + SQL-Logins, Rollen, Rechte                                                                             |
| **Verwaltungstools**   | SQLCMD, Visual Studio, SSMS (optional)                                      | SSMS, SQLCMD, Tools                                                                  | SSMS, SQLCMD, alle Admin-Tools                                                                                         |
| **Kosten**             | Kostenlos                                                                    | Kostenlos                                                                            | Developer = kostenlos (Dev/Test); Standard/Enterprise = kostenpflichtig                                                |

---

# Vergleich der Editionen

|                        | **LocalDB**                                                                 | **SQL Server Express**                                                               | **SQL Server Developer / Standard**                                                                                    |
| ---------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| **Limitierungen**      | Nur **lokal** (kein Netzwerk), max. **10 GB/DB**                            | Max. **10 GB/DB**, ~**1 GB RAM/Instanz**, **1 CPU** (bis 4 Kerne)                   | Developer: keine Limits (nur Dev/Test); Standard/Enterprise: volle Produktivnutzung (lizenzpflichtig)                 |
| **Benutzerverwaltung** | Meist Windows-Login (integrierte Auth)                                      | Windows- und SQL-Logins                                                              | Voll: Windows + SQL-Logins, Rollen, Rechte                                                                             |
| **Verwaltungstools**   | SQLCMD, Visual Studio, SSMS (optional)                                      | SSMS, SQLCMD, Tools                                                                  | SSMS, SQLCMD, alle Admin-Tools                                                                                         |
| **Kosten**             | Kostenlos                                                                    | Kostenlos                                                                            | Developer = kostenlos (Dev/Test); Standard/Enterprise = kostenpflichtig                                                |

---

# Zusammenfassung Versionen
- **LocalDB** = „Meine private Spielwiese“ (nur ich, kein Netzwerk).  
- **Express** = „Der kleine Bruder“ (leicht, dauerhaft erreichbar, auch im Netzwerk).  
- **Developer** = „Vollausstattung für Übungszwecke“ (alles drin, nicht produktiv).  
- **Standard/Enterprise** = „Für Firmenbetrieb“ (lizenzpflichtig, produktiv).

---

# Arbeiten mit MS SQL Server (CLI)
Die **CLI** (CMD/PowerShell) erlaubt Verbindungen & Befehle per **`sqlcmd`**.

Prüfen, ob `sqlcmd` installiert ist:
```bash
sqlcmd -?
```

<br/>

> `sqlcmd` ist eine `.exe` Datei, die über den PATH überall verfügbar ist.

---

# LocalDB-Instanz erstellen (optional)

Wenn keine Instanz vorhanden ist, kann eine erstellt werden:

```powershell
sqllocaldb create yourDBInstanceName
sqllocaldb start  yourDBInstanceName
```

<br>

> 💡 Anstatt `yourDBInstanceName` nimm den Namen deiner Klasse (e.g. `2AHWII`)

**Beispiel:**

```powershell
sqllocaldb create 2AHWII
sqllocaldb start 2AHWII
```

---

# SQL Skripte schreiben

Befehle werden in `.sql` Dateien gespeichert, damit sie persistent sind und bei Bedarf wieder ausgeführt werden können

**Beispiel: Datenbank erstellen**

```sql [create_database.sql]
CREATE DATABASE Filmverwaltung;
```

**Beispiel: Tabelle in Datenbank erstellen**

```sql [create-movie-table.sql]
CREATE TABLE Movies (
  movie_id INT PRIMARY KEY,         -- eindeutiger Schlüssel
  title NVARCHAR(100) NOT NULL,     -- Pflichtfeld
  genre NVARCHAR(50),
  duration_in_minutes INT,
  published DATE,
  has_oscar BIT,
  rating DECIMAL(3,1)
);
```

---

# SQL Befehle an die Instanz schicken

Direkt aus der **CMD / PowerShell**: 

```powershell
# Datenbank anlegen (e.g. Filmverwaltung)
sqlcmd -S "(localdb)\yourDBInstanceName" -i create_database.sql

# SQL Befehle an eine bereits erstellte Datenbank senden
sqlcmd -S "(localdb)\yourDBInstanceName" -d Filmverwaltung -i create_movie_table.sql
```

<br>

- `-i` ist ein Parameter der eine `.sql` Datei bzw Pfad zur Datei erwartet.
- Die Konsole muss sich also in dem Verzeichnis befinden wo die Datei liegt, damit nur der Dateiname angegeben werden muss.
- `-d` ist ein Parameter der den Datenbanknamen erwartet. Ansonsten weiß es nicht in welcher Datenbank er z.B. eine Tabelle erstellen soll.


