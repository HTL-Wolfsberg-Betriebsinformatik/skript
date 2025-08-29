## SQLite-Übung: Tabellen verbinden und abfragen

Die Firma `Nitflex` ist zufrieden mit der bestehenden Datenbank. Momentan sind aber nur Filme in einer Tabelle abgebildet.
Da ein Regisseur mehrere Filme produzieren kann, und dementsprechend oft mit gleichen Namen in der `Movies` Tabelle vorkommen würde, (und es zu Tippfehlern kommen könnte), würden sie gerne eine Alternativvariante voziehen.

**Ziel**: `Nitflex` möchte ihre Regisseure mit Namen, Geburtsdatum und Staatsbürgerschaft in ihre Datenbank aufnehmen, gleichzeitig aber ihre Film-Abfragen mit den Regisseursdaten erweitern.

**Die Lösung:** Der Einsatz von Relationen und `JOIN` Abfragen.

## Lernziele

Die Schülerinnen und Schüler sollen:

- eine weitere Tabelle `Regisseur` erstellen
- Spalten der Tabelle hinzufügen
- die `Movies` Tabelle updaten, sodass die `regisseur` Spalte ein Fremdschlüssel wird
- Datensätze einfügen
- SQL-Abfragen mit `JOIN` durchführen, um wieder den Regisseurnamen zu bekommen
