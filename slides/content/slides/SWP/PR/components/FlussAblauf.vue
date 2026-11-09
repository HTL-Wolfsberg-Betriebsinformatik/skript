<!--
  FlussAblauf.vue – Code + animiertes Flussdiagramm: zeigt Schritt für Schritt, welcher Teil des Programms läuft
  Ablage: components/FlussAblauf.vue (Slidev registriert die Komponente automatisch)

  Szenarien:  if | ifelse | elseif | switch | while | dowhile | for

  Verwendung (Schritt für Schritt über Klicks):
    ---
    layout: none
    clicks: 13
    ---
    <FlussAblauf szenario="while" :schritt="$clicks" />

  Benötigte Klicks (längster Weg):
    if 5 · ifelse 5 · elseif 6 · switch 6 · while 13 · dowhile 12 · for 13
  Weitere Klicks bleiben einfach beim Endzustand stehen.

  Oben rechts kann der Startwert der Variable per Knopf gewechselt werden (z. B. alter = 15 / 18 / 21).
  Mit :start="5" lässt sich der Startwert vorbelegen. Ohne :schritt ist der Endzustand sichtbar.
  Ausgelegt für die Slidev-Fläche 980 × 552. Dunkles Design folgt dem Slidev-Dark-Mode (html.dark).
-->
<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, reactive, ref, watch } from 'vue'

type Szenario = 'if' | 'ifelse' | 'elseif' | 'switch' | 'while' | 'dowhile' | 'for'

const props = withDefaults(defineProps<{
  szenario: Szenario
  schritt?: number | 'alle'
  start?: number
  titel?: string
}>(), {
  schritt: 'alle',
})

// ---------- Datenmodell ----------
type Farbe = 'a' | 'b' | 'c'
type Text = string | ((w: number) => string)
interface Knoten {
  id: string
  typ: 'start' | 'ende' | 'aktion' | 'frage'
  x: number; y: number; w: number; h: number
  t: Text
  f?: Farbe
}
interface Kante {
  von: string; nach: string; d: string
  label?: string; lx?: number; ly?: number; anker?: 'start' | 'middle' | 'end'
  zaehler?: [number, number]   // Position der Anzeige „n×“ (für Rücksprünge in Schleifen)
}
interface Schritt {
  k: string                    // aktiver Knoten
  z?: number                   // ausgeführte Code-Zeile (1-basiert)
  p?: string                   // gerade aktiver Teil der Zeile
  pf?: Farbe                   // Farbe dieses Teils
  n: string                    // Erklärung
  e?: string                   // Auswertung „Ausdruck → eingesetzt → Ergebnis“
  ok?: boolean                 // Ergebnis der Bedingung
  o?: string                   // neue Konsolenausgabe
  v: Record<string, number>    // Variablen
  vh?: string                  // Hinweis, wenn keine Variablen existieren
  dl?: number                  // Anzahl Durchläufe (Schleifen)
}
interface Def {
  titel: string
  datei: string
  vb: [number, number]
  wertName: string
  werte: number[]
  standard: number
  code: (w: number) => string[]
  knoten: Knoten[]
  kanten: Kante[]
  schritte: (w: number) => Schritt[]
  bloecke?: { k: string; von: number; bis: number }[]
  schleife?: boolean
}

const N = (id: string, typ: Knoten['typ'], x: number, y: number, w: number, h: number, t: Text, f?: Farbe): Knoten =>
  ({ id, typ, x, y, w, h, t, f })

// ---------- Szenarien ----------
const SZ: Record<Szenario, Def> = {
  // ===== if =====
  if: {
    titel: 'if – einfache Bedingung',
    datei: 'Eintritt.cs',
    vb: [340, 430],
    wertName: 'alter',
    werte: [15, 18, 21],
    standard: 21,
    code: w => [
      `int alter = ${w};`,
      'if (alter >= 18)',
      '{',
      '    Console.WriteLine("Zutritt erlaubt");',
      '}',
      'Console.WriteLine("Programmende");',
    ],
    knoten: [
      N('start', 'start', 150, 22, 90, 28, 'Start'),
      N('init', 'aktion', 150, 74, 150, 32, w => `alter = ${w}`),
      N('q', 'frage', 150, 150, 160, 64, 'alter >= 18 ?'),
      N('a', 'aktion', 150, 240, 180, 32, '„Zutritt erlaubt“'),
      N('b', 'aktion', 150, 325, 180, 32, '„Programmende“'),
      N('ende', 'ende', 150, 400, 90, 28, 'Ende'),
    ],
    kanten: [
      { von: 'start', nach: 'init', d: 'M150 36 L150 58' },
      { von: 'init', nach: 'q', d: 'M150 90 L150 118' },
      { von: 'q', nach: 'a', d: 'M150 182 L150 224', label: 'ja', lx: 158, ly: 198, anker: 'start' },
      { von: 'q', nach: 'b', d: 'M230 150 L305 150 L305 325 L240 325', label: 'nein', lx: 265, ly: 142 },
      { von: 'a', nach: 'b', d: 'M150 256 L150 309' },
      { von: 'b', nach: 'ende', d: 'M150 341 L150 386' },
    ],
    bloecke: [{ k: 'a', von: 3, bis: 5 }],
    schritte: w => {
      const v = { alter: w }
      const ok = w >= 18
      const s: Schritt[] = [
        { k: 'init', z: 1, v, n: `Die Variable alter bekommt den Wert ${w}.` },
        {
          k: 'q', z: 2, v, e: `alter >= 18 → ${w} >= 18 → ${ok}`, ok,
          n: ok
            ? 'Die Bedingung ist true: Der Block in den geschwungenen Klammern wird ausgeführt.'
            : 'Die Bedingung ist false: Der ganze Block wird übersprungen.',
        },
      ]
      if (ok) s.push({ k: 'a', z: 4, v, o: 'Zutritt erlaubt', n: 'Diese Zeile läuft nur, weil die Bedingung true war.' })
      s.push({ k: 'b', z: 6, v, o: 'Programmende', n: 'Nach dem if-Block geht es in jedem Fall hier weiter, egal wie die Bedingung ausgegangen ist.' })
      s.push({ k: 'ende', v, n: 'Programm beendet. Probiert oben einen anderen Wert für alter aus!' })
      return s
    },
  },

  // ===== if-else =====
  ifelse: {
    titel: 'if-else – entweder oder',
    datei: 'Eintritt.cs',
    vb: [340, 430],
    wertName: 'alter',
    werte: [15, 18, 21],
    standard: 15,
    code: w => [
      `int alter = ${w};`,
      'if (alter >= 18)',
      '{',
      '    Console.WriteLine("Zutritt erlaubt");',
      '}',
      'else',
      '{',
      '    Console.WriteLine("Zutritt verweigert");',
      '}',
      'Console.WriteLine("Programmende");',
    ],
    knoten: [
      N('start', 'start', 170, 22, 90, 28, 'Start'),
      N('init', 'aktion', 170, 74, 150, 32, w => `alter = ${w}`),
      N('q', 'frage', 170, 150, 150, 64, 'alter >= 18 ?'),
      N('a', 'aktion', 82, 238, 156, 32, '„Zutritt erlaubt“'),
      N('b', 'aktion', 258, 238, 156, 32, '„Zutritt verweigert“'),
      N('c', 'aktion', 170, 325, 180, 32, '„Programmende“'),
      N('ende', 'ende', 170, 400, 90, 28, 'Ende'),
    ],
    kanten: [
      { von: 'start', nach: 'init', d: 'M170 36 L170 58' },
      { von: 'init', nach: 'q', d: 'M170 90 L170 118' },
      { von: 'q', nach: 'a', d: 'M95 150 L82 150 L82 222', label: 'ja', lx: 76, ly: 192, anker: 'end' },
      { von: 'q', nach: 'b', d: 'M245 150 L258 150 L258 222', label: 'nein', lx: 264, ly: 192, anker: 'start' },
      { von: 'a', nach: 'c', d: 'M82 254 L82 290 L170 290 L170 309' },
      { von: 'b', nach: 'c', d: 'M258 254 L258 290 L170 290 L170 309' },
      { von: 'c', nach: 'ende', d: 'M170 341 L170 386' },
    ],
    bloecke: [{ k: 'a', von: 3, bis: 5 }, { k: 'b', von: 6, bis: 9 }],
    schritte: w => {
      const v = { alter: w }
      const ok = w >= 18
      return [
        { k: 'init', z: 1, v, n: `Die Variable alter bekommt den Wert ${w}.` },
        {
          k: 'q', z: 2, v, e: `alter >= 18 → ${w} >= 18 → ${ok}`, ok,
          n: ok
            ? 'true: Der if-Zweig wird ausgeführt, der else-Zweig wird übersprungen.'
            : 'false: Der if-Zweig wird übersprungen, stattdessen läuft der else-Zweig.',
        },
        ok
          ? { k: 'a', z: 4, v, o: 'Zutritt erlaubt', n: 'Es läuft immer genau einer der beiden Zweige, nie beide und nie keiner.' }
          : { k: 'b', z: 8, v, o: 'Zutritt verweigert', n: 'Es läuft immer genau einer der beiden Zweige, nie beide und nie keiner.' },
        { k: 'c', z: 10, v, o: 'Programmende', n: 'Beide Wege treffen sich wieder. Ab hier läuft das Programm normal weiter.' },
        { k: 'ende', v, n: 'Programm beendet. Probiert oben einen anderen Wert für alter aus!' },
      ]
    },
  },

  // ===== else if =====
  elseif: {
    titel: 'else if – mehrere Fälle',
    datei: 'Note.cs',
    vb: [360, 440],
    wertName: 'punkte',
    werte: [95, 80, 60, 30],
    standard: 80,
    code: w => [
      `int punkte = ${w};`,
      'if (punkte >= 90)',
      '{',
      '    Console.WriteLine("Sehr gut");',
      '}',
      'else if (punkte >= 75)',
      '{',
      '    Console.WriteLine("Gut");',
      '}',
      'else if (punkte >= 50)',
      '{',
      '    Console.WriteLine("Genügend");',
      '}',
      'else',
      '{',
      '    Console.WriteLine("Nicht genügend");',
      '}',
    ],
    knoten: [
      N('start', 'start', 90, 18, 80, 26, 'Start'),
      N('init', 'aktion', 90, 58, 130, 30, w => `punkte = ${w}`),
      N('q1', 'frage', 90, 122, 140, 54, 'punkte >= 90 ?'),
      N('a1', 'aktion', 250, 122, 120, 30, '„Sehr gut“'),
      N('q2', 'frage', 90, 200, 140, 54, 'punkte >= 75 ?'),
      N('a2', 'aktion', 250, 200, 120, 30, '„Gut“'),
      N('q3', 'frage', 90, 278, 140, 54, 'punkte >= 50 ?'),
      N('a3', 'aktion', 250, 278, 120, 30, '„Genügend“'),
      N('a4', 'aktion', 90, 348, 150, 30, '„Nicht genügend“'),
      N('ende', 'ende', 200, 410, 80, 26, 'Ende'),
    ],
    kanten: [
      { von: 'start', nach: 'init', d: 'M90 31 L90 43' },
      { von: 'init', nach: 'q1', d: 'M90 73 L90 95' },
      { von: 'q1', nach: 'a1', d: 'M160 122 L190 122', label: 'ja', lx: 177, ly: 115 },
      { von: 'q1', nach: 'q2', d: 'M90 149 L90 173', label: 'nein', lx: 97, ly: 165, anker: 'start' },
      { von: 'q2', nach: 'a2', d: 'M160 200 L190 200', label: 'ja', lx: 177, ly: 193 },
      { von: 'q2', nach: 'q3', d: 'M90 227 L90 251', label: 'nein', lx: 97, ly: 243, anker: 'start' },
      { von: 'q3', nach: 'a3', d: 'M160 278 L190 278', label: 'ja', lx: 177, ly: 271 },
      { von: 'q3', nach: 'a4', d: 'M90 305 L90 333', label: 'nein', lx: 97, ly: 322, anker: 'start' },
      { von: 'a1', nach: 'ende', d: 'M310 122 L340 122 L340 410 L240 410' },
      { von: 'a2', nach: 'ende', d: 'M310 200 L340 200 L340 410 L240 410' },
      { von: 'a3', nach: 'ende', d: 'M310 278 L340 278 L340 410 L240 410' },
      { von: 'a4', nach: 'ende', d: 'M90 363 L90 410 L160 410' },
    ],
    bloecke: [
      { k: 'a1', von: 3, bis: 5 }, { k: 'q2', von: 6, bis: 6 },
      { k: 'a2', von: 7, bis: 9 }, { k: 'q3', von: 10, bis: 10 },
      { k: 'a3', von: 11, bis: 13 }, { k: 'a4', von: 14, bis: 17 },
    ],
    schritte: w => {
      const v = { punkte: w }
      const s: Schritt[] = [{ k: 'init', z: 1, v, n: `Die Variable punkte bekommt den Wert ${w}.` }]
      const stufen = [
        { q: 'q1', a: 'a1', g: 90, zq: 2, za: 4, txt: 'Sehr gut' },
        { q: 'q2', a: 'a2', g: 75, zq: 6, za: 8, txt: 'Gut' },
        { q: 'q3', a: 'a3', g: 50, zq: 10, za: 12, txt: 'Genügend' },
      ]
      let getroffen = false
      for (const [i, st] of stufen.entries()) {
        const ok = w >= st.g
        s.push({
          k: st.q, z: st.zq, v, ok, e: `punkte >= ${st.g} → ${w} >= ${st.g} → ${ok}`,
          n: ok
            ? (i < 2 ? 'true: Dieser Zweig wird ausgeführt. Die restlichen Bedingungen werden gar nicht mehr geprüft!' : 'true: Dieser Zweig wird ausgeführt. Das else wird übersprungen.')
            : 'false: Weiter zur nächsten Bedingung.',
        })
        if (ok) {
          s.push({ k: st.a, z: st.za, v, o: st.txt, n: 'Von oben nach unten gilt: Die erste Bedingung, die true ist, gewinnt.' })
          getroffen = true
          break
        }
      }
      if (!getroffen) {
        s.push({ k: 'a4', z: 16, v, o: 'Nicht genügend', n: 'Keine Bedingung war true. Deshalb greift das else, es ist der „Rest-Fall“.' })
      }
      s.push({ k: 'ende', v, n: 'Programm beendet. Probiert oben andere Punkte aus!' })
      return s
    },
  },

  // ===== switch =====
  switch: {
    titel: 'switch – Fallunterscheidung',
    datei: 'Menue.cs',
    vb: [360, 430],
    wertName: 'auswahl',
    werte: [1, 2, 7],
    standard: 2,
    code: w => [
      `int auswahl = ${w};`,
      'switch (auswahl)',
      '{',
      '    case 1:',
      '        Console.WriteLine("Neues Spiel");',
      '        break;',
      '    case 2:',
      '        Console.WriteLine("Spiel laden");',
      '        break;',
      '    default:',
      '        Console.WriteLine("Ungültig");',
      '        break;',
      '}',
      'Console.WriteLine("Programmende");',
    ],
    knoten: [
      N('start', 'start', 180, 20, 80, 26, 'Start'),
      N('init', 'aktion', 180, 62, 140, 30, w => `auswahl = ${w}`),
      N('sw', 'frage', 180, 132, 150, 58, 'auswahl ?'),
      N('c1', 'aktion', 62, 228, 112, 30, '„Neues Spiel“'),
      N('c2', 'aktion', 180, 228, 112, 30, '„Spiel laden“'),
      N('d', 'aktion', 298, 228, 112, 30, '„Ungültig“'),
      N('pe', 'aktion', 180, 330, 170, 30, '„Programmende“'),
      N('ende', 'ende', 180, 400, 80, 26, 'Ende'),
    ],
    kanten: [
      { von: 'start', nach: 'init', d: 'M180 33 L180 47' },
      { von: 'init', nach: 'sw', d: 'M180 77 L180 103' },
      { von: 'sw', nach: 'c1', d: 'M105 132 L62 132 L62 213', label: 'case 1', lx: 68, ly: 178, anker: 'start' },
      { von: 'sw', nach: 'c2', d: 'M180 161 L180 213', label: 'case 2', lx: 186, ly: 192, anker: 'start' },
      { von: 'sw', nach: 'd', d: 'M255 132 L298 132 L298 213', label: 'default', lx: 292, ly: 178, anker: 'end' },
      { von: 'c1', nach: 'pe', d: 'M62 243 L62 290 L180 290 L180 315', label: 'break', lx: 68, ly: 270, anker: 'start' },
      { von: 'c2', nach: 'pe', d: 'M180 243 L180 315', label: 'break', lx: 186, ly: 270, anker: 'start' },
      { von: 'd', nach: 'pe', d: 'M298 243 L298 290 L180 290 L180 315', label: 'break', lx: 292, ly: 270, anker: 'end' },
      { von: 'pe', nach: 'ende', d: 'M180 345 L180 387' },
    ],
    bloecke: [{ k: 'c1', von: 4, bis: 6 }, { k: 'c2', von: 7, bis: 9 }, { k: 'd', von: 10, bis: 12 }],
    schritte: w => {
      const v = { auswahl: w }
      const ziel = w === 1 ? { k: 'c1', z: 5, b: 6, o: 'Neues Spiel', m: 'case 1' }
        : w === 2 ? { k: 'c2', z: 8, b: 9, o: 'Spiel laden', m: 'case 2' }
        : { k: 'd', z: 11, b: 12, o: 'Ungültig', m: 'default' }
      return [
        { k: 'init', z: 1, v, n: `Die Variable auswahl bekommt den Wert ${w}.` },
        {
          k: 'sw', z: 2, v, e: `auswahl → ${w} → ${ziel.m}`,
          n: ziel.m === 'default'
            ? `Für den Wert ${w} gibt es kein passendes case. Deshalb springt switch zu default.`
            : `switch sucht das case mit dem Wert ${w} und springt direkt dorthin.`,
        },
        { k: ziel.k, z: ziel.z, v, o: ziel.o, n: `Die Anweisungen unter ${ziel.m} werden ausgeführt.` },
        { k: ziel.k, z: ziel.b, v, n: 'break beendet den switch sofort. Die anderen Fälle werden nicht ausgeführt.' },
        { k: 'pe', z: 14, v, o: 'Programmende', n: 'Nach der schließenden Klammer des switch geht es normal weiter.' },
        { k: 'ende', v, n: 'Programm beendet. Probiert oben eine andere Auswahl aus!' },
      ]
    },
  },

  // ===== while =====
  while: {
    titel: 'while-Schleife',
    datei: 'Zaehlen.cs',
    vb: [340, 445],
    wertName: 'zahl',
    werte: [1, 3, 5],
    standard: 1,
    schleife: true,
    code: w => [
      `int zahl = ${w};`,
      'while (zahl <= 3)',
      '{',
      '    Console.WriteLine(zahl);',
      '    zahl++;',
      '}',
      'Console.WriteLine("Fertig");',
    ],
    knoten: [
      N('start', 'start', 170, 20, 90, 26, 'Start'),
      N('init', 'aktion', 170, 66, 140, 30, w => `zahl = ${w}`),
      N('q', 'frage', 170, 140, 150, 62, 'zahl <= 3 ?'),
      N('body', 'aktion', 170, 228, 150, 30, 'zahl ausgeben'),
      N('inc', 'aktion', 170, 290, 150, 30, 'zahl++'),
      N('fertig', 'aktion', 170, 370, 150, 30, '„Fertig“'),
      N('ende', 'ende', 170, 425, 90, 26, 'Ende'),
    ],
    kanten: [
      { von: 'start', nach: 'init', d: 'M170 33 L170 51' },
      { von: 'init', nach: 'q', d: 'M170 81 L170 109' },
      { von: 'q', nach: 'body', d: 'M170 171 L170 213', label: 'ja', lx: 177, ly: 188, anker: 'start' },
      { von: 'body', nach: 'inc', d: 'M170 243 L170 275' },
      { von: 'inc', nach: 'q', d: 'M95 290 L40 290 L40 140 L95 140', zaehler: [48, 220] },
      { von: 'q', nach: 'fertig', d: 'M245 140 L305 140 L305 370 L245 370', label: 'nein', lx: 275, ly: 133 },
      { von: 'fertig', nach: 'ende', d: 'M170 385 L170 412' },
    ],
    schritte: w => {
      const s: Schritt[] = [{ k: 'init', z: 1, v: { zahl: w }, dl: 0, n: `Startwert: zahl bekommt den Wert ${w}.` }]
      let z = w
      let dl = 0
      for (;;) {
        const ok = z <= 3
        s.push({
          k: 'q', z: 2, v: { zahl: z }, dl, ok, e: `zahl <= 3 → ${z} <= 3 → ${ok}`,
          n: dl === 0
            ? (ok
              ? 'Kopfgesteuert: Die Bedingung wird VOR dem ersten Durchlauf geprüft. true → hinein in die Schleife.'
              : 'Die Bedingung ist schon beim ersten Mal false. Der Rumpf wird kein einziges Mal ausgeführt!')
            : (ok
              ? 'Zurück oben: Die Bedingung wird erneut geprüft. true → noch ein Durchlauf.'
              : 'false → Die Schleife ist zu Ende. Weiter mit der Zeile nach der Schleife.'),
        })
        if (!ok) break
        dl++
        s.push({ k: 'body', z: 4, v: { zahl: z }, dl, o: String(z), n: `Durchlauf ${dl}: Der Schleifenrumpf läuft und gibt zahl aus.` })
        z++
        s.push({
          k: 'inc', z: 5, v: { zahl: z }, dl,
          n: dl === 1
            ? `zahl++ erhöht zahl auf ${z}. Ohne diese Zeile wäre die Bedingung immer true: eine Endlosschleife!`
            : `zahl wird auf ${z} erhöht. Danach springt das Programm zurück zur Bedingung.`,
        })
      }
      s.push({ k: 'fertig', z: 7, v: { zahl: z }, dl, o: 'Fertig', n: `Die Schleife ist ${dl === 1 ? 'einmal' : `${dl}-mal`} gelaufen. Jetzt geht es normal weiter.` })
      s.push({ k: 'ende', v: { zahl: z }, dl, n: 'Programm beendet. Probiert oben den Startwert 5 aus!' })
      return s
    },
  },

  // ===== do-while =====
  dowhile: {
    titel: 'do-while-Schleife',
    datei: 'Zaehlen.cs',
    vb: [340, 445],
    wertName: 'zahl',
    werte: [1, 3, 5],
    standard: 1,
    schleife: true,
    code: w => [
      `int zahl = ${w};`,
      'do',
      '{',
      '    Console.WriteLine(zahl);',
      '    zahl++;',
      '}',
      'while (zahl <= 3);',
      'Console.WriteLine("Fertig");',
    ],
    knoten: [
      N('start', 'start', 170, 20, 90, 26, 'Start'),
      N('init', 'aktion', 170, 66, 140, 30, w => `zahl = ${w}`),
      N('body', 'aktion', 170, 130, 150, 30, 'zahl ausgeben'),
      N('inc', 'aktion', 170, 190, 150, 30, 'zahl++'),
      N('q', 'frage', 170, 268, 150, 62, 'zahl <= 3 ?'),
      N('fertig', 'aktion', 170, 370, 150, 30, '„Fertig“'),
      N('ende', 'ende', 170, 425, 90, 26, 'Ende'),
    ],
    kanten: [
      { von: 'start', nach: 'init', d: 'M170 33 L170 51' },
      { von: 'init', nach: 'body', d: 'M170 81 L170 115' },
      { von: 'body', nach: 'inc', d: 'M170 145 L170 175' },
      { von: 'inc', nach: 'q', d: 'M170 205 L170 237' },
      { von: 'q', nach: 'body', d: 'M95 268 L40 268 L40 130 L95 130', label: 'ja', lx: 70, ly: 261, zaehler: [48, 200] },
      { von: 'q', nach: 'fertig', d: 'M170 299 L170 355', label: 'nein', lx: 177, ly: 330, anker: 'start' },
      { von: 'fertig', nach: 'ende', d: 'M170 385 L170 412' },
    ],
    schritte: w => {
      const s: Schritt[] = [{ k: 'init', z: 1, v: { zahl: w }, dl: 0, n: `Startwert: zahl bekommt den Wert ${w}.` }]
      let z = w
      let dl = 0
      for (;;) {
        dl++
        s.push({
          k: 'body', z: 4, v: { zahl: z }, dl, o: String(z),
          n: dl === 1
            ? 'do heißt „mach“: Der Rumpf läuft sofort, OHNE vorher etwas zu prüfen.'
            : `Durchlauf ${dl}: Der Rumpf läuft erneut.`,
        })
        z++
        s.push({ k: 'inc', z: 5, v: { zahl: z }, dl, n: `zahl wird auf ${z} erhöht.` })
        const ok = z <= 3
        s.push({
          k: 'q', z: 7, v: { zahl: z }, dl, ok, e: `zahl <= 3 → ${z} <= 3 → ${ok}`,
          n: ok
            ? 'Fußgesteuert: Die Bedingung steht am Ende. true → zurück zum Anfang des Rumpfs.'
            : (dl === 1 && w > 3
              ? 'false. Der Rumpf ist aber trotzdem schon einmal gelaufen! Genau das ist der Unterschied zur while-Schleife.'
              : 'false → Die Schleife ist zu Ende.'),
        })
        if (!ok) break
      }
      s.push({ k: 'fertig', z: 8, v: { zahl: z }, dl, o: 'Fertig', n: `Die Schleife ist ${dl === 1 ? 'einmal' : `${dl}-mal`} gelaufen. Bei do-while sind es immer mindestens 1 Durchlauf.` })
      s.push({ k: 'ende', v: { zahl: z }, dl, n: 'Programm beendet. Probiert oben den Startwert 5 aus und vergleicht mit while!' })
      return s
    },
  },

  // ===== for =====
  for: {
    titel: 'for-Schleife',
    datei: 'Zaehlen.cs',
    vb: [340, 445],
    wertName: 'i',
    werte: [1, 3, 5],
    standard: 1,
    schleife: true,
    code: w => [
      `for (int i = ${w}; i <= 3; i++)`,
      '{',
      '    Console.WriteLine(i);',
      '}',
      'Console.WriteLine("Fertig");',
    ],
    knoten: [
      N('start', 'start', 170, 20, 90, 26, 'Start'),
      N('init', 'aktion', 170, 66, 140, 30, w => `int i = ${w}`, 'a'),
      N('q', 'frage', 170, 140, 150, 62, 'i <= 3 ?', 'b'),
      N('body', 'aktion', 170, 228, 150, 30, 'i ausgeben'),
      N('inc', 'aktion', 170, 290, 150, 30, 'i++', 'c'),
      N('fertig', 'aktion', 170, 370, 150, 30, '„Fertig“'),
      N('ende', 'ende', 170, 425, 90, 26, 'Ende'),
    ],
    kanten: [
      { von: 'start', nach: 'init', d: 'M170 33 L170 51' },
      { von: 'init', nach: 'q', d: 'M170 81 L170 109' },
      { von: 'q', nach: 'body', d: 'M170 171 L170 213', label: 'ja', lx: 177, ly: 188, anker: 'start' },
      { von: 'body', nach: 'inc', d: 'M170 243 L170 275' },
      { von: 'inc', nach: 'q', d: 'M95 290 L40 290 L40 140 L95 140', zaehler: [48, 220] },
      { von: 'q', nach: 'fertig', d: 'M245 140 L305 140 L305 370 L245 370', label: 'nein', lx: 275, ly: 133 },
      { von: 'fertig', nach: 'ende', d: 'M170 385 L170 412' },
    ],
    schritte: w => {
      const s: Schritt[] = [{
        k: 'init', z: 1, p: `int i = ${w}`, pf: 'a', v: { i: w }, dl: 0,
        n: '① Startwert: Wird genau EINMAL ganz am Anfang ausgeführt. Die Zählvariable i entsteht.',
      }]
      let i = w
      let dl = 0
      for (;;) {
        const ok = i <= 3
        s.push({
          k: 'q', z: 1, p: 'i <= 3', pf: 'b', v: { i }, dl, ok, e: `i <= 3 → ${i} <= 3 → ${ok}`,
          n: ok
            ? (dl === 0 ? '② Bedingung: Wird VOR jedem Durchlauf geprüft, genau wie bei while. true → hinein.' : '② Bedingung erneut prüfen. true → noch ein Durchlauf.')
            : (dl === 0 ? '② Die Bedingung ist sofort false. Der Rumpf läuft kein einziges Mal.' : '② false → Die Schleife ist zu Ende.'),
        })
        if (!ok) break
        dl++
        s.push({ k: 'body', z: 3, v: { i }, dl, o: String(i), n: `Durchlauf ${dl}: Der Schleifenrumpf gibt i aus.` })
        i++
        s.push({
          k: 'inc', z: 1, p: 'i++', pf: 'c', v: { i }, dl,
          n: dl === 1
            ? `③ Veränderung: Passiert am ENDE jedes Durchlaufs. i ist jetzt ${i}, danach wird wieder geprüft.`
            : `③ i wird auf ${i} erhöht, danach zurück zur Bedingung.`,
        })
      }
      s.push({
        k: 'fertig', z: 5, v: {}, dl, o: 'Fertig', vh: 'i existiert hier nicht mehr: Die Variable gilt nur innerhalb der Schleife.',
        n: `Die Schleife ist ${dl === 1 ? 'einmal' : `${dl}-mal`} gelaufen. Weiter nach der Schleife.`,
      })
      s.push({ k: 'ende', v: {}, dl, vh: 'i existiert hier nicht mehr.', n: 'Programm beendet. Vergleicht den Ablauf mit der while-Schleife: Er ist identisch!' })
      return s
    },
  },
}

// ---------- Zustand ----------
const def = computed(() => SZ[props.szenario])
const wert = ref<number>(props.start ?? SZ[props.szenario].standard)
watch(() => [props.szenario, props.start], () => {
  wert.value = props.start ?? def.value.standard
})

const liste = computed<Schritt[]>(() => [
  { k: 'start', v: {}, n: `Wählt oben einen Wert für ${def.value.wertName} und klickt euch Schritt für Schritt durch das Programm.` },
  ...def.value.schritte(wert.value),
])
const gesamt = computed(() => liste.value.length - 1)
const stufe = computed(() =>
  typeof props.schritt === 'number'
    ? Math.min(Math.max(props.schritt, 0), gesamt.value)
    : gesamt.value
)
const aktuell = computed(() => liste.value[stufe.value])
const vorher = computed(() => (stufe.value > 0 ? liste.value[stufe.value - 1] : null))
const knotenText = (k: Knoten) => (typeof k.t === 'function' ? k.t(wert.value) : k.t)
const knotenTyp = computed(() => Object.fromEntries(def.value.knoten.map(k => [k.id, k.typ])))

// ---------- Kanten & Knoten: Zustände ----------
const kantenKey = (von: string, nach: string) => `${von}>${nach}`
const aktiveKante = computed(() => {
  const vor = vorher.value
  if (!vor || vor.k === aktuell.value.k) return null
  return def.value.kanten.find(k => k.von === vor.k && k.nach === aktuell.value.k) ?? null
})
const kantenZaehler = computed(() => {
  const m: Record<string, number> = {}
  for (let i = 1; i <= stufe.value; i++) {
    const a = liste.value[i - 1].k
    const b = liste.value[i].k
    if (a !== b) m[kantenKey(a, b)] = (m[kantenKey(a, b)] ?? 0) + 1
  }
  return m
})
const besuchteKnoten = computed(() => new Set(liste.value.slice(0, stufe.value + 1).map(s => s.k)))
const fertig = computed(() => stufe.value === gesamt.value)

const kanten = computed(() =>
  def.value.kanten.map(k => {
    const key = kantenKey(k.von, k.nach)
    const n = kantenZaehler.value[key] ?? 0
    const aktiv = aktiveKante.value === k
    return { ...k, key, n, zustand: aktiv ? 'aktiv' : n > 0 ? 'besucht' : fertig.value ? 'tot' : 'offen' }
  })
)
const knoten = computed(() =>
  def.value.knoten.map(k => ({
    ...k,
    text: knotenText(k),
    zustand: aktuell.value.k === k.id ? 'aktiv' : besuchteKnoten.value.has(k.id) ? 'besucht' : fertig.value ? 'tot' : 'offen',
  }))
)

// ---------- Code ----------
const esc = (s: string) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
const RE = /("(?:[^"\\]|\\.)*")|\b(int|if|else|switch|case|default|break|while|do|for|true|false)\b|\b(\d+)\b|\b(Console)\b/g

function hl(s: string) {
  let out = ''
  let last = 0
  s.replace(RE, (m, str, kw, num, _typ, off: number) => {
    out += esc(s.slice(last, off))
    out += `<span class="fl-${str ? 's' : kw ? 'k' : num ? 'n' : 't'}">${esc(m)}</span>`
    last = off + m.length
    return m
  })
  return out + esc(s.slice(last))
}

function zeileHtml(text: string, teil?: string, farbe?: Farbe) {
  const i = teil ? text.indexOf(teil) : -1
  if (!teil || i < 0) return hl(text) || '&nbsp;'
  return hl(text.slice(0, i)) + `<mark class="fl-m-${farbe ?? 'x'}">` + hl(teil) + '</mark>' + hl(text.slice(i + teil.length))
}

// Nach der Entscheidung werden die übersprungenen Zweige ausgegraut
const ausgegraut = computed(() => {
  const set = new Set<number>()
  const bl = def.value.bloecke
  if (!bl) return set
  const l = liste.value
  let letzteFrage = -1
  l.forEach((s, i) => { if (knotenTyp.value[s.k] === 'frage') letzteFrage = i })
  if (letzteFrage < 0 || stufe.value <= letzteFrage) return set
  const imPfad = new Set(l.map(s => s.k))
  bl.forEach(b => {
    if (!imPfad.has(b.k)) for (let z = b.von; z <= b.bis; z++) set.add(z)
  })
  return set
})

const zeilen = computed(() =>
  def.value.code(wert.value).map((text, i) => {
    const nr = i + 1
    const cur = aktuell.value.z === nr
    return {
      nr,
      cur,
      grau: ausgegraut.value.has(nr),
      html: zeileHtml(text, cur ? aktuell.value.p : undefined, aktuell.value.pf),
    }
  })
)

// ---------- Seitenleiste ----------
const auswertung = computed(() => {
  const e = aktuell.value.e
  if (!e) return null
  const teile = e.split(' → ')
  const ergebnis = teile.pop()!
  return { weg: teile.join(' → '), ergebnis, ok: aktuell.value.ok }
})
const variablen = computed(() => {
  const alt = vorher.value?.v ?? {}
  return Object.entries(aktuell.value.v).map(([k, v]) => ({ k, v, neu: alt[k] !== v }))
})
const ausgaben = computed(() =>
  liste.value
    .slice(0, stufe.value + 1)
    .map((s, i) => ({ t: s.o, neu: i === stufe.value }))
    .filter(a => a.t !== undefined)
)
const pruefungen = computed(() =>
  liste.value
    .slice(0, stufe.value + 1)
    .filter(s => s.e)
    .map(s => ({ t: s.e!.split(' → ')[1], ok: s.ok }))
)

// ---------- Animation: Punkt wandert entlang der aktiven Kante ----------
const uid = Math.random().toString(36).slice(2, 8)
const mess = ref<SVGPathElement | null>(null)
const token = reactive({ x: 0, y: 0, sichtbar: false })
let raf = 0

watch([stufe, wert], ([neu], [alt]) => {
  cancelAnimationFrame(raf)
  token.sichtbar = false
  if (!aktiveKante.value || neu !== (alt as number) + 1) return
  nextTick(() => {
    const p = mess.value
    if (!p || typeof p.getTotalLength !== 'function') return
    const L = p.getTotalLength()
    if (!L) return
    const dauer = Math.min(1100, 350 + L * 2.2)
    const t0 = performance.now()
    token.sichtbar = true
    const tick = (t: number) => {
      const f = Math.min(1, (t - t0) / dauer)
      const e = f < 0.5 ? 2 * f * f : 1 - (-2 * f + 2) ** 2 / 2
      const pt = p.getPointAtLength(e * L)
      token.x = pt.x
      token.y = pt.y
      if (f < 1) raf = requestAnimationFrame(tick)
      else token.sichtbar = false
    }
    raf = requestAnimationFrame(tick)
  })
})
onBeforeUnmount(() => cancelAnimationFrame(raf))

const raute = (k: Knoten) =>
  `${k.x},${k.y - k.h / 2} ${k.x + k.w / 2},${k.y} ${k.x},${k.y + k.h / 2} ${k.x - k.w / 2},${k.y}`
</script>

<template>
<div class="fl">
  <div class="fl-kopf">
    <div class="fl-titel">{{ titel ?? def.titel }}</div>
    <div class="fl-wahl" role="group" :aria-label="`Startwert für ${def.wertName}`">
      <span class="fl-wahl-name">{{ def.wertName }} =</span>
      <button
        v-for="w in def.werte"
        :key="w"
        type="button"
        class="fl-knopf"
        :class="{ 'is-an': w === wert }"
        @click.stop="wert = w"
      >{{ w }}</button>
    </div>
    <div class="fl-zaehler">Schritt {{ stufe }} / {{ gesamt }}</div>
  </div>

  <div class="fl-buehne">
    <!-- Code -->
    <div class="fl-code" aria-label="Quellcode">
      <div class="fl-code-kopf"><span>{{ def.datei }}</span><span>C#</span></div>
      <div
        v-for="z in zeilen"
        :key="z.nr"
        class="fl-ln"
        :class="{ 'is-cur': z.cur, 'is-grau': z.grau }"
      >
        <span class="fl-no">{{ z.nr }}</span>
        <span class="fl-arr">{{ z.cur ? '▶' : '' }}</span>
        <span class="fl-txt" v-html="z.html" />
      </div>
    </div>

    <!-- Flussdiagramm -->
    <div class="fl-diagramm">
      <svg :viewBox="`0 0 ${def.vb[0]} ${def.vb[1]}`" preserveAspectRatio="xMidYMin meet" role="img" :aria-label="`Flussdiagramm: ${def.titel}`">
        <defs>
          <marker v-for="z in ['offen', 'besucht', 'aktiv', 'tot']" :id="`fl-pf-${z}-${uid}`" :key="z"
                  viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
            <path d="M0 0 L10 5 L0 10 z" :class="`fl-pf fl-pf-${z}`" />
          </marker>
        </defs>

        <g class="fl-kanten">
          <path v-for="k in kanten" :key="k.key" :d="k.d"
                :class="`fl-kante is-${k.zustand}`"
                :marker-end="`url(#fl-pf-${k.zustand}-${uid})`" />
        </g>
        <g class="fl-labels">
          <template v-for="k in kanten" :key="`l-${k.key}`">
            <text v-if="k.label" :x="k.lx" :y="k.ly" :text-anchor="k.anker ?? 'middle'"
                  :class="`fl-label is-${k.zustand}`">{{ k.label }}</text>
            <text v-if="k.zaehler && k.n > 0" :x="k.zaehler[0]" :y="k.zaehler[1]"
                  class="fl-anzahl">{{ k.n }}×</text>
          </template>
        </g>

        <g v-for="k in knoten" :key="k.id" :class="['fl-knoten', `is-${k.zustand}`, `typ-${k.typ}`, k.f ? `farbe-${k.f}` : '']">
          <polygon v-if="k.typ === 'frage'" :points="raute(k)" />
          <rect v-else :x="k.x - k.w / 2" :y="k.y - k.h / 2" :width="k.w" :height="k.h"
                :rx="k.typ === 'aktion' ? 6 : k.h / 2" />
          <text :x="k.x" :y="k.y" text-anchor="middle" dominant-baseline="central">{{ k.text }}</text>
        </g>

        <path ref="mess" :d="aktiveKante?.d ?? 'M0 0'" fill="none" stroke="none" />
        <circle v-show="token.sichtbar" :cx="token.x" :cy="token.y" r="7" class="fl-token" />
      </svg>
    </div>

    <!-- Seitenleiste -->
    <div class="fl-seite">
      <section class="fl-panel">
        <div class="fl-h">Was passiert gerade?</div>
        <p class="fl-note">{{ aktuell.n }}</p>
        <div v-if="auswertung" class="fl-eval">
          {{ auswertung.weg }} →
          <span class="fl-res" :class="auswertung.ok ? 'is-true' : 'is-false'">{{ auswertung.ergebnis }}</span>
        </div>
      </section>

      <section class="fl-panel">
        <div class="fl-h">
          <span>Variablen</span>
          <span v-if="def.schleife" class="fl-dl">Durchläufe: <b>{{ aktuell.dl ?? 0 }}</b></span>
        </div>
        <p v-if="!variablen.length" class="fl-leer">{{ aktuell.vh ?? 'Noch keine Variablen.' }}</p>
        <div class="fl-vars">
          <div v-for="v in variablen" :key="v.k" class="fl-var" :class="{ 'is-neu': v.neu }">
            <span class="fl-name">{{ v.k }}</span>
            <span class="fl-val">{{ v.v }}</span>
          </div>
        </div>
        <div v-if="def.schleife && pruefungen.length" class="fl-pruef">
          <span class="fl-pruef-h">Geprüft:</span>
          <span v-for="(p, i) in pruefungen" :key="i" class="fl-chip" :class="p.ok ? 'is-true' : 'is-false'">
            {{ p.t }} {{ p.ok ? '✓' : '✗' }}
          </span>
        </div>
      </section>

      <section class="fl-panel">
        <div class="fl-h">Konsole</div>
        <div class="fl-console">
          <div v-for="(a, i) in ausgaben" :key="i" :class="{ 'is-neu': a.neu }">{{ a.t }}</div>
          <span class="fl-cursor">_</span>
        </div>
      </section>
    </div>
  </div>
</div>
</template>

<style>
/* FlussAblauf – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.fl {
  --fl-bg: #ffffff;
  --fl-fg: #17202b;
  --fl-muted: #5b6676;
  --fl-rule: #d5dce6;
  --fl-soft: #eef1f5;
  --fl-neu: #0b7a55;
  --fl-neu-bg: #dcf3ea;
  --fl-true: #0b7a55;
  --fl-true-bg: #dcf3ea;
  --fl-false: #b42318;
  --fl-false-bg: #fde4e1;
  --fl-node-bg: #ffffff;
  --fl-node-line: #9aa6b6;
  --fl-node-fg: #17202b;
  --fl-besucht: #3a6fd8;
  --fl-besucht-bg: #e8effc;
  --fl-aktiv: #e0a800;
  --fl-aktiv-bg: #fff4c7;
  --fl-tot: #c7ced8;
  --fl-a: #2563eb;
  --fl-b: #d97706;
  --fl-c: #7c3aed;
  --fl-code-bg: #121a26;
  --fl-code-fg: #dfe6f0;
  --fl-code-dim: #6f7c90;
  --fl-code-rule: #253246;
  --fl-ptr: #f5c518;
  --fl-ptr-bg: #3a3214;
  --fl-kw: #8fb4ff;
  --fl-str: #f0a46b;
  --fl-num: #c9a4ff;
  --fl-typ: #6fd3c1;
  box-sizing: border-box;
  position: absolute;
  inset: 0;
  overflow: hidden;
  width: 100%;
  height: 100%;
  padding: 14px 20px 16px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  background: var(--fl-bg);
  color: var(--fl-fg);
  font-size: 13px;
  line-height: 1.35;
  text-align: left;
}
.dark .fl, .fl.dark {
  --fl-bg: #121a21;
  --fl-fg: #e6ebf2;
  --fl-muted: #98a4b5;
  --fl-rule: #2a3546;
  --fl-soft: #1a2430;
  --fl-neu: #5fd3a6;
  --fl-neu-bg: #123a2d;
  --fl-true: #5fd3a6;
  --fl-true-bg: #123a2d;
  --fl-false: #ff8a7a;
  --fl-false-bg: #44201c;
  --fl-node-bg: #17212b;
  --fl-node-line: #4c5a6c;
  --fl-node-fg: #e6ebf2;
  --fl-besucht: #79a2f2;
  --fl-besucht-bg: #1a2a45;
  --fl-aktiv: #f5c518;
  --fl-aktiv-bg: #3a3214;
  --fl-tot: #2f3a48;
  --fl-a: #6f9cff;
  --fl-b: #f2a541;
  --fl-c: #b18cff;
  --fl-code-bg: #0a1018;
  --fl-code-rule: #1f2a3b;
}
.fl *, .fl *::before, .fl *::after { box-sizing: border-box; }

/* Text-Resets gegen Theme-Stile von Slidev */
.fl p, .fl span, .fl div { margin: 0; }
.fl mark { background: transparent; color: inherit; border-bottom: 2px solid var(--fl-ptr); padding-bottom: 1px; }
.fl mark.fl-m-a { border-bottom-color: var(--fl-a); background: color-mix(in srgb, var(--fl-a) 30%, transparent); }
.fl mark.fl-m-b { border-bottom-color: var(--fl-b); background: color-mix(in srgb, var(--fl-b) 30%, transparent); }
.fl mark.fl-m-c { border-bottom-color: var(--fl-c); background: color-mix(in srgb, var(--fl-c) 34%, transparent); }

/* ---------- Kopf ---------- */
.fl-kopf { display: flex; align-items: center; gap: 16px; }
.fl-titel { font-size: 26px; font-weight: 800; letter-spacing: -0.01em; line-height: 1.1; flex: 1; }
.fl-wahl { display: flex; align-items: center; gap: 5px; }
.fl-wahl-name { font-family: ui-monospace, "JetBrains Mono", Consolas, monospace; font-size: 13px; color: var(--fl-muted); margin-right: 2px !important; }
.fl-knopf {
  font: 600 13px ui-monospace, "JetBrains Mono", Consolas, monospace;
  min-width: 2.4em;
  padding: 3px 8px;
  border: 1.5px solid var(--fl-rule);
  border-radius: 6px;
  background: transparent;
  color: var(--fl-fg);
  cursor: pointer;
}
.fl-knopf:hover { border-color: var(--fl-besucht); }
.fl-knopf.is-an { background: var(--fl-besucht); border-color: var(--fl-besucht); color: #fff; }
.fl-zaehler { font-family: ui-monospace, "JetBrains Mono", Consolas, monospace; font-size: 12px; color: var(--fl-muted); min-width: 7.5em; text-align: right; }

.fl-buehne {
  flex: 1;
  min-height: 0;
  display: grid;
  grid-template-columns: 368px minmax(0, 1fr) 250px;
  gap: 12px;
  align-items: start;
}

/* ---------- Code ---------- */
.fl-code {
  background: var(--fl-code-bg);
  color: var(--fl-code-fg);
  border-radius: 10px;
  padding: 8px 0 10px;
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 12px;
  overflow: hidden;
}
.fl-code-kopf {
  display: flex; justify-content: space-between;
  padding: 0 12px 6px; margin-bottom: 4px !important;
  color: var(--fl-code-dim); font-size: 10.5px; letter-spacing: .06em; text-transform: uppercase;
  border-bottom: 1px solid var(--fl-code-rule);
}
.fl-ln {
  display: grid;
  grid-template-columns: 2em 1.3em auto;
  align-items: center;
  min-height: 1.62em;
  padding-right: 8px;
  white-space: pre;
  border-left: 3px solid transparent;
  transition: background .2s, opacity .3s;
}
.fl-no { color: var(--fl-code-dim); text-align: right; padding-right: .5em; }
.fl-arr { color: var(--fl-ptr); font-weight: 700; }
.fl-ln.is-cur { background: var(--fl-ptr-bg); border-left-color: var(--fl-ptr); }
.fl-ln.is-cur .fl-no { color: var(--fl-ptr); }
.fl-ln.is-grau { opacity: .28; }
.fl-ln.is-grau .fl-txt { text-decoration: line-through; text-decoration-color: rgba(255, 255, 255, .35); }
.fl-k { color: var(--fl-kw); }
.fl-s { color: var(--fl-str); }
.fl-n { color: var(--fl-num); }
.fl-t { color: var(--fl-typ); }

/* ---------- Diagramm ---------- */
.fl-diagramm { height: 100%; min-height: 0; display: flex; justify-content: center; }
.fl-diagramm svg { width: 100%; height: 100%; overflow: visible; }

.fl-kante { fill: none; stroke-width: 1.8; stroke-linejoin: round; transition: stroke .25s; }
.fl-kante.is-offen { stroke: var(--fl-node-line); }
.fl-kante.is-besucht { stroke: var(--fl-besucht); stroke-width: 2.4; }
.fl-kante.is-tot { stroke: var(--fl-tot); stroke-dasharray: 4 4; }
.fl-kante.is-aktiv {
  stroke: var(--fl-aktiv); stroke-width: 3.2;
  stroke-dasharray: 9 6;
  animation: fl-fluss .7s linear infinite;
}
@keyframes fl-fluss { to { stroke-dashoffset: -15; } }

.fl-pf-offen { fill: var(--fl-node-line); }
.fl-pf-besucht { fill: var(--fl-besucht); }
.fl-pf-aktiv { fill: var(--fl-aktiv); }
.fl-pf-tot { fill: var(--fl-tot); }

.fl-label { font: 600 11px system-ui, sans-serif; fill: var(--fl-muted); }
.fl-label.is-besucht { fill: var(--fl-besucht); }
.fl-label.is-aktiv { fill: var(--fl-aktiv); font-weight: 800; }
.fl-label.is-tot { fill: var(--fl-tot); }
.fl-anzahl { font: 800 13px ui-monospace, "JetBrains Mono", Consolas, monospace; fill: var(--fl-besucht); }

.fl-knoten rect, .fl-knoten polygon {
  fill: var(--fl-node-bg);
  stroke: var(--fl-node-line);
  stroke-width: 1.6;
  transition: fill .25s, stroke .25s;
}
.fl-knoten text { font: 600 12px ui-monospace, "JetBrains Mono", Consolas, monospace; fill: var(--fl-node-fg); }
.fl-knoten.typ-start text, .fl-knoten.typ-ende text { font-family: system-ui, sans-serif; font-weight: 700; }
.fl-knoten.typ-start rect, .fl-knoten.typ-ende rect { fill: var(--fl-soft); }
.fl-knoten.farbe-a rect, .fl-knoten.farbe-a polygon { stroke: var(--fl-a); stroke-width: 2.4; }
.fl-knoten.farbe-b rect, .fl-knoten.farbe-b polygon { stroke: var(--fl-b); stroke-width: 2.4; }
.fl-knoten.farbe-c rect, .fl-knoten.farbe-c polygon { stroke: var(--fl-c); stroke-width: 2.4; }
.fl-knoten.is-besucht rect, .fl-knoten.is-besucht polygon { fill: var(--fl-besucht-bg); stroke: var(--fl-besucht); }
.fl-knoten.is-aktiv rect, .fl-knoten.is-aktiv polygon {
  fill: var(--fl-aktiv-bg); stroke: var(--fl-aktiv); stroke-width: 3;
  animation: fl-puls 1.4s ease-in-out infinite;
}
.fl-knoten.is-tot rect, .fl-knoten.is-tot polygon { stroke: var(--fl-tot); stroke-dasharray: 4 3; }
.fl-knoten.is-tot text { fill: var(--fl-tot); }
@keyframes fl-puls { 50% { stroke-width: 5; } }

.fl-token { fill: var(--fl-aktiv); stroke: var(--fl-bg); stroke-width: 2.5; filter: drop-shadow(0 0 4px var(--fl-aktiv)); }

/* ---------- Seitenleiste ---------- */
.fl-seite { display: flex; flex-direction: column; gap: 8px; min-width: 0; font-family: system-ui, "Segoe UI", Roboto, sans-serif; }
.fl-panel { border: 1px solid var(--fl-rule); border-radius: 10px; padding: 7px 10px 9px; }
.fl-h {
  display: flex; justify-content: space-between; align-items: baseline;
  font-size: 10.5px; font-weight: 700; letter-spacing: .09em; text-transform: uppercase;
  color: var(--fl-muted); margin-bottom: 4px !important;
}
.fl-dl { letter-spacing: .04em; }
.fl-dl b { color: var(--fl-besucht); font-size: 13px; }
.fl-note { font-size: 13px; line-height: 1.4; }
.fl-eval {
  display: inline-block;
  margin-top: 6px !important;
  padding: 3px 8px;
  border-radius: 6px;
  background: var(--fl-soft);
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 12px;
}
.fl-res { font-weight: 800; padding: 0 4px; border-radius: 4px; }
.fl-res.is-true, .fl-chip.is-true { color: var(--fl-true); background: var(--fl-true-bg); }
.fl-res.is-false, .fl-chip.is-false { color: var(--fl-false); background: var(--fl-false-bg); }
.fl-leer { color: var(--fl-muted); font-style: italic; font-size: 12px; }

.fl-vars { display: flex; flex-wrap: wrap; gap: 8px; }
.fl-var { display: flex; flex-direction: column; gap: 1px; font-family: ui-monospace, "JetBrains Mono", Consolas, monospace; }
.fl-name { font-size: 11px; color: var(--fl-muted); }
.fl-val {
  min-width: 3em; text-align: center;
  padding: 2px 9px;
  border: 1.5px solid var(--fl-rule); border-radius: 6px;
  font-size: 15px; font-weight: 700; font-variant-numeric: tabular-nums;
}
.fl-var.is-neu .fl-val { border-color: var(--fl-neu); background: var(--fl-neu-bg); color: var(--fl-neu); }
.fl-var.is-neu .fl-name::after { content: " neu"; color: var(--fl-neu); font-weight: 700; }

.fl-pruef { display: flex; flex-wrap: wrap; gap: 4px; align-items: center; margin-top: 7px !important; }
.fl-pruef-h { font-size: 11px; color: var(--fl-muted); margin-right: 2px !important; }
.fl-chip { font: 600 11px ui-monospace, "JetBrains Mono", Consolas, monospace; padding: 1px 5px; border-radius: 4px; }

.fl-console {
  background: var(--fl-code-bg);
  color: var(--fl-code-fg);
  border-radius: 6px;
  padding: 6px 10px;
  min-height: 2.6em;
  max-height: 9.5em;
  overflow: hidden;
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 12.5px;
  line-height: 1.35;
  white-space: pre-wrap;
}
.fl-console .is-neu { color: var(--fl-ptr); }
.fl-cursor { color: var(--fl-code-dim); }
</style>
