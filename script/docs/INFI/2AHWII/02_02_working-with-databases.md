
## Wie wird mit Datenbanken gearbeitet

### Verbinden zu einer Datenbank

- Eine **Datenbank** ist wie ein **zentraler Speicherort für Informationen** (z. B. Schülerlisten, Noten, Bücher in einer Bibliothek).
- Damit wir **Daten einfügen** oder **Fragen an diese Daten** stellen können  ("Füge Schüler X ein mit Name und Geburtsdatum", "Gib mir alle Schüler, die am 12.04. geboren sind“), brauchen wir eine **Sprache (SQL)**.
- Damit wir diese Sprache überhaupt an die Datenbank schicken können, brauchen wir eine **Verbindung**.

!!! tip "Vergleich"
    Wenn wir jemandem eine Nachricht schreiben willst, brauchen wir erst einen Chat-Kanal, bevor wir reden kannst.

### Lokale vs Remote Datenbank

- In Firmen steht der Datenbankserver meist auf einem **eigenen Rechner im Serverraum** oder in der **Cloud** (Remote Datenbank).
- In der Schule (und am eigenen PC) starten wir mit einer lokalen Instanz:
    - Das ist ein kleines **Server-Programm**, das bei dir im Hintergrund läuft.
    - Du bist also gleichzeitig **Datenbank-Administrator und Benutzer**.
    - **Vorteil:** Jeder kann **frei üben**, Datenbanken erstellen, löschen, Tabellen anlegen - ohne dass man eine zentrale Firmendatenbank kaputt macht.


### Instanzen 

- Eine **Instanz** ist so etwas wie ein „Datenbank-Server-Programm“.
- Nur wenn die Verbindung klappt, können wir **SQL-Befehle** senden.

## Zusammenfassung

1. Verbinden: "Hallo Server, darf ich mit dir reden?"
2. Datenbank auswählen: "Ich möchte mit der Schule-DB arbeiten."
3. Befehle ausführen: "Bitte zeige mir alle Schüler."
4. Antwort bekommen: Der Server schickt die Tabelle zurück

!!! tip "Merke"
    Ohne Verbindung keine Daten.
    Die Datenbank ist ein eigenes Programm, wir sind nur Gäste – und brauchen erst die Tür (die Verbindung), bevor wir hineingehen und Fragen stellen dürfen.
