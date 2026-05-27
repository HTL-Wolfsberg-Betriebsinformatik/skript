---
theme: seriph
routerMode: hash
title: 13 HTML Formulare
info: |
  ## 13 HTML Formulare
background: https://raw.githubusercontent.com/HTL-Wolfsberg-Betriebsinformatik/skript/refs/heads/main/slides/content/slides/background-cover-16-9.webp
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

# HTML Formulare

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" columns="1" />

<style global>
.slidev-layout input,
.slidev-layout select,
.slidev-layout textarea {
  all: revert;
}
</style>

---

# Was sind HTML-Formulare?

HTML-Formulare ermöglichen es, **Daten vom Nutzer zu sammeln** und an einen Server zu senden.

<br>

**Beispiele aus dem Alltag:**

- Login-Formular (Benutzername + Passwort)
- Registrierungsformular (Name, E-Mail, …)
- Suchfeld (z. B. Google-Suche)
- Kontaktformular
- Bestellformular in einem Onlineshop

<br>

> Formulare sind die wichtigste Methode, um Nutzereingaben zu verarbeiten.

---

# Das `<input>`-Element

Das universellste Eingabeelement in HTML — ein **selbstschließendes** Tag.

```html
<input type="text" name="vorname" placeholder="Dein Vorname">
```

<br>

| Attribut | Bedeutung |
|----------|-----------|
| `type` | Art des Eingabefeldes (`text`, `password`, `email`, …) |
| `name` | Name des Feldes — wird mit dem Wert an den Server gesendet |
| `placeholder` | Hinweis-Text im leeren Feld |
| `value` | Vorausgefüllter Wert |
| `required` | Feld muss ausgefüllt werden |
| `id` | Verbindet das Feld mit einem `<label>` |

---
layout: two-cols
layoutClass: gap-16
---

# Labels

Das `<label>`-Element **beschriftet** ein Eingabefeld.

```html
<label for="name">Name:</label>
<input type="text" id="name" name="name">
```

<br>

- `for` muss mit der `id` des Inputs übereinstimmen
- Klick auf das Label → Fokus springt ins Feld
- Wichtig für **Barrierefreiheit** (Screenreader)

::right::

<div class="demo-area">
  <label for="d-name">Name:</label><br>
  <input type="text" id="d-name" name="name" placeholder="Dein Name">
  <br><br>
  <small>👆 Klicke auf "Name:" — das Eingabefeld wird fokussiert</small>
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

## Textfeld & Passwort

```html
<!-- Einzeiliger Text -->
<label for="user">Benutzername:</label>
<input type="text" id="user" name="user"
       placeholder="z. B. max.mustermann">

<!-- Passwort (verdeckt) -->
<label for="pass">Passwort:</label>
<input type="password" id="pass" name="pass"
       placeholder="Mindestens 8 Zeichen">
```

<br>

- `type="text"` → normaler Text
- `type="password"` → Eingabe wird als **•••** angezeigt

::right::

<div class="demo-area">
  <label for="d-user">Benutzername:</label><br>
  <input type="text" id="d-user" name="user" placeholder="z. B. max.mustermann">
  <br><br>
  <label for="d-pass">Passwort:</label><br>
  <input type="password" id="d-pass" name="pass" placeholder="Mindestens 8 Zeichen">
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

## E-Mail & Zahl

```html
<!-- E-Mail mit Browser-Validierung -->
<label for="email">E-Mail:</label>
<input type="email" id="email" name="email"
       placeholder="name@example.com">

<!-- Zahl mit Wertebereich -->
<label for="age">Alter:</label>
<input type="number" id="age" name="age"
       min="0" max="120" value="18">
```

<br>

- `type="email"` → Browser prüft das E-Mail-Format
- `type="number"` → nur Zahlen erlaubt
- `min` / `max` → erlaubter Wertebereich

::right::

<div class="demo-area">
  <label for="d-email">E-Mail:</label><br>
  <input type="email" id="d-email" name="email" placeholder="name@example.com">
  <br><br>
  <label for="d-age">Alter:</label><br>
  <input type="number" id="d-age" name="age" min="0" max="120" value="18">
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

## Datum & Uhrzeit

```html
<!-- Datum -->
<label for="bday">Geburtsdatum:</label>
<input type="date" id="bday" name="bday">

<!-- Uhrzeit -->
<label for="time">Uhrzeit:</label>
<input type="time" id="time" name="time">

<!-- Datum + Uhrzeit kombiniert -->
<label for="termin">Termin:</label>
<input type="datetime-local" id="termin"
       name="termin">
```

::right::

<div class="demo-area">
  <label for="d-bday">Geburtsdatum:</label><br>
  <input type="date" id="d-bday" name="bday">
  <br><br>
  <label for="d-time">Uhrzeit:</label><br>
  <input type="time" id="d-time" name="time">
  <br><br>
  <label for="d-termin">Termin:</label><br>
  <input type="datetime-local" id="d-termin" name="termin">
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

## Checkboxen

Ermöglichen **mehrere Auswahlmöglichkeiten** gleichzeitig.

```html
<label>
  <input type="checkbox" name="sport"
         value="fussball">
  Fußball
</label>

<label>
  <input type="checkbox" name="sport"
         value="tennis">
  Tennis
</label>
```

<br>

- Gleicher `name` → selbe Gruppe
- `value` bestimmt, was an den Server gesendet wird
- Mehrere können gleichzeitig ausgewählt sein

::right::

<div class="demo-area">
  <strong>Sportarten (mehrere möglich):</strong><br><br>
  <label><input type="checkbox" name="sport" value="fussball"> Fußball</label><br>
  <label><input type="checkbox" name="sport" value="tennis"> Tennis</label><br>
  <label><input type="checkbox" name="sport" value="schwimmen"> Schwimmen</label><br>
  <label><input type="checkbox" name="sport" value="radfahren"> Radfahren</label>
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

## Radio-Buttons

Ermöglichen **genau eine Auswahl** aus mehreren Optionen.

```html
<label>
  <input type="radio" name="gender"
         value="m">
  Männlich
</label>

<label>
  <input type="radio" name="gender"
         value="w">
  Weiblich
</label>
```

<br>

- Gleicher `name` → nur **eine** Option wählbar
- Unterschied zur Checkbox: **exklusive** Auswahl

::right::

<div class="demo-area">
  <strong>Geschlecht (nur eines wählbar):</strong><br><br>
  <label><input type="radio" name="gender" value="m"> Männlich</label><br>
  <label><input type="radio" name="gender" value="w"> Weiblich</label><br>
  <label><input type="radio" name="gender" value="d"> Divers</label><br>
  <label><input type="radio" name="gender" value="k"> Keine Angabe</label>
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

## Dropdown-Menü

`<select>` erstellt eine **Auswahlliste**.

```html
<label for="land">Land:</label>
<select id="land" name="land">
  <option value="">-- Bitte wählen --</option>
  <option value="at">Österreich</option>
  <option value="de">Deutschland</option>
  <option value="ch">Schweiz</option>
</select>
```

<br>

- `<option value="">` → leere Standardoption
- `selected` Attribut → vorgewählte Option
- Für Mehrfachauswahl: `multiple` Attribut

::right::

<div class="demo-area">
  <label for="d-land">Land:</label><br>
  <select id="d-land" name="land">
    <option value="">-- Bitte wählen --</option>
    <option value="at">Österreich</option>
    <option value="de">Deutschland</option>
    <option value="ch">Schweiz</option>
    <option value="it">Italien</option>
  </select>
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

## Mehrzeiliger Text

`<textarea>` für **längere Texteingaben**.

```html
<label for="msg">Nachricht:</label>
<textarea id="msg" name="msg"
          rows="4"
          placeholder="Deine Nachricht...">
</textarea>
```

<br>

- `rows` → sichtbare Zeilenhöhe
- Inhalt steht **zwischen** den Tags (nicht `value`)
- Kein selbstschließendes Element — `</textarea>` nötig

::right::

<div class="demo-area">
  <label for="d-msg">Nachricht:</label><br>
  <textarea id="d-msg" name="msg" rows="5" cols="32" placeholder="Deine Nachricht..."></textarea>
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---

# Wichtige Attribute

<br>

| Attribut | Wert | Effekt |
|----------|------|--------|
| `required` | – | Feld muss ausgefüllt werden |
| `placeholder` | Text | Hinweis-Text im leeren Feld |
| `value` | Text | Vorausgefüllter Wert |
| `disabled` | – | Feld ist gesperrt (wird **nicht** gesendet) |
| `readonly` | – | Feld lesbar, aber nicht veränderbar (wird gesendet) |
| `maxlength` | Zahl | Maximale Zeichenanzahl |
| `min` / `max` | Zahl | Wertebereich (für `number`, `date`) |

---
layout: two-cols
layoutClass: gap-16
---

## `required`, `disabled`, `readonly`

```html
<!-- Pflichtfeld -->
<input type="text" name="name"
       required placeholder="Pflichtfeld">

<!-- Deaktiviert — wird nicht gesendet -->
<input type="text" name="code"
       value="XYZ-123" disabled>

<!-- Nur lesbar — wird trotzdem gesendet -->
<input type="text" name="id"
       value="USER-42" readonly>
```

::right::

<div class="demo-area">
  <label>Pflichtfeld (required):</label><br>
  <input type="text" name="name" required placeholder="Pflichtfeld">
  <br><br>
  <label>Deaktiviert (disabled):</label><br>
  <input type="text" name="code" value="XYZ-123" disabled>
  <br><br>
  <label>Nur lesbar (readonly):</label><br>
  <input type="text" name="id" value="USER-42" readonly>
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

# `<fieldset>` & `<legend>`

Gruppiert verwandte Felder **optisch und semantisch**.

```html
<fieldset>
  <legend>Persönliche Daten</legend>

  <label for="fn">Vorname:</label>
  <input type="text" id="fn" name="fn">

  <label for="ln">Nachname:</label>
  <input type="text" id="ln" name="ln">
</fieldset>

<fieldset>
  <legend>Zugangsdaten</legend>

  <label for="em">E-Mail:</label>
  <input type="email" id="em" name="em">
</fieldset>
```

::right::

<div>
  <fieldset>
    <legend>Persönliche Daten</legend>
    <label for="d-fn">Vorname:</label><br>
    <input type="text" id="d-fn" placeholder="Vorname"><br><br>
    <label for="d-ln">Nachname:</label><br>
    <input type="text" id="d-ln" placeholder="Nachname">
  </fieldset>
  <br>
  <fieldset>
    <legend>Zugangsdaten</legend>
    <label for="d-em">E-Mail:</label><br>
    <input type="email" id="d-em" placeholder="E-Mail"><br><br>
    <label for="d-pw">Passwort:</label><br>
    <input type="password" id="d-pw" placeholder="Passwort">
  </fieldset>
</div>

---

# Das `<form>`-Element

Das `<form>`-Tag **umschließt alle Eingabefelder** und bestimmt, wie die Daten gesendet werden.

```html
<form action="/submit" method="post">

  <!-- Eingabefelder kommen hier rein -->

  <button type="submit">Absenden</button>
</form>
```

<br>

| Attribut | Bedeutung |
|----------|-----------|
| `action` | URL, an die das Formular gesendet wird |
| `method` | HTTP-Methode: `GET` oder `POST` |

---

# GET vs. POST

<br>

| | **GET** | **POST** |
|---|---|---|
| **Daten übertragen** | In der URL (`?name=Max&age=20`) | Im Anfrage-Body (unsichtbar) |
| **Sichtbarkeit** | Öffentlich in der Adressleiste | Nicht sichtbar |
| **Max. Datenmenge** | Begrenzt (~2000 Zeichen) | Unbegrenzt |
| **Geeignet für** | Suchen, Filter | Anmeldung, Registrierung |
| **Lesezeichenbar** | ✔ Ja | ✗ Nein |
| **Wiederholbar** | ✔ Ja | ⚠ Warnung bei Reload |

---
layout: two-cols
layoutClass: gap-16
---

## GET-Methode

Formulardaten werden **an die URL angehängt**:

```html
<form action="/search" method="get">
  <input type="text" name="q">
  <button type="submit">Suchen</button>
</form>
```

**Nach dem Absenden:**

```
/search?q=Hallo+Welt
```

<br>

- Gut für **Suchanfragen** und Filter
- Daten in der Adressleiste sichtbar
- URL kann als **Lesezeichen** gespeichert werden

::right::

<div class="demo-area">
  <label>Suchwort:</label><br>
  <input type="text" name="q" placeholder="z. B. Hallo Welt">
  <br><br>
  <button type="button">Suchen</button>
  <br><br>
  <small>👆 Beim Absenden erscheint der Suchbegriff in der URL:<br><code>/search?q=Hallo+Welt</code></small>
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---
layout: two-cols
layoutClass: gap-16
---

## POST-Methode

Formulardaten werden **im Anfrage-Body gesendet**:

```html
<form action="/login" method="post">
  <input type="text" name="user">
  <input type="password" name="pass">
  <button type="submit">Anmelden</button>
</form>
```

**Nach dem Absenden:**

```
POST /login
Body: user=Max&pass=geheim
```

<br>

- Daten sind **nicht in der URL sichtbar**
- Geeignet für **sensible Daten** (Passwörter)
- URL bleibt unverändert: `/login`

::right::

<div class="demo-area">
  <label>Benutzername:</label><br>
  <input type="text" name="user" placeholder="Benutzername">
  <br><br>
  <label>Passwort:</label><br>
  <input type="password" name="pass" placeholder="Passwort">
  <br><br>
  <button type="button">Anmelden</button>
  <br><br>
  <small>👆 Die URL ändert sich beim Absenden <strong>nicht</strong></small>
</div>

<style>
.demo-area {
  padding: 24px;
  background: #f8f9fa;
  border-radius: 8px;
}
</style>

---

# Vollständiges Beispiel

```html
<form action="/kontakt" method="post">
  <fieldset>
    <legend>Kontaktformular</legend>

    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required>

    <label for="email">E-Mail:</label>
    <input type="email" id="email" name="email" required>

    <label for="betreff">Betreff:</label>
    <select id="betreff" name="betreff">
      <option value="allgemein">Allgemeine Anfrage</option>
      <option value="support">Support</option>
    </select>

    <!-- Fortsetzung auf nächster Folie -->
  </fieldset>
</form>
```

---
hideInToc: true
---

# Vollständiges Beispiel (Fortsetzung)

```html
    <label for="nachricht">Nachricht:</label>
    <textarea id="nachricht" name="nachricht"
              rows="3" required></textarea>

    <label>
      <input type="checkbox" name="agb"
             value="ja" required>
      Ich stimme den AGB zu
    </label>

    <button type="submit">Absenden</button>
```

---
layout: two-cols-header
layoutClass: gap-4
---

# Übung

Erstelle ein **Registrierungsformular** mit `method="post"` und folgenden Feldern:

::left::

| Feld | Typ |
|------|-----|
| Vorname & Nachname | `text` (required) |
| E-Mail-Adresse | `email` (required) |
| Passwort | `password` (required) |
| Geburtsdatum | `date` |
| Geschlecht | Radio-Buttons |
| Lieblingssprache | Dropdown (`select`) |
| Kommentar | `textarea` |
| AGB akzeptieren | Checkbox (required) |

::right::

- Verwende `<label>` für alle Felder
- Gruppiere die Felder mit `<fieldset>` und `<legend>`
- Füge einen Absende-Button hinzu

<style>
table { font-size: 0.8em; }
</style>
