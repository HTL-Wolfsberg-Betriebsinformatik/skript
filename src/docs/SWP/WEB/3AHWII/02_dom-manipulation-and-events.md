# DOM‑Manipulation & Events

Ziel: HTML‑Inhalte **lesen, ändern, erzeugen** und auf **Benutzeraktionen** reagieren.  

## DOM‑Grundlagen

**DOM (Document Object Model)** = Baumstruktur, in der der Browser das HTML als **Objekte** abbildet.  
Über `document` greifen wir auf Knoten/Elemente zu.

- **Knotenarten**: `document` → `html` → `head`/`body` → Elemente → Textknoten  
- **Lebenszyklus**: JS sollte erst **nach dem Parsen** laufen (Script am Ende von `<body>` oder `defer` nutzen).

```html
<script defer src="app.js"></script>
```

## Elemente auswählen

| Methode            | Beschreibung                | Beispiel                               |
| ------------------ | --------------------------- | -------------------------------------- |
| `getElementById`   | nach `id`                   | `document.getElementById("title")`     |
| `querySelector`    | erstes Match (CSS‑Selektor) | `document.querySelector(".btn")`       |
| `querySelectorAll` | **NodeList** (alle Matches) | `document.querySelectorAll("li.item")` |


```javascript
const title = document.getElementById("title");
const firstBtn = document.querySelector(".btn");
const items = document.querySelectorAll("li.item"); // NodeList
```

## Inhalte & Attribute ändern

### Text vs. HTML

```javascript
title.textContent = "Neue Überschrift";     // nur Text
title.innerHTML = "<em>Schriftzug</em>";    // interpretiert HTML (Vorsicht!)
```

### Attribute & Eigenschaften

```javascript
const img = document.querySelector("img");
img.src = "bild.png";                       // bevorzugt (Eigenschaft)
img.setAttribute("alt", "Logo");            // Attribut setzen
const altText = img.getAttribute("alt");
```

### Klassen & Styles

```javascript
const card = document.querySelector(".card");
card.classList.add("active");
card.classList.toggle("elevate");

card.style.backgroundColor = "lightyellow"; // Inline‑Style
```

## Elemente erzeugen, einfügen, entfernen

```javascript
const list = document.querySelector("#todo");
const li = document.createElement("li");
li.textContent = "Neuer Punkt";
list.appendChild(li);                // ans Ende

// Varianten:
list.prepend(li);                    // an den Anfang
list.insertAdjacentHTML("beforeend", "<li>HTML‑Eintrag</li>"); // mit HTML

// Entfernen:
li.remove();                         // Element selbst entfernen
list.innerHTML = "";                 // Alle Kinder löschen (einfach, aber grob)
```

## Events (Ereignisse)

**Event‑Listener hinzufügen:**

```javascript
const btn = document.querySelector(".btn");
btn.addEventListener("click", () => {
  console.log("Geklickt!");
});
```

**Häufige Events:**

- Maus: click, dblclick, mouseover, mouseout
- Tastatur: keydown, keyup
- Formulare: input, change, submit
- Sonstiges: focus, blur, scroll

**Das Event Objekt**

```javascript
btn.addEventListener("click", (event) => {
  console.log(event.type, event.target);
});
```

**Standardverhalten verhindern:**

```javascript
const form = document.querySelector("form");
form.addEventListener("submit", (e) => {
  e.preventDefault(); // verhindert Seitenreload
  // eigene Logik …
});
```

## Formulare auslesen & einfache Validierung

=== "HTML"

    ```html
    <form id="contact">
        <input id="name" name="name" required />
        <input id="age" name="age" type="number" min="0" />
        <button type="submit">Senden</button>
    </form>
    <p id="output"></p>
    ```
=== "Javascript"

    ```javascript
    const form = document.getElementById("contact");
    const out = document.getElementById("output");

    form.addEventListener("submit", (e) => {
        e.preventDefault();
        const data = new FormData(form);    // sammelt alle Felder
        const name = data.get("name");
        const age = Number(data.get("age") || 0);

        if (!name) return (out.textContent = "Name ist Pflicht.");
        if (age < 0) return (out.textContent = "Alter ungültig.");

        out.textContent = `Hallo ${name}, Alter: ${age}`;
    });
    ```

!!! hint "Hinweis 
     HTML5‑Attribute (`required`, `min`, `max`, `pattern`) bieten eingebaute Validierung, die per CSS/JS ergänzt werden kann.


## Event Delegation

- Statt jedem Kind einen Listener zu geben, hört der Container auf Ereignisse.
- Vorteil: Funktioniert auch für später dynamisch hinzugefügte Elemente.

=== "HTML"

    ```html
    <ul id="todo">
        <li class="item">Apfel <button class="remove">x</button></li>
        <li class="item">Banane <button class="remove">x</button></li>
    </ul>
    ```
=== "Javascript"

    ```javascript
    const list = document.getElementById("todo");

    list.addEventListener("click", (e) => {
    if (e.target.matches(".remove")) {
        e.target.closest(".item").remove();
    }
    });
    ```

## Renderfunktion und State (=Zustand)

=== "HTML"

    ```html
    <ul id="todo">
        <li class="item">Apfel <button class="remove">x</button></li>
        <li class="item">Banane <button class="remove">x</button></li>
    </ul>
    ```
=== "Javascript"

    ```javascript
    const state = { items: ["Apfel", "Banane"] };
    const ul = document.querySelector("#todo");

    function render() {
        ul.innerHTML = "";
        state.items.forEach((txt) => {
            const li = document.createElement("li");
            li.className = "item";
            li.innerHTML = `${txt} <button class="remove">x</button>`;
            ul.appendChild(li);
        });
    }

    render();

    ul.addEventListener("click", (e) => {
        if (!e.target.matches(".remove")) return;
        const text = e.target.parentElement.firstChild.textContent.trim();
        state.items = state.items.filter((t) => t !== text);
        render();
    });
    ```

## Beispiel: Interaktive Liste

=== "HTML"
    ```html
    --8<-- "assets/html/interactive-list.html"
    ```
=== "Ausgabe"
    <a href="/assets/html/interactive-list.html" target="_blank">Interactive List Demo</a>