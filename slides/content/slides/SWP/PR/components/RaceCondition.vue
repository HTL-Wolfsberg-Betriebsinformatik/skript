<!--
  RaceCondition.vue – Zwei Threads erhöhen dieselbe Variable, eine Erhöhung geht verloren
  Ablage: components/RaceCondition.vue (Slidev registriert die Komponente automatisch)

  Verwendung (Schritt für Schritt, 4 Klicks):
    ---
    layout: none
    clicks: 4
    ---
    <RaceCondition :schritt="$clicks" />

  Ohne :schritt ist sofort alles sichtbar.
  Ausgelegt für die Slidev-Fläche 980 × 552. Dunkles Design folgt dem Slidev-Dark-Mode (html.dark).
-->
<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(defineProps<{
  schritt?: number | 'alle'
  titel?: string
}>(), {
  schritt: 'alle',
  titel: 'Zwei Threads, eine Variable',
})

// 0 = Startzustand, 1 = lesen, 2 = rechnen, 3 = schreiben, 4 = Lösung mit lock
const stufe = computed(() =>
  typeof props.schritt === 'number'
    ? String(Math.min(Math.max(props.schritt, 0), 4))
    : 'alle'
)
</script>

<template>
<div class="rc" :data-schritt="stufe">
  <div class="rc-titel">{{ titel }}</div>

  <!-- Thread A -->
  <div class="rc-thread rc-a">
    <b class="rc-name">Thread A</b>
    <div class="rc-zettel">
      <span class="rc-notiz-kopf">Notizzettel</span>
      <span class="rc-zeile" data-e="1">gelesen: <b>5</b></span>
      <span class="rc-zeile" data-e="2">5 + 1 = <b>6</b></span>
      <span class="rc-zeile" data-e="3">schreibt <b>6</b> (zuerst)</span>
    </div>
  </div>

  <!-- Pfeile links -->
  <span class="rc-pfeil rc-pfeil-l rc-p-lesen rc-p-links" data-e="1"></span>
  <span class="rc-pfeil rc-pfeil-r rc-p-schreiben rc-p-links" data-e="3"></span>

  <!-- Speicherzelle -->
  <div class="rc-zelle">
    <code class="rc-zelle-name">lagerstand</code>
    <div class="rc-wert">
      <span class="rc-wert-alt">5</span>
      <span class="rc-wert-neu">6</span>
    </div>
    <span class="rc-erwartet" data-e="3">erwartet: 7</span>
    <span class="rc-verloren" data-e="3">Eine Erhöhung ist verloren.</span>
  </div>

  <!-- Pfeile rechts -->
  <span class="rc-pfeil rc-pfeil-r rc-p-lesen rc-p-rechts" data-e="1"></span>
  <span class="rc-pfeil rc-pfeil-l rc-p-schreiben rc-p-rechts" data-e="3"></span>

  <!-- Thread B -->
  <div class="rc-thread rc-b">
    <b class="rc-name">Thread B</b>
    <div class="rc-zettel">
      <span class="rc-notiz-kopf">Notizzettel</span>
      <span class="rc-zeile" data-e="1">gelesen: <b>5</b></span>
      <span class="rc-zeile" data-e="2">5 + 1 = <b>6</b></span>
      <span class="rc-zeile" data-e="3">schreibt <b>6</b> (danach)</span>
    </div>
  </div>

  <!-- Lösung -->
  <div class="rc-loesung" data-e="4">
    <div class="rc-sperre">
      <svg class="rc-schloss" viewBox="0 0 40 48" aria-hidden="true">
        <path class="rc-buegel" d="M10 22 V14 A10 10 0 0 1 30 14 V22" />
        <rect class="rc-koerper" x="4" y="21" width="32" height="25" rx="4" />
        <circle class="rc-loch" cx="20" cy="33" r="4" />
      </svg>
      <span class="rc-chip">lesen</span>
      <span class="rc-kette">→</span>
      <span class="rc-chip">rechnen</span>
      <span class="rc-kette">→</span>
      <span class="rc-chip">schreiben</span>
    </div>
    <code class="rc-code">lock (sperre) { lagerstand++; }</code>
    <span class="rc-ergebnis">B wartet, bis A fertig ist → <b>7</b></span>
  </div>
</div>
</template>

<style>
/* RaceCondition – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.rc {
  --rc-bg: #ffffff;
  --rc-fg: #16212c;
  --rc-muted: #5a6876;
  --rc-line: #d4dce3;
  --rc-a: #2c64c4;
  --rc-b: #c8620e;
  --rc-gut: #17835a;
  --rc-rot: #b83a3a;
  box-sizing: border-box;
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: var(--rc-bg);
  color: var(--rc-fg);
  font-size: 14px;
  line-height: 1.25;
  text-align: left;
}
.dark .rc, .rc.dark {
  --rc-bg: #121a21;
  --rc-fg: #e6edf3;
  --rc-muted: #9aabba;
  --rc-line: #2e3b48;
  --rc-a: #6fa1f2;
  --rc-b: #f0a04b;
  --rc-gut: #4fc58f;
  --rc-rot: #f07a7a;
}
.rc *, .rc *::before, .rc *::after { box-sizing: border-box; }

/* Text-Resets gegen Theme-Stile von Slidev */
.rc.rc b, .rc.rc span, .rc.rc code { margin: 0; line-height: 1.25; }
.rc.rc code {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  background: none; padding: 0; border: 0; border-radius: 0;
}

.rc .rc-titel { position: absolute; left: 24px; top: 14px; font-size: 28px; font-weight: 800; letter-spacing: -0.01em; }

/* ---------- Threads ---------- */
.rc-thread {
  position: absolute; top: 66px; width: 270px; height: 236px;
  padding: 12px 14px;
  border: 2px solid var(--h);
  border-radius: 12px;
  background: color-mix(in srgb, var(--h) 7%, var(--rc-bg));
}
.rc-a { --h: var(--rc-a); left: 24px; }
.rc-b { --h: var(--rc-b); right: 24px; }
.rc .rc-name { display: block; font-size: 20px; font-weight: 800; color: var(--h); }

.rc-zettel {
  margin-top: 10px; height: 170px; padding: 10px 12px;
  display: flex; flex-direction: column; gap: 8px;
  border: 1.5px dashed var(--h);
  border-radius: 8px;
  background: var(--rc-bg);
}
.rc .rc-notiz-kopf { font-size: 11px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: var(--rc-muted); }
.rc .rc-zeile { display: block; font-size: 19px; transition: opacity .3s ease, filter .3s ease; }
.rc .rc-zeile b { font-weight: 800; color: var(--h); }

/* ---------- Speicherzelle ---------- */
.rc-zelle {
  position: absolute; left: 354px; top: 66px; width: 272px; height: 236px;
  padding-top: 12px;
  display: flex; flex-direction: column; align-items: center;
  border: 2.5px solid var(--rc-muted);
  border-radius: 12px;
  transition: border-color .3s ease, background .3s ease;
}
.rc .rc-zelle-name { font-size: 18px; font-weight: 700; }
.rc-wert { height: 112px; display: flex; align-items: center; }
.rc .rc-wert span { font-size: 88px; font-weight: 800; line-height: 1; }
.rc .rc-wert-alt { display: none; }
.rc .rc-wert-neu { color: var(--rc-rot); }
.rc .rc-erwartet { font-size: 20px; font-weight: 800; color: var(--rc-rot); transition: opacity .3s ease, filter .3s ease; }
.rc .rc-verloren { margin-top: 4px; font-size: 14px; color: var(--rc-rot); transition: opacity .3s ease, filter .3s ease; }

/* ---------- Pfeile ---------- */
.rc-pfeil {
  position: absolute; width: 44px; height: 2.5px;
  background: var(--h);
  transition: opacity .3s ease, filter .3s ease;
}
.rc-p-links { --h: var(--rc-a); left: 301px; }
.rc-p-rechts { --h: var(--rc-b); left: 635px; }
.rc-p-lesen { top: 158px; }
.rc-p-schreiben { top: 232px; }
.rc-pfeil::after {
  content: ""; position: absolute; top: 50%; transform: translateY(-50%);
  border: 7px solid transparent;
}
.rc-pfeil-r::after { right: -2px; border-left: 11px solid var(--h); border-right: 0; }
.rc-pfeil-l::after { left: -2px; border-right: 11px solid var(--h); border-left: 0; }

/* ---------- Lösung ---------- */
.rc-loesung {
  position: absolute; left: 24px; right: 24px; top: 318px; height: 214px;
  display: flex; flex-direction: column; align-items: center; gap: 10px;
  padding-top: 26px;
  border-radius: 12px;
  background: color-mix(in srgb, var(--rc-gut) 8%, var(--rc-bg));
  transition: opacity .3s ease, filter .3s ease;
}
.rc-sperre {
  position: relative;
  padding: 14px 24px 14px 52px;
  display: flex; align-items: center; gap: 12px;
  border: 3px solid var(--rc-gut);
  border-radius: 12px;
  background: var(--rc-bg);
}
.rc-schloss { position: absolute; left: -22px; top: -16px; width: 56px; height: 67px; }
.rc-buegel { fill: none; stroke: var(--rc-gut); stroke-width: 5; }
.rc-koerper { fill: var(--rc-gut); }
.rc-loch { fill: var(--rc-bg); }
.rc .rc-chip {
  padding: 5px 13px;
  border: 1.5px solid var(--rc-gut);
  border-radius: 7px;
  font-size: 17px; font-weight: 700;
}
.rc .rc-kette { font-size: 19px; color: var(--rc-muted); }
.rc .rc-code { font-size: 21px; font-weight: 700; }
.rc .rc-ergebnis { font-size: 20px; }
.rc .rc-ergebnis b { font-weight: 800; color: var(--rc-gut); }

/* ---------- Schritte (Klicks) ---------- */
/* Kumulativ: Was noch nicht dran ist, bleibt grau; ohne Schritt-Angabe ("alle") ist alles sichtbar */
.rc[data-schritt="0"] [data-e],
.rc[data-schritt="1"] [data-e="2"],
.rc[data-schritt="1"] [data-e="3"],
.rc[data-schritt="1"] [data-e="4"],
.rc[data-schritt="2"] [data-e="3"],
.rc[data-schritt="2"] [data-e="4"],
.rc[data-schritt="3"] [data-e="4"] { opacity: 0.18; filter: grayscale(1); }

/* Vor dem Schreiben steht noch der Startwert in der Zelle */
.rc[data-schritt="0"] .rc-wert-alt,
.rc[data-schritt="1"] .rc-wert-alt,
.rc[data-schritt="2"] .rc-wert-alt { display: inline; }
.rc[data-schritt="0"] .rc-wert-neu,
.rc[data-schritt="1"] .rc-wert-neu,
.rc[data-schritt="2"] .rc-wert-neu { display: none; }

/* Ab dem Schreiben ist die Zelle falsch */
.rc[data-schritt="3"] .rc-zelle,
.rc[data-schritt="4"] .rc-zelle,
.rc[data-schritt="alle"] .rc-zelle {
  border-color: var(--rc-rot);
  background: color-mix(in srgb, var(--rc-rot) 9%, var(--rc-bg));
}

@media (prefers-reduced-motion: reduce) {
  .rc .rc-zeile, .rc-zelle, .rc .rc-erwartet, .rc .rc-verloren, .rc-pfeil, .rc-loesung { transition: none; }
}
</style>
