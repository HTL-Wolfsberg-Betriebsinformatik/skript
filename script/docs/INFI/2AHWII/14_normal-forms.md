## Definition

- Normalformen vermeiden Redundanzen und Anomalien (Einfüge-, Änderungs-, Löschanomalien).

## 3 Ebenen von Normalformen

1. Normalform (1NF)

**Regel:** Alle Attribute sind atomar (keine Listen/Felder in Feldern).

**Anti-Beispiel:** `Movie(genres TEXT)` mit „Action, Sci-Fi“ in einer Spalte.
**Fix:** eigene Tabelle `MovieGenre` (`m:n`).

2. Normalform (2NF)

**Regel:** Keine teilweise Abhängigkeit von einem Teil eines zusammengesetzten Schlüssels.

**Anti-Beispiel:** `Casting(movie_id, actor_id, character_name, movie_title)`, `movie_title` hängt nur von `movie_id` → Verstoß.
**Fix:** `movie_title` gehört in `Movie`.

3. Normalform (3NF)

**Regel:** Keine transitive Abhängigkeit von einem Nichtschlüsselattribut.

**Anti-Beispiel:** `Movie(movie_id, ..., studio_id, studio_name)`, `studio_name` hängt über `studio_id` → transitiv.
**Fix:** `Studio(studio_id, studio_name)` und `Movie(..., studio_id FK)`.