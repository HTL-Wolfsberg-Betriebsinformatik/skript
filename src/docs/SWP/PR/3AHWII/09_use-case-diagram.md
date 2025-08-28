- Teil der **UML** (Unified Modeling Language)
- Beschreibt das **System aus Sicht der Benutzer **("Akteure")
- Zeigt, **welche Funktionen** (Use-Cases) das System bereitstellt und wer sie verwendet
- **Fokus** liegt nicht auf der technischen Umsetzung, sondern **auf Anforderungen**.

!!! tip "Merke"
    Ein Use-Case-Diagramm beantwortet die Frage:
    „Wer benutzt das System und wofür?“

## Elemente

- Akteure: Personen oder Systeme, die mit unserem System interagieren - dargestellt als Strichmännchen
- Use-Cases (Anwendungsfälle): Funktionen oder Dienste, die das System ausführt - dargestellt als Ovale
- Systemgrenze: Rechteck, das den Rahmen des betrachteten Systems zeigt
- Beziehungen:
    - Assoziation (Linie zwischen Akteur und Use-Case).
    - `<<include>>`: Ein Use-Case enthält einen anderen als Pflichtbestandteil.
    - `<<extend>>`: Ein Use-Case kann optional durch einen anderen erweitert werden

## Beispiel: Online-Shop

**Beschreibung:**
- Akteure: Kunde, Admin
- Use-Cases: Artikel suchen, Artikel kaufen, Artikel verwalten
    - Kunde kann suchen und kaufen
    - Admin kann verwalten

TODO: Add draw.io Use Diagram

see https://www.geeksforgeeks.org/system-design/use-case-diagram/

