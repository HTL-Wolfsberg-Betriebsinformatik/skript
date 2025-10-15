## Lernziele

- Erstellen eines **kompletten Datenbankprojekts** von der Analyse bis zur Umsetzung  
- Anwenden von **ER-Modellierung**, **Relationsschema** und **SQL-Befehlen**  
- Üben von **`ALTER TABLE`**, um Tabellen nachträglich zu erweitern oder zu ändern  
- Arbeiten mit **Subqueries** statt JOINs  
- Verständnis von **Beziehungen, Kardinalitäten** und **Schlüsseln**  

---

## Aufgabe

Du arbeitest im Forschungslabor **„Prof. Linden Systems“**, das eine Datenbank für ein digitales **Pocketmonster-Register** entwickelt.  
Diese Datenbank soll Informationen über **Pocketmonster**, **Attacken**, **Elementtypen**, **Trainer** und **Teams** speichern.

Ziel ist es, ein funktionierendes Datenbanksystem zu entwerfen, umzusetzen und anschließend **nachträglich zu erweitern**.

---

## Projektsituation

In der Welt der **Pocketmonster** gibt es viele verschiedene Arten.  
Jedes Pocketmonster hat einen **Namen** und bestimmte **Basiswerte**, wie **Lebenspunkte**, **Angriff** und **Verteidigung**.  
Ein Pocketmonster kann einem oder mehreren **Elementtypen** zugeordnet sein (z. B. Feuer, Wasser, Elektro).

Pocketmonster können verschiedene **Attacken** erlernen.  
Eine Attacke hat einen **Namen**, eine **Kategorie** (z. B. „Physisch“, „Spezial“ oder „Status“) und eine **Stärke**.  
Einige Attacken werden erst **ab einem bestimmten Level** gelernt.

Viele Pocketmonster **entwickeln sich** im Laufe des Trainings.  
Dabei entsteht aus einem Pocketmonster ein neues, stärkeres.  
In der Datenbank soll festgehalten werden, **welches Pocketmonster sich in welches entwickelt** und **ab welchem Level** dies geschieht.

Pocketmonster gehören zu **Trainern**, die sie fangen und trainieren.  
Jeder Trainer hat einen **Spitznamen** und kommt aus einer bestimmten **Region**.  
Ein Trainer kann mehrere **Teams** besitzen (z. B. ein Hauptteam und ein Ersatzteam).  
Ein Team besteht aus bis zu **sechs Pocketmonstern**, die im Team eine **Position** (1–6) haben.  
Ein Pocketmonster kann im Team zusätzlich einen **Spitznamen** haben.

---

## Arbeitsschritte

1. **Analyse des Textes**  
   - Finde alle wichtigen **Entitäten** (z. B. Pocketmonster, Trainer, Team, Typ, Attacke …).  
   - Überlege dir sinnvolle **Attribute**, **Primärschlüssel** und **Beziehungen** (mit Kardinalitäten).  

2. **ER-Diagramm erstellen**  
   - Verwende Chen-Notation oder Crow’s-Foot-Notation.  
   - Kennzeichne Primärschlüssel, Fremdschlüssel und Beziehungstypen.  
   - Überlege, wie du die **Entwicklung** als Selbstbeziehung darstellen kannst.

3. **Relationsschema ableiten**  
   - Übertrage dein Modell in Tabellenform.  
   - Definiere Primär- und Fremdschlüssel.  
   - Lege Zwischentabellen für n:m-Beziehungen an.  

4. **SQL-Datenbank erstellen**  
   - Erstelle alle Tabellen mit `CREATE TABLE`.  
   - Verwende sinnvolle Datentypen und Constraints (`NOT NULL`, `CHECK`, `UNIQUE`).  
   - Füge mehrere **Beispiel-Datensätze** pro Tabelle ein (`INSERT INTO`).  

5. **Tabellen anpassen mit ALTER TABLE**  
   - Ergänze neue Anforderungen nachträglich:  
     - **Beispiel 1:** Füge bei Pocketmonster ein neues Attribut `height` (Größe in Metern) hinzu.  
     - **Beispiel 2:** Erweitere die Attacken-Tabelle um ein Attribut `accuracy` (Treffsicherheit).  
     - **Beispiel 3:** Ergänze bei Trainern eine Spalte `birthyear` (Geburtsjahr).  
     - **Beispiel 4:** Füge in der Team-Tabelle eine Fremdschlüssel-Beziehung zur Region hinzu, falls du Regionen als eigene Tabelle modellierst.  
   - Teste deine Änderungen, indem du neue Daten einfügst oder bestehende aktualisierst.  

6. **SQL-Abfragen**  
   - Verwende `IN`, `EXISTS`, `NOT IN`, `GROUP BY`, `ORDER BY`, `UPDATE`, `DELETE`, usw.  
   - Beispielhafte Fragestellungen:  
     - Finde alle Pocketmonster eines bestimmten Typs.  
     - Zeige alle Attacken eines Pocketmonsters mit Mindestlevel.  
     - Finde Pocketmonster, die sich entwickeln.  
     - Zähle Pocketmonster pro Elementtyp.  
     - Zeige alle Teams eines Trainers.  
     - Aktualisiere Werte (z. B. füge `height` für ein Pocketmonster hinzu).  

---

## Erweiterungsideen

- Füge eine neue Entität **Region** hinzu und verknüpfe sie mit den Trainern.  
- Ergänze ein Attribut **Legendary** (BOOLEAN) in der Pocketmonster-Tabelle, um legendäre Wesen zu kennzeichnen.  
- Ändere den Datentyp eines Attributs mit `ALTER TABLE ... ALTER COLUMN ...`.  
- Füge zusätzliche **Constraints** hinzu (z. B. `CHECK (height > 0)` oder `birthyear BETWEEN 1950 AND 2020`).  

---

## Abgabe

- ER-Diagramm (digital oder Foto, z. B. draw.io)  
- SQL-Skript mit  
  - `CREATE TABLE`  
  - `INSERT INTO`  
  - mehreren `ALTER TABLE`-Befehlen  
- 5–8 eigene SQL-Abfragen  
- Kurze Reflexion (Was war schwierig? Welche Änderungen hast du mit `ALTER TABLE` durchgeführt?)  

---

## Reflexionsfragen

- Welche Änderungen hast du an deiner Datenbankstruktur vorgenommen?  
- Wann ist es sinnvoll, `ALTER TABLE` zu verwenden?  
- Kannst du erkennen, welche Pocketmonster sich entwickeln und zu wem?  
- Kannst du sehen, welche Attacken ein Pocketmonster beherrscht?  
- Kannst du Teams und deren Trainer abfragen?  
- Welche Vorteile bringt eine klare Struktur bei der Erweiterung einer Datenbank?  
