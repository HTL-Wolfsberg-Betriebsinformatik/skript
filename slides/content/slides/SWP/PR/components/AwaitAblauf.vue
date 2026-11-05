<!--
  AwaitAblauf.vue – Was bei await im Button-Klick wirklich passiert
  Ablage: components/AwaitAblauf.vue (Slidev registriert die Komponente automatisch)

  Verwendung (Schritt für Schritt, 4 Klicks):
    ---
    layout: none
    clicks: 4
    ---
    <AwaitAblauf :schritt="$clicks" />

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
  titel: 'Was bei await passiert',
})

// 0 = Ausgangslage, 1 = Zeile 3, 2 = Zeile 4, 3 = UI-Thread frei, 4 = Fortsetzung
const stufe = computed(() =>
  typeof props.schritt === 'number'
    ? String(Math.min(Math.max(props.schritt, 0), 4))
    : 'alle'
)

const kleineBalken = Array.from({ length: 10 }, (_, i) => i)
</script>

<template>
<div class="aw" :data-schritt="stufe">
  <div class="aw-titel">{{ titel }}</div>

  <!-- Code, Zeile für Zeile markierbar -->
  <div class="aw-code">
    <code class="aw-z" data-z="1"><i>private async void</i> btnLaden_Click(object sender, EventArgs e)</code>
    <code class="aw-z" data-z="2">{</code>
    <code class="aw-z" data-z="3">lblStatus.Text = "Lade …";</code>
    <code class="aw-z" data-z="4"><i>await</i> Task.Delay(5000);</code>
    <code class="aw-z" data-z="5">lblStatus.Text = "Fertig";<span class="aw-fort" data-e="2"><span>Fortsetzung</span></span></code>
    <code class="aw-z" data-z="6">}</code>
  </div>

  <!-- Das Fenster -->
  <div class="aw-fenster">
    <div class="aw-fenster-titel"><span>OnlineShop</span></div>
    <div class="aw-fenster-inhalt">
      <span class="aw-button">Artikel laden</span>
      <span class="aw-label">
        <b class="aw-l0">Status</b>
        <b class="aw-l1">Lade …</b>
        <b class="aw-l2">Fertig</b>
      </span>
    </div>
  </div>

  <!-- Spuren -->
  <b class="aw-spurname aw-n-ui">UI-Thread</b>
  <div class="aw-spur aw-spur-ui">
    <span class="aw-balken aw-b-ui" style="--von: 0px; --bis: 64px" data-e="1">Zeile 3</span>
    <span class="aw-frei-text" data-e="3">frei: Klicks, Neu zeichnen</span>
    <span
      v-for="i in kleineBalken"
      :key="i"
      class="aw-klein"
      :style="{ '--i': i }"
      data-e="3"
    ></span>
    <span class="aw-balken aw-b-ui" style="--von: 352px; --bis: 422px" data-e="4">Zeile 5</span>
  </div>

  <svg class="aw-pfeile" viewBox="0 0 422 90" aria-hidden="true">
    <defs>
      <marker id="aw-spitze" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto">
        <path d="M0,0 L10,5 L0,10 z" class="aw-spitze" />
      </marker>
    </defs>
    <path class="aw-linie" data-e="2" d="M70 4 V84" marker-end="url(#aw-spitze)" />
    <path class="aw-linie" data-e="4" d="M346 86 V6" marker-end="url(#aw-spitze)" />
  </svg>

  <b class="aw-spurname aw-n-zeit">Wartezeit</b>
  <div class="aw-spur aw-spur-zeit">
    <span class="aw-balken aw-b-zeit" style="--von: 70px; --bis: 346px" data-e="2">5 Sekunden vergehen</span>
  </div>

  <div class="aw-hinweis aw-h-frei" data-e="3">kein zusätzlicher Thread nötig</div>
  <div class="aw-hinweis aw-h-fort" data-e="4">Fortsetzung läuft wieder auf dem UI-Thread</div>
</div>
</template>

<style>
/* AwaitAblauf – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.aw {
  --aw-bg: #ffffff;
  --aw-fg: #16212c;
  --aw-muted: #5a6876;
  --aw-line: #d4dce3;
  --aw-ui: #2c64c4;
  --aw-frei: #17835a;
  --aw-zeit: #7a5b3c;
  --aw-auf-farbe: #ffffff;
  box-sizing: border-box;
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: var(--aw-bg);
  color: var(--aw-fg);
  font-size: 14px;
  line-height: 1.25;
  text-align: left;
}
.dark .aw, .aw.dark {
  --aw-bg: #121a21;
  --aw-fg: #e6edf3;
  --aw-muted: #9aabba;
  --aw-line: #2e3b48;
  --aw-ui: #6fa1f2;
  --aw-frei: #4fc58f;
  --aw-zeit: #c9a27c;
  --aw-auf-farbe: #121a21;
}
.aw *, .aw *::before, .aw *::after { box-sizing: border-box; }

/* Text-Resets gegen Theme-Stile von Slidev */
.aw.aw b, .aw.aw span, .aw.aw code { margin: 0; line-height: 1.25; }
.aw.aw code {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  background: none; padding: 0; border: 0; border-radius: 0;
}

.aw .aw-titel { position: absolute; left: 24px; top: 14px; font-size: 28px; font-weight: 800; letter-spacing: -0.01em; }

/* ---------- Code ---------- */
.aw-code {
  position: absolute; left: 24px; top: 66px; width: 486px; height: 262px;
  padding: 14px 10px;
  display: flex; flex-direction: column; justify-content: space-between;
  border: 1.5px solid var(--aw-line);
  border-radius: 10px;
  background: color-mix(in srgb, var(--aw-muted) 6%, var(--aw-bg));
}
.aw.aw .aw-z {
  position: relative;
  display: block;
  padding: 5px 6px;
  border-radius: 5px;
  font-size: 12.5px;
  white-space: pre;
  transition: background .25s ease;
}
/* Einrückung per CSS: Vue fasst Leerzeichen im Template zusammen */
.aw.aw .aw-z[data-z="3"], .aw.aw .aw-z[data-z="4"], .aw.aw .aw-z[data-z="5"] { padding-left: 36px; }
.aw .aw-z i { font-style: normal; font-weight: 700; color: var(--aw-ui); }

/* Gestricheltes Kästchen um Zeile 5 */
.aw .aw-fort {
  position: absolute; inset: 0;
  display: flex; align-items: center; justify-content: flex-end;
  padding-right: 8px;
  border: 2px dashed var(--aw-frei);
  border-radius: 5px;
  transition: opacity .3s ease, filter .3s ease;
}
.aw .aw-fort span {
  font-family: system-ui, sans-serif;
  font-size: 12px; font-weight: 700;
  color: var(--aw-frei);
}

/* ---------- Fenster ---------- */
.aw-fenster {
  position: absolute; left: 24px; top: 344px; width: 486px; height: 168px;
  border: 1.5px solid var(--aw-muted);
  border-radius: 8px;
  overflow: hidden;
}
.aw-fenster-titel { height: 30px; padding-inline: 12px; display: flex; align-items: center; background: var(--aw-ui); }
.aw .aw-fenster-titel span { font-size: 13px; font-weight: 700; color: var(--aw-auf-farbe); }
.aw-fenster-inhalt { height: 136px; padding-inline: 20px; display: flex; align-items: center; gap: 30px; }
.aw .aw-button {
  padding: 8px 16px;
  border: 1.5px solid var(--aw-muted);
  border-radius: 5px;
  background: color-mix(in srgb, var(--aw-muted) 12%, var(--aw-bg));
  font-size: 15px;
}
.aw .aw-label b { display: block; font-size: 22px; font-weight: 700; }
.aw.aw .aw-label .aw-l0, .aw.aw .aw-label .aw-l1 { display: none; }
.aw.aw .aw-label .aw-l2 { color: var(--aw-frei); }

/* ---------- Spuren ---------- */
.aw .aw-spurname { position: absolute; left: 534px; font-size: 16px; font-weight: 800; }
.aw .aw-n-ui { top: 66px; color: var(--aw-ui); }
.aw .aw-n-zeit { top: 272px; color: var(--aw-zeit); }

.aw-spur {
  position: absolute; left: 534px; width: 422px;
  background: color-mix(in srgb, var(--aw-muted) 8%, var(--aw-bg));
  border-radius: 6px;
}
.aw-spur-ui { top: 92px; height: 72px; }
.aw-spur-zeit { top: 298px; height: 60px; }

.aw .aw-balken {
  position: absolute; top: 0; bottom: 0;
  left: var(--von);
  width: calc(var(--bis) - var(--von));
  display: flex; align-items: center; justify-content: center;
  border-radius: 6px;
  font-size: 13px; font-weight: 700;
  color: var(--aw-auf-farbe);
  transition: opacity .3s ease, filter .3s ease;
}
.aw-b-ui { background: var(--aw-ui); }
.aw-b-zeit { background: var(--aw-zeit); }

.aw .aw-frei-text {
  position: absolute; left: 80px; top: 11px;
  font-size: 13px; font-weight: 700; color: var(--aw-frei);
  transition: opacity .3s ease, filter .3s ease;
}
.aw .aw-klein {
  position: absolute; bottom: 8px; height: 16px; width: 18px;
  left: calc(80px + var(--i) * 26px);
  background: var(--aw-frei);
  border-radius: 3px;
  transition: opacity .3s ease, filter .3s ease;
}

/* Pfeile zwischen den Spuren */
.aw-pfeile { position: absolute; left: 534px; top: 176px; width: 422px; height: 90px; overflow: visible; }
.aw-linie { fill: none; stroke: var(--aw-zeit); stroke-width: 2.5; transition: opacity .3s ease, filter .3s ease; }
.aw-spitze { fill: var(--aw-zeit); }

/* ---------- Hinweise ---------- */
.aw .aw-hinweis {
  position: absolute; left: 534px; width: 422px; height: 56px;
  padding-inline: 14px;
  display: flex; align-items: center;
  border-left: 5px solid var(--h);
  border-radius: 6px;
  background: color-mix(in srgb, var(--h) 11%, var(--aw-bg));
  font-size: 15px; font-weight: 700;
  transition: opacity .3s ease, filter .3s ease;
}
.aw-h-frei { --h: var(--aw-frei); top: 386px; }
.aw-h-fort { --h: var(--aw-ui); top: 456px; }

/* ---------- Schritte (Klicks) ---------- */
/* Kumulativ: Was noch nicht dran ist, bleibt grau; ohne Schritt-Angabe ("alle") ist alles sichtbar */
.aw[data-schritt="0"] [data-e],
.aw[data-schritt="1"] [data-e="2"],
.aw[data-schritt="1"] [data-e="3"],
.aw[data-schritt="1"] [data-e="4"],
.aw[data-schritt="2"] [data-e="3"],
.aw[data-schritt="2"] [data-e="4"],
.aw[data-schritt="3"] [data-e="4"] { opacity: 0.18; filter: grayscale(1); }

/* Aktuelle Codezeile */
.aw[data-schritt="1"] .aw-z[data-z="3"],
.aw[data-schritt="2"] .aw-z[data-z="4"],
.aw[data-schritt="3"] .aw-z[data-z="4"],
.aw[data-schritt="4"] .aw-z[data-z="5"],
.aw[data-schritt="alle"] .aw-z[data-z="5"] {
  background: color-mix(in srgb, var(--aw-ui) 18%, var(--aw-bg));
}

/* Inhalt des Labels je Schritt */
.aw[data-schritt="0"] .aw-label .aw-l0,
.aw[data-schritt="1"] .aw-label .aw-l1,
.aw[data-schritt="2"] .aw-label .aw-l1,
.aw[data-schritt="3"] .aw-label .aw-l1 { display: block; }
.aw[data-schritt="0"] .aw-label .aw-l2,
.aw[data-schritt="1"] .aw-label .aw-l2,
.aw[data-schritt="2"] .aw-label .aw-l2,
.aw[data-schritt="3"] .aw-label .aw-l2 { display: none; }

@media (prefers-reduced-motion: reduce) {
  .aw.aw .aw-z, .aw .aw-fort, .aw .aw-balken, .aw .aw-frei-text, .aw .aw-klein,
  .aw-linie, .aw .aw-hinweis { transition: none; }
}
</style>
