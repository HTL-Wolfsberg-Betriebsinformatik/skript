---
theme: seriph
routerMode: hash
title: Sortieralgorithmen
info: |
  ## Sortieralgorithmen
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

# Sortieralgorithmen

## Warum brauchen wir sie?

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Warum müssen wir sortieren?

- **Daten müssen oft geordnet werden:**
    - Namen alphabetisch
    - Produkte nach Preis
    - Ergebnisse nach Zeit
    - Dateien nach Datum

- **Sortieren ist ein Grundproblem der Informatik**
    - Grundlage für Datenbanken
    - Grundlage für effiziente Programme

---

# Kriterien der Sortieralgorithmen

- Korrektheit
- Laufzeit (Wie schnell?)
- Speicherverbrauch (Wie viel extra Speicher?)
- Stabilität (bleiben gleiche Elemente in Reihenfolge?)

---

# Warum verschiedene Sortieralgorithmen?

Es gibt nicht den einen perfekten Algorithmus

Manche sind:
- leichter zu verstehen
- schneller bei vielen Daten
- gut, wenn die Daten fast sortiert sind
- gut, wenn wenig Speicher verfügbar ist

<br>

> 💡 Deshalb lernt man mehrere Ansätze und deren Einsatzgebiete

---

# 4 wichtige Sortierverfahren

<br>

- **Selection Sort:** Sortieren durch Auswahl 

- **Insertion Sort:** Sortieren durch Einfügen

- **Bubble Sort:** Sortieren durch Vertauschen

- **QuickSort**: Teile-und-Herrsche

---
layout: two-cols-header
layoutClass: gap-16
---

# Bubble Sort

::left::

- Vergleiche benachbarte Elemente
- Tausche, wenn sie falsch herum stehen
- Das größte Element „blubbert“ nach oben

<br>

**Eigenschaften:**

- Sehr leicht verständlich
- Extrem ineffizient (O(n²))
- Hauptsächlich ein **Lehrbeispiel**

::right::

```ps
für i von 0 bis n-2:
    für j von 0 bis n-2-i:
        wenn array[j] > array[j+1]:
            tausche array[j] mit array[j+1]
```

---
layout: iframe
url: https://www.youtube.com/embed/Dv4qLJcxus8?si=uJwspHg0NYBsteVO
---

# Bubble Sort - Erklärvideo

---
layout: two-cols-header
layoutClass: gap-16
---

# Selection Sort

::left::

- Finde immer das kleinste Element im unsortierten Teil
- Setze es an die richtige Position
- Wiederhole

<br>

**Eigenschaften:**

- Einfach zu verstehen
- Immer gleiche Anzahl Vergleiche → O(n²)
- Gut zum Lernen, schlecht für große Datenmengen

::right::

```ps
für i von 0 bis n-2:
    minIndex = i
    
    für j von i+1 bis n-1:
        wenn array[j] < array[minIndex]:
            minIndex = j

    tausche array[i] mit array[minIndex]

```

---
layout: iframe
url: https://www.youtube.com/embed/EwjnF7rFLns?si=Sc0NmAgRRlObOsEX
---

# Selection Sort - Erklärvideo

---
layout: two-cols-header
layoutClass: gap-16
---

# Insertion Sort

::left::

- Linker Bereich ist immer sortiert
- Nimm das nächste Element und füge es richtig ein
- Elemente werden nach rechts geschoben

**Eigenschaften:**

- Sehr schnell, wenn Daten fast sortiert sind
- Im Worst-Case O(n²)
- Im Best-Case O(n)
- Wird in der Praxis häufig eingesetzt

::right::

```ps
für i von 1 bis n-1:
    key = array[i]
    j = i - 1
    
    solange j >= 0 und array[j] > key:
        array[j+1] = array[j]
        j = j - 1

    array[j+1] = key
```

---
layout: iframe
url: https://www.youtube.com/embed/8mJ-OhcfpYg?si=T9bz-tr9i1aoE5e3
---

# Insertion Sort - Erklärvideo

---
layout: two-cols
layoutClass: gap-16
---

# Quick Sort

- Wähle ein Pivot-Element
- Teile das Array:
    - links: kleiner als Pivot
    - rechts: größer als Pivot
- Sortiere beide Seiten rekursiv

**Eigenschaften:**

- Durchschnittlich O(n log n)
- Sehr schnell in der Praxis
- Gehört zu den wichtigsten Sortierverfahren
- Wird in vielen Programmiersprachen standardmäßig verwendet

::right::

```ps
funktion QuickSort(array, links, rechts):
    wenn links < rechts:
        p = Partition(array, links, rechts)
        QuickSort(array, links, p-1)
        QuickSort(array, p+1, rechts)

funktion Partition(array, links, rechts):
    pivot = array[rechts]
    l = links - 1
    r = rechts

    wiederhole:
        wiederhole:
            l = l + 1
        solange l < rechts und array[l] < pivot

        wiederhole:
            r = r - 1
        solange r > links und array[r] >= pivot

        wenn l >= r:
            beende Schleife

        tausche array[l] mit array[r]

    tausche array[l] mit array[rechts]
    gib l zurück
```

---
layout: center
---

# Quick Sort - Beispiel

<div class="flex justify-center">

<div>

👉 [zum Quick Sort Beispiel](https://www.canva.com/design/DAG-Mb1VCZc/wWsO3c4sd8kiNJ1S6XLSug/edit?utm_content=DAG-Mb1VCZc&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton) 👈

</div>
</div>

---

# Vergleich der Algorithmen

| Algorithmus        | Best Case        | Average Case | Worst Case | Vorteil                                | Nachteil                       |
| ------------------ | ---------------- | ------------ | ---------- | -------------------------------------- | ------------------------------ |
| **Bubble Sort**    | O(n)             | O(n²)        | O(n²)      | Extrem leicht verständlich             | Sehr ineffizient               |
| **Selection Sort** | O(n²)            | O(n²)        | O(n²)      | Sehr einfach                           | Immer gleich langsam           |
| **Insertion Sort** | O(n)             | O(n²)        | O(n²)      | Sehr schnell bei fast sortierten Daten | Langsam bei unsortierten Daten |
| **QuickSort**      | O(n log n)       | O(n log n)   | O(n²)      | Sehr schnell in der Praxis             | Schlechtes Pivot → langsam     |

