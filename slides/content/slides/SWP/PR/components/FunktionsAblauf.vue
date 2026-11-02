<!--
  FunktionsAblauf.vue – vereinfachter Debugger: Ablauf eines Funktionsaufrufs mit Parameter und Rückgabewert
  Ablage: components/FunktionsAblauf.vue (Slidev registriert die Komponente automatisch)

  Verwendung (Schritt für Schritt, 7 Klicks):
    ---
    layout: full
    clicks: 7
    ---
    <FunktionsAblauf :schritt="$clicks" />

  Ohne :schritt ist der Endzustand sichtbar.
  Ausgelegt für die Slidev-Fläche 980 × 552. Dunkles Design folgt dem Slidev-Dark-Mode (html.dark).
-->
<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(defineProps<{
  schritt?: number | 'alle'
  titel?: string
}>(), {
  schritt: 'alle',
  titel: 'Ablauf einer Funktion',
})

const H = 'Hauptprogramm'
const F = 'BerechneQuadrat'

const code = [
  'int BerechneQuadrat(int laenge)',
  '{',
  '    int ergebnis = laenge * laenge;',
  '    return ergebnis;',
  '}',
  '',
  'int seite = 5;',
  'int flaeche = BerechneQuadrat(seite);',
  'Console.WriteLine($"Fläche: {flaeche}");',
]

const intro = 'Das Programm wird gleich gestartet. In welcher Zeile beginnt es? (Tipp: nicht in Zeile 1.)'

// l = ausgeführte Zeile, p = gerade aktiver Teil der Zeile, f = Variablen je Bereich,
// e = Auswertung „Ausdruck → eingesetzt → Ergebnis“, o = neue Konsolenausgabe, n = Erklärung
type Schritt = {
  l: number
  p?: string
  f: [string, Record<string, number>][]
  e?: string
  o?: string
  n: string
}

const schritte: Schritt[] = [
  { l: 7, f: [[H, { seite: 5 }]],
    n: 'Das Programm beginnt bei der ersten Anweisung. Die Funktion oben wurde übersprungen: Sie ist nur eine Bauanleitung und läuft erst, wenn sie aufgerufen wird.' },
  { l: 8, p: 'BerechneQuadrat(seite)', f: [[H, { seite: 5 }]],
    n: 'Aufruf! Der Wert von seite, also 5, wird mitgegeben und das Programm springt in die Funktion. flaeche gibt es noch nicht, weil die rechte Seite noch nicht fertig ist.' },
  { l: 1, p: 'int laenge', f: [[H, { seite: 5 }], [F, { laenge: 5 }]],
    n: 'Die Funktion bekommt einen eigenen Bereich für ihre Variablen. Der Parameter laenge erhält eine Kopie des Werts: 5.' },
  { l: 3, f: [[H, { seite: 5 }], [F, { laenge: 5, ergebnis: 25 }]], e: 'laenge * laenge → 5 * 5 → 25',
    n: 'ergebnis gibt es nur innerhalb der Funktion. Das Hauptprogramm sieht diese Variable nicht.' },
  { l: 4, f: [[H, { seite: 5 }], [F, { laenge: 5, ergebnis: 25 }]], e: 'Rückgabewert → 25',
    n: 'return liefert 25 zurück und beendet die Funktion sofort. Ihr Bereich wird danach gelöscht.' },
  { l: 8, p: 'int flaeche =', f: [[H, { seite: 5, flaeche: 25 }]],
    n: 'Zurück an die Stelle des Aufrufs. Der Rückgabewert 25 wird in flaeche gespeichert. laenge und ergebnis sind weg.' },
  { l: 9, f: [[H, { seite: 5, flaeche: 25 }]], o: 'Fläche: 25',
    n: 'Fertig. seite ist unverändert 5, weil die Funktion nur eine Kopie bekommen hat.' },
]

const stufe = computed(() =>
  typeof props.schritt === 'number'
    ? Math.min(Math.max(props.schritt, 0), schritte.length)
    : schritte.length
)
const aktuell = computed(() => (stufe.value > 0 ? schritte[stufe.value - 1] : null))
const vorher = computed(() => (stufe.value > 1 ? schritte[stufe.value - 2] : null))

// ---------- Syntax-Hervorhebung ----------
const esc = (s: string) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
const RE = /(\$?"(?:[^"\\]|\\.)*")|\b(int|return|string|double|void)\b|\b(\d+)\b|\b(Console)\b/g

function hl(s: string) {
  let out = ''
  let last = 0
  s.replace(RE, (m, str, kw, num, _typ, off: number) => {
    out += esc(s.slice(last, off))
    out += `<span class="fa-${str ? 's' : kw ? 'k' : num ? 'n' : 't'}">${esc(m)}</span>`
    last = off + m.length
    return m
  })
  return out + esc(s.slice(last))
}

function zeileHtml(text: string, teil?: string) {
  const i = teil ? text.indexOf(teil) : -1
  if (!teil || i < 0) return hl(text) || '&nbsp;'
  return hl(text.slice(0, i)) + '<mark>' + hl(teil) + '</mark>' + hl(text.slice(i + teil.length))
}

const zeilen = computed(() =>
  code.map((text, i) => {
    const nr = i + 1
    const cur = aktuell.value?.l === nr
    return { nr, cur, html: zeileHtml(text, cur ? aktuell.value?.p : undefined) }
  })
)

// ---------- Auswertung ----------
const auswertung = computed(() => {
  const e = aktuell.value?.e
  if (!e) return null
  const teile = e.split(' → ')
  const ergebnis = teile.pop()!
  return { weg: teile.join(' → '), ergebnis }
})

// ---------- Variablen ----------
const bereiche = computed(() => {
  const alt: Record<string, Record<string, number>> = {}
  vorher.value?.f.forEach(([name, vars]) => (alt[name] = vars))
  return (aktuell.value?.f ?? []).map(([name, vars]) => ({
    name,
    funktion: name !== H,
    vars: Object.entries(vars).map(([k, v]) => ({
      k,
      v,
      neu: !alt[name] || alt[name][k] !== v,
    })),
  }))
})

// ---------- Konsole ----------
const ausgaben = computed(() =>
  schritte
    .slice(0, stufe.value)
    .map((s, i) => ({ t: s.o, neu: i === stufe.value - 1 }))
    .filter(a => a.t !== undefined)
)
</script>

<template>
<div class="fa">
  <div class="fa-kopf">
    <div class="fa-titel">{{ titel }}</div>
    <div class="fa-zaehler">Schritt {{ stufe }} / {{ schritte.length }}</div>
  </div>

  <div class="fa-buehne">
    <div class="fa-code" aria-label="Quellcode">
      <div class="fa-code-kopf"><span>Program.cs</span><span>C#</span></div>
      <div v-for="z in zeilen" :key="z.nr" class="fa-ln" :class="{ 'is-cur': z.cur }">
        <span class="fa-no">{{ z.nr }}</span>
        <span class="fa-arr">{{ z.cur ? '▶' : '' }}</span>
        <span class="fa-txt" v-html="z.html" />
      </div>
    </div>

    <div class="fa-seite">
      <section class="fa-panel">
        <div class="fa-h">Was passiert gerade?</div>
        <p class="fa-note">{{ aktuell ? aktuell.n : intro }}</p>
        <div v-if="auswertung" class="fa-eval">
          {{ auswertung.weg }} → <span class="fa-res">{{ auswertung.ergebnis }}</span>
        </div>
      </section>

      <section class="fa-panel">
        <div class="fa-h">Variablen</div>
        <p v-if="!bereiche.length" class="fa-leer">Noch keine Variablen.</p>
        <div v-for="b in bereiche" :key="b.name" class="fa-frame" :class="{ 'is-fn': b.funktion }">
          <span class="fa-fname">{{ b.name }}</span>
          <div class="fa-vars">
            <div v-for="v in b.vars" :key="v.k" class="fa-var" :class="{ 'is-neu': v.neu }">
              <span class="fa-name">{{ v.k }}</span>
              <span class="fa-val">{{ v.v }}</span>
            </div>
          </div>
        </div>
      </section>

      <section class="fa-panel">
        <div class="fa-h">Konsole</div>
        <div class="fa-console">
          <div v-for="(a, i) in ausgaben" :key="i" :class="{ 'is-neu': a.neu }">{{ a.t }}</div>
          <span class="fa-cursor">_</span>
        </div>
      </section>
    </div>
  </div>
</div>
</template>

<style>
/* Ablauf einer Funktion – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.fa {
  --fa-bg: #ffffff;
  --fa-fg: #17202b;
  --fa-muted: #5b6676;
  --fa-rule: #d5dce6;
  --fa-soft: #eef1f5;
  --fa-neu: #0b7a55;
  --fa-neu-bg: #dcf3ea;
  --fa-fn: #1f56c4;
  --fa-code-bg: #121a26;
  --fa-code-fg: #dfe6f0;
  --fa-code-dim: #6f7c90;
  --fa-code-rule: #253246;
  --fa-ptr: #f5c518;
  --fa-ptr-bg: #3a3214;
  --fa-kw: #8fb4ff;
  --fa-str: #f0a46b;
  --fa-num: #c9a4ff;
  --fa-typ: #6fd3c1;
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  padding: 18px 24px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  background: var(--fa-bg);
  color: var(--fa-fg);
  font-size: 14px;
  line-height: 1.35;
  text-align: left;
}
.dark .fa, .fa.dark {
  --fa-bg: #121a21;
  --fa-fg: #e6ebf2;
  --fa-muted: #98a4b5;
  --fa-rule: #2a3546;
  --fa-soft: #1a2430;
  --fa-neu: #5fd3a6;
  --fa-neu-bg: #123a2d;
  --fa-fn: #6f9cff;
  --fa-code-bg: #0a1018;
  --fa-code-rule: #1f2a3b;
}
.fa *, .fa *::before, .fa *::after { box-sizing: border-box; }

/* Text-Resets gegen Theme-Stile von Slidev */
.fa p, .fa span, .fa div { margin: 0; }
.fa mark { background: transparent; color: inherit; border-bottom: 2px solid var(--fa-ptr); padding-bottom: 1px; }

.fa-kopf { display: flex; justify-content: space-between; align-items: baseline; }
.fa-titel { font-size: 28px; font-weight: 800; letter-spacing: -0.01em; line-height: 1.1; }
.fa-zaehler { font-family: ui-monospace, "JetBrains Mono", Consolas, monospace; font-size: 13px; color: var(--fa-muted); }

.fa-buehne {
  flex: 1;
  min-height: 0;
  display: grid;
  grid-template-columns: minmax(0, 1.15fr) minmax(0, 1fr);
  gap: 14px;
  align-items: start;
}

/* ---------- Code ---------- */
.fa-code {
  background: var(--fa-code-bg);
  color: var(--fa-code-fg);
  border-radius: 10px;
  padding: 10px 0 12px;
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 14px;
}
.fa-code-kopf {
  display: flex; justify-content: space-between;
  padding: 0 14px 8px; margin-bottom: 6px;
  color: var(--fa-code-dim); font-size: 11px; letter-spacing: .06em; text-transform: uppercase;
  border-bottom: 1px solid var(--fa-code-rule);
}
.fa-ln {
  display: grid;
  grid-template-columns: 2.2em 1.4em auto;
  align-items: center;
  min-height: 1.85em;
  padding-right: 12px;
  white-space: pre;
  border-left: 3px solid transparent;
  transition: background .15s;
}
.fa-no { color: var(--fa-code-dim); text-align: right; padding-right: .5em; }
.fa-arr { color: var(--fa-ptr); font-weight: 700; }
.fa-ln.is-cur { background: var(--fa-ptr-bg); border-left-color: var(--fa-ptr); }
.fa-ln.is-cur .fa-no { color: var(--fa-ptr); }
.fa-k { color: var(--fa-kw); }
.fa-s { color: var(--fa-str); }
.fa-n { color: var(--fa-num); }
.fa-t { color: var(--fa-typ); }

/* ---------- Seitenleiste ---------- */
.fa-seite { display: flex; flex-direction: column; gap: 10px; min-width: 0; }
.fa-panel {
  border: 1px solid var(--fa-rule);
  border-radius: 10px;
  padding: 8px 12px 10px;
}
.fa-h {
  font-size: 11px; font-weight: 700; letter-spacing: .09em; text-transform: uppercase;
  color: var(--fa-muted); margin-bottom: 5px !important;
}
.fa-note { font-size: 14px; line-height: 1.4; }
.fa-eval {
  display: inline-block;
  margin-top: 7px !important;
  padding: 3px 9px;
  border-radius: 6px;
  background: var(--fa-soft);
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 13px;
}
.fa-res { font-weight: 700; color: var(--fa-neu); }
.fa-leer { color: var(--fa-muted); font-style: italic; }

.fa-frame {
  border: 1px dashed var(--fa-rule);
  border-radius: 8px;
  padding: 5px 9px 7px;
}
.fa-frame + .fa-frame { margin-top: 6px !important; }
.fa-frame.is-fn { border-color: var(--fa-fn); border-style: solid; }
.fa-fname { display: block; font-size: 11px; font-weight: 700; color: var(--fa-muted); margin-bottom: 3px !important; }
.fa-frame.is-fn .fa-fname { color: var(--fa-fn); }
.fa-vars { display: flex; flex-wrap: wrap; gap: 8px; }
.fa-var { display: flex; flex-direction: column; gap: 1px; font-family: ui-monospace, "JetBrains Mono", Consolas, monospace; }
.fa-name { font-size: 11px; color: var(--fa-muted); }
.fa-val {
  min-width: 3em; text-align: center;
  padding: 2px 9px;
  border: 1.5px solid var(--fa-rule); border-radius: 6px;
  font-size: 15px; font-weight: 700; font-variant-numeric: tabular-nums;
}
.fa-var.is-neu .fa-val { border-color: var(--fa-neu); background: var(--fa-neu-bg); color: var(--fa-neu); }
.fa-var.is-neu .fa-name::after { content: " neu"; color: var(--fa-neu); font-weight: 700; }

.fa-console {
  background: var(--fa-code-bg);
  color: var(--fa-code-fg);
  border-radius: 6px;
  padding: 6px 10px;
  min-height: 2.6em;
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 13px;
  white-space: pre-wrap;
}
.fa-console .is-neu { color: var(--fa-ptr); }
.fa-cursor { color: var(--fa-code-dim); }
</style>
