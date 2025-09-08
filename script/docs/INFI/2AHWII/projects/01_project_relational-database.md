# Projekt „Entwickle eine relationale Datenbank“

## Aufgabe

Eine Organisation benötigt eine relationale Datenbank, um ihre Daten strukturiert zu verwalten.  

Der Auftraggeber ist nicht besonders IT-affin und möchte eine **einfach verständliche Datenbank**, die später auch von nicht-technischen Mitarbeitern genutzt werden kann.  
Die Schüler:innen übernehmen die Aufgabe, eine geeignete Datenbank zu planen, umzusetzen und mit Beispieldaten zu befüllen.  

Am Ende des Projektes muss es eine **Übergabe** geben:  
- **mündlich**: Präsentation der Datenbank (Struktur, Beispielabfragen)  
- **schriftlich**: Ein Handover-Dokument, in dem Aufbau und Nutzung der Datenbank erklärt werden  

Die Datenbank wird **lokal** erstellt (z. B. mit SQLite oder SQL Server). Ein Web-Frontend ist nicht notwendig.  

---

## Mindestanforderung

- Mindestens **5–6 Tabellen** mit passenden Beziehungen (1:n oder m:n)  
- Verwendung von **Primär- und Fremdschlüsseln**  
- Anlegen und Befüllen der Tabellen mit **mindestens 20–30 Datensätzen**  
- Umsetzung von **Beispielabfragen**, darunter:  
  - einfaches Filtern und Sortieren (`WHERE`, `ORDER BY`)  
  - mindestens 1 **JOIN-Abfrage**  
  - mindestens 1 **Aggregatfunktion** mit `GROUP BY` und `HAVING`  
- Dokumentation der Tabellenstruktur (z. B. mit ER-Diagramm)  
- Schriftliche und mündliche Übergabe  

---

## Iterative Arbeitsphasen

**Recherchephase**

- Schüler:innen erarbeiten selbst Grundlagen (Unterlagen, YouTube, ChatGPT, Online-Tutorials)  
- Lehrer:in unterstützt bei Bedarf  

**Modellierungsphase**

- Erstellung eines ER-Diagramms  
- Festlegung von Tabellen, Attributen, Schlüsseln und Beziehungen  

**Umsetzungsphase**

- Erstellung der Tabellen mit `CREATE TABLE`  
- Befüllen der Datenbank mit Beispieldaten  
- Schreiben von Abfragen (einfache bis komplexere)  

**Feedback-Schleifen**

- Zwischenstatus präsentationen zu Beginn der Stunde
- Lehrer:in dient als Mentor  

**Dokumentation**

- Kurzes Reflexionsdokument pro Schüler:  
  - Welche Tabellen/Beziehungen habe ich erstellt?  
  - Warum habe ich diese Struktur gewählt?  
  - Welche Abfragen habe ich umgesetzt?  
  - Was habe ich Neues gelernt?  
  - Welche Probleme gab es und wie habe ich sie gelöst?  
  - Welchen Beitrag habe ich geleistet?  

---

## Abschlusspräsentation

- Jede:r Schüler:in präsentiert ihre Datenbank:  
  - ER-Diagramm erklären  
  - Tabellenstruktur vorstellen  
  - Beispielabfragen live zeigen und erläutern  
  - Reflexion: „Was würden wir nächstes Mal anders machen?“  

- **Q&A-Session**: Verständnis und Begründungen abfragen  

---

## Bewertungskriterien

- **Funktionalität**: Läuft die Datenbank, funktionieren Abfragen fehlerfrei?  
- **Struktur**: Saubere Modellierung mit Primär- und Fremdschlüsseln, Normalisierung eingehalten  
- **Abfragen**: Vielfalt (JOINs, Aggregatfunktionen), Korrektheit, Verständlichkeit  
- **Dokumentation**: Vollständigkeit und Nachvollziehbarkeit  
- **Selbstständigkeit und Reflexion**: Können die Schüler:innen erklären, was sie gemacht haben?  
- **Präsentation und Übergabe**: Klarheit, Fachsprache, Nachvollziehbarkeit 


## Themenwahl

### Pokedex

Wir brauchen eine Datenbank, um alle bekannten Pokémon zu verwalten. Jedes Pokémon hat mindestens einen Typ (z. B. Feuer, Wasser), teilweise auch zwei. Außerdem soll gespeichert werden, welche Attacken es beherrscht, mit Angabe von Stärke und Typ der Attacke. Manche Pokémon können sich zu anderen weiterentwickeln – diese Beziehungen sollten auch abgebildet werden. Wir möchten später Abfragen machen wie: ‚Zeig mir alle Wasser-Pokémon mit mehr als 50 Angriffspunkten‘ oder ‚Welche Attacken gehören zum Typ Elektro?‘.


### Bibliothek

Unsere Bibliothek verwaltet Bücher, Zeitschriften und andere Medien. Für jedes Buch möchten wir Titel, Autor(en), Verlag und Erscheinungsjahr speichern. Außerdem haben wir Mitglieder, die Medien ausleihen können. Für jede Ausleihe soll festgehalten werden, welches Medium ausgeliehen wurde, von welchem Mitglied und wann es zurückgegeben werden muss. Wichtig wäre auch eine Abfrage: ‚Welche Bücher sind gerade verliehen?‘ oder ‚Welche Mitglieder haben ihre Medien überzogen?‘.


### Online-Shop


Wir möchten eine Datenbank für unseren kleinen Online-Shop. Wir verkaufen Produkte, die jeweils einer Kategorie angehören (z. B. Kleidung, Elektronik). Zu jedem Produkt speichern wir Preis, Bestand und Hersteller. Kunden können Bestellungen machen, die mehrere Produkte enthalten können. Zu jeder Bestellung brauchen wir Informationen wie Bestelldatum, Lieferadresse und Zahlungsstatus. Wir wollen zum Beispiel Abfragen wie: ‚Welche Kunden haben im letzten Monat bestellt?‘ oder ‚Welche Produkte sind fast ausverkauft?‘.

### Schulverwaltung

An unserer Schule möchten wir Schüler, Lehrer, Klassen und Fächer in einer Datenbank verwalten. Jeder Schüler gehört zu einer Klasse, und jede Klasse hat mehrere Fächer. Lehrer unterrichten bestimmte Fächer in bestimmten Klassen. Außerdem soll es möglich sein, Noten für Schüler in den Fächern zu speichern. Abfragen könnten sein: ‚Welche Schüler sind in der Klasse 2AHIT?‘ oder ‚Welche Lehrer unterrichten das Fach Datenbanken?‘.

### Fußballverein

Unser Verein hat mehrere Teams, z. B. eine U14-, eine U18- und eine Kampfmannschaft. Jedes Team hat Spieler, die eine Position (z. B. Torwart, Verteidiger, Stürmer) spielen. Wir wollen Spiele verwalten, bei denen ein Team gegen ein anderes antritt, mit Ergebnis und Datum. Für die Spieler möchten wir auch Statistiken erfassen, wie erzielte Tore. Abfragen wären z. B.: ‚Welche Spiele hat die U18 in diesem Jahr gewonnen?‘ oder ‚Wer sind die besten Torschützen des Vereins?‘.

### Fitnesscenter

Unser Fitnesscenter möchte Mitglieder, Trainer und Kurse in einer Datenbank verwalten. Jedes Mitglied hat einen Mitgliedsvertrag mit Startdatum und Monatsbeitrag. Trainer geben verschiedene Kurse, z. B. Yoga, Spinning oder Krafttraining. Mitglieder können sich zu Kursen anmelden. Außerdem soll gespeichert werden, ob jemand ein Tages-Ticket oder eine Dauer-Mitgliedschaft hat. Typische Abfragen wären: ‚Welche Mitglieder haben im September an Kursen teilgenommen?‘ oder ‚Welche Trainer geben mehr als zwei Kurse?‘