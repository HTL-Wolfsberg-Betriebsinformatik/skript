---
theme: seriph
routerMode: hash
title: BPMN - Fortgeschritten
info: |
  ## BPMN - Fortgeschritten
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

# BPMN - Fortgeschritten

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Pools & Lanes

- Der **Pool** definiert in der Regel die **Organisation oder Einheit**, in der der Prozess stattfindet.
- Die **Lane** (Bahn) definiert die **Rolle oder Abteilung**, die für die Ausführung der einzelnen Aufgaben verantwortlich ist.

![Pools and Lanes Beispiel](./assets/bpmn-pools-and-lanes-example.drawio.png){width=50%}

---

# Beispiel: Fehlender Schuhgrößen Prozess

*** 

![Fehlender Schuhgrößen Prozess 1.0](./assets/bpmn-exercise-missing-shoe-size-process.drawio.png)

---

# Beispiel: Fehlender Schuhgrößen Prozess 2.0

***

![Fehlender Schuhgrößen Prozess 1.0](./assets/bpmn-exercise-missing-shoe-size-process-with-warehouse-manager.drawio.png){width=80%}

---

# Closing Gateways

Um Aktivitäten (Tasks) wieder zusammenzuführen, benutzt man *Closing Gateways*.

<br>

![Closing Gateway Beispiel](./assets/bpmn-example-closing-gateways.drawio.png)

---

# Übung: Lieferung Großhändler

Der Verkäufer steht vor einer neuen Herausforderung. Er erhält eine Lieferung vom Großhändler und weiß nicht, was er als Nächstes tun soll. Sein Chef sagt zu ihm:

„Keine Sorge. Zuerst überprüfst du, ob die Bestellung und die Rechnung korrekt sind. Wenn nicht, gibst du das Paket an den Versandmitarbeiter zurück. Wenn alles stimmt, prüfst du, ob es sich um eine Standardbestellung oder um eine Kundenbestellung handelt. Wenn es eine Standardbestellung ist, bringst du die Schuhe einfach ins Lager. Wenn es eine Kundenbestellung ist, stellst du die Schuhe hinter die Kasse – und das war’s!“

Deine Aufgabe ist es nun, dem Verkäufer zu helfen, indem du einen einfachen Prozess erstellst. Ignoriere dabei die Aufgaben des Versandmitarbeiters. Modelle nur, was der Verkäufer tun muss.

---

# Lösung: Lieferung Großhändler

*** 

![Lösung: Lieferung Großhändler](./assets/bpmn-exercise-shoe-delivery-process.drawio.png)

---

# Token Konzept

Einen *Token* kann man sich als *Ball* oder *Murmel* vorstellen.

![Blaue Murmel](./assets/blue-marble.png){width=40%}

- Der *Token* rollt durch den Prozess, vom Start- bis zum Endevent!
- Der *Token* durchläuft alle Arten von Aktivitäten und Gateways, die ihn beeinflussen.
- Sobald die Aktivität fertig ist, rollt der Token weiter

---
hideInToc: true
layout: default
clicks: 2
---

# Token Konzept

<div class="h-full w-full flex justify-center items-center">
<div class="absolute"
  v-motion
  :initial="{ x: -80 }"
  :enter="{ x: -70, y: -30 }"
  :click-1="{ x: 0, y: 0 }"
  :click-2="{ x: 160, y: -30 }">
    <BpmnToken />
</div>
  <img src="./assets/bpmn-token-example.drawio.png" alt="BPMN Token Beispiel">
</div>

---
hideInToc: true
clicks: 4
---

# Token Konzept

Die eigentliche Stärke des Token-Konzepts besteht darin, zu veranschaulichen, wie verschiedene Gateways funktionieren.

**Beispiel: XOR**

<div class="w-full flex justify-center items-center">
<div class="absolute"
  v-motion
  :enter="{ x: -240, y: -3 }"
  :click-1="{ x: -175, y: -3 }"
  :click-2="{ x: 15, y: -90 }"
  :click-3="{ x: 195, y: -3 }"
  :click-4="{ x: 260, y: -3 }"
  >
    <BpmnToken />
</div>
  <img src="./assets/bpmn-token-concept-xor-path.drawio.png" alt="BPMN Token Konzept XOR">
</div>

---
hideInToc: true
clicks: 8
---

# Token Konzept

Die eigentliche Stärke des Token-Konzepts besteht darin, zu veranschaulichen, wie verschiedene Gateways funktionieren.

**Beispiel "Parallel": Tokens werden geklont und beim Closing Gateway muss man auf alle warten.**

<div class="w-full flex justify-center items-center">
<div class="absolute"
  v-motion
  :initial="{ x: -160 }"
  :enter="{ x: -300, y: -3 }"
  :click-1="{ x: -195, y: -3 }"
  :click-2="{ x: -140, y: -3 }"
  :click-3="{ x: 0, y: -3 }"
  :click-4="{ x: 140, y: -3 }"
  :click-7="{ x: 204, y: -3 }"
  :click-8="{ x: 244, y: -3 }"
  >
    <BpmnToken />
</div>
<div class="absolute"
  v-click="1"
  v-click.hide="8"
  v-motion
  :enter="{ x: -300, y: -3 }"
  :click-1="{ x: -195, y: -3}"
  :click-2="{ x: -195, y: -106 }"
  :click-3="{ x: 0, y: -106 }"
  :click-4="{ x: 204, y: -106 }"
  :click-5="{ x: 204, y: -3 }"
  >
    <BpmnToken />
</div>
<div class="absolute"
  v-click="1"
  v-click.hide="8"
  v-motion
  :enter="{ x: -300, y: -3 }"
  :click-1="{ x: -195, y: -3}"
  :click-2="{ x: -195, y: 100 }"
  :click-3="{ x: 0, y: 100 }"
  :click-4="{ x: 204, y: 100 }"
  :click-6="{ x: 204, y: -3 }"
  >
    <BpmnToken />
</div>

  <img src="./assets/bpmn-token-parallel-paths.drawio.png" alt="BPMN Token Konzept AND">
</div>



