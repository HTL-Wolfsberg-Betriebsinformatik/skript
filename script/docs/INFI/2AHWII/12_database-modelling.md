## Definition

**Datenbankmodellierung** übersetzt die Fachdomäne in eine klare, widerspruchsfreie Datenstruktur. Statt sofort SQL zu schreiben, halten wir in einem Modell die Dinge (Entitäten) und ihre Beziehungen fest und leiten daraus das Relationenschema ab. Ein gutes Modell vermeidet Redundanz, macht Regeln sichtbar und erleichtert Abfragen sowie spätere Erweiterungen. Kurz: erst modellieren (konzeptuell), dann in Tabellen überführen (logisch), zuletzt im DBMS umsetzen (physisch).

**Ziele und Vortieile:**

- **Klarheit:** Begriffe, Regeln und Zusammenhänge der Domäne werden explizit.
- **Qualität:** Weniger Redundanz, weniger Anomalien → konsistente Daten.
- **Erweiterbarkeit:** Neue Anforderungen lassen sich gezielt einbauen.
- **Kommunikation:** Gemeinsame Sprache zwischen Fachbereich & Entwicklern.
- **Leistung:** Ein gutes Schema erleichtert Indizierung & effiziente Abfragen.

**Nachteile / Trade-offs:**

- Initialer Aufwand (Workshops, Entwurf, Iterationen).
- Zu frühe Festlegung kann Flexibilität einschränken (→ deshalb iterativ vorgehen).

## Schritte der Modellierung

1. Konzeptuell: Was gibt es?
    - ER-Modell (Entity Relation): Entitäten, Attribute, Beziehungen, Kardinalitäten
2. Logisch: Wie in Relationen umwandeln?
    - Tabelle, Primär/Fremdschlüssel, Normalformen
3. Physisch: Wie tragen wir es ins DBMS ein?
    - Datentypen, Indizes, ...
