<!--
  ThreadZeitachse.vue – Warum das Fenster einfriert, solange der UI-Thread wartet
  Ablage: components/ThreadZeitachse.vue (Slidev registriert die Komponente automatisch)

  Verwendung (Schritt für Schritt, 3 Klicks):
    ---
    layout: none
    clicks: 3
    ---
    <ThreadZeitachse :schritt="$clicks" />

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
  titel: 'Was während der 5 Sekunden passiert',
})

// 0 = UI-Thread frei, 1 = Klick und Warten, 2 = Ereignisse stauen sich, 3 = wieder frei
const stufe = computed(() =>
  typeof props.schritt === 'number'
    ? String(Math.min(Math.max(props.schritt, 0), 3))
    : 'alle'
)

const sekunden = [0, 1, 2, 3, 4, 5, 6, 7, 8]
</script>

<template>
<div class="thz" :data-schritt="stufe">
  <div class="thz-titel">{{ titel }}</div>

  <div class="thz-achse">
    <span
      v-for="s in sekunden"
      :key="s"
      class="thz-tick"
      :style="{ '--s': s }"
    >{{ s }} s</span>
  </div>

  <b class="thz-spurname">UI-Thread</b>
  <div class="thz-spur">
    <span class="thz-balken thz-b-frei" style="--von: 0; --bis: 1">frei</span>
    <span class="thz-balken thz-b-ui" style="--von: 1; --bis: 1.6" data-e="1">Klick</span>
    <span class="thz-balken thz-b-rot" style="--von: 1.6; --bis: 6.6" data-e="1"><code>Thread.Sleep(5000)</code></span>
    <span class="thz-balken thz-b-frei" style="--von: 6.6; --bis: 8" data-e="3">wieder frei</span>
  </div>

  <div class="thz-box thz-box-stau" data-e="2">
    <b class="thz-box-kopf">Warteschlange</b>
    <span class="thz-box-text">Der UI-Thread schläft, darum bleibt alles liegen:</span>
    <div class="thz-karten">
      <span class="thz-karte">Klick</span>
      <span class="thz-karte">Neu zeichnen</span>
      <span class="thz-karte">Fenster verschieben</span>
      <span class="thz-karte">Klick</span>
      <span class="thz-karte">Neu zeichnen</span>
    </div>
  </div>

  <div class="thz-box thz-box-frei" data-e="3">
    <b class="thz-box-kopf">Nach 5 Sekunden</b>
    <span class="thz-box-text">Das Label zeigt „Fertig“, dann arbeitet der UI-Thread die Warteschlange ab.</span>
  </div>

  <!-- Stilisiertes WinForms-Fenster -->
  <div class="thz-fenster">
    <div class="thz-fenster-titel">
      <span class="thz-t-normal">OnlineShop</span>
      <span class="thz-t-haengt">OnlineShop (Keine Rückmeldung)</span>
    </div>
    <div class="thz-fenster-inhalt">
      <span class="thz-button">Artikel laden</span>
      <div class="thz-liste">
        <span></span><span></span><span></span><span></span><span></span>
      </div>
      <span class="thz-label">
        <b class="thz-l-alt">Status</b>
        <b class="thz-l-neu">Fertig</b>
      </span>
    </div>
  </div>

  <div class="thz-fuss" data-e="3">Solange der UI-Thread wartet, reagiert das Fenster nicht.</div>
</div>
</template>

<style>
/* ThreadZeitachse – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.thz {
  --thz-bg: #ffffff;
  --thz-fg: #16212c;
  --thz-muted: #5a6876;
  --thz-line: #d4dce3;
  --thz-ui: #2c64c4;
  --thz-frei: #17835a;
  --thz-rot: #b83a3a;
  --thz-auf-farbe: #ffffff;
  --thz-pro-s: 63px;       /* Breite einer Sekunde auf der Zeitachse */
  box-sizing: border-box;
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: var(--thz-bg);
  color: var(--thz-fg);
  font-size: 13px;
  line-height: 1.25;
  text-align: left;
}
.dark .thz, .thz.dark {
  --thz-bg: #121a21;
  --thz-fg: #e6edf3;
  --thz-muted: #9aabba;
  --thz-line: #2e3b48;
  --thz-ui: #6fa1f2;
  --thz-frei: #4fc58f;
  --thz-rot: #f07a7a;
  --thz-auf-farbe: #121a21;
}
.thz *, .thz *::before, .thz *::after { box-sizing: border-box; }

/* Text-Resets gegen Theme-Stile von Slidev */
.thz.thz b, .thz.thz span, .thz.thz code { margin: 0; line-height: 1.25; }
.thz.thz code {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  background: none; padding: 0; border: 0; border-radius: 0;
}

.thz .thz-titel { position: absolute; left: 24px; top: 14px; font-size: 28px; font-weight: 800; letter-spacing: -0.01em; }

/* ---------- Zeitachse ---------- */
.thz-achse { position: absolute; left: 124px; top: 66px; width: 504px; height: 22px; border-bottom: 1.5px solid var(--thz-muted); }
.thz .thz-tick {
  position: absolute; left: calc(var(--s) * var(--thz-pro-s)); top: 0;
  transform: translateX(-50%);
  font-size: 12px; color: var(--thz-muted); white-space: nowrap;
}

/* ---------- Spur ---------- */
.thz .thz-spurname {
  position: absolute; left: 24px; top: 94px; width: 96px; height: 60px;
  display: flex; align-items: center;
  font-size: 15px; font-weight: 800; color: var(--thz-ui);
}
.thz-spur {
  position: absolute; left: 124px; top: 94px; width: 504px; height: 60px;
  background: color-mix(in srgb, var(--thz-muted) 8%, var(--thz-bg));
  border-radius: 6px;
}
.thz .thz-balken {
  position: absolute; top: 0; bottom: 0;
  left: calc(var(--von) * var(--thz-pro-s));
  width: calc((var(--bis) - var(--von)) * var(--thz-pro-s));
  display: flex; align-items: center; justify-content: center;
  border-radius: 6px;
  font-size: 13px; font-weight: 700;
  color: var(--thz-auf-farbe);
  transition: opacity .3s ease, filter .3s ease;
}
.thz .thz-balken code { font-size: 14px; font-weight: 700; color: var(--thz-auf-farbe); }
.thz-b-ui { background: var(--thz-ui); }
.thz-b-rot { background: var(--thz-rot); }
.thz-b-frei { background: var(--thz-frei); }

/* ---------- Erklärkästen ---------- */
.thz-box {
  position: absolute; left: 24px; width: 604px;
  padding: 12px 14px;
  border: 1.5px solid var(--h);
  border-radius: 10px;
  background: color-mix(in srgb, var(--h) 8%, var(--thz-bg));
  transition: opacity .3s ease, filter .3s ease;
}
.thz-box-stau { --h: var(--thz-rot); top: 172px; height: 134px; }
.thz-box-frei { --h: var(--thz-frei); top: 320px; height: 92px; }
.thz .thz-box-kopf { display: block; font-size: 16px; font-weight: 800; color: var(--h); }
.thz .thz-box-text { display: block; margin-top: 4px; font-size: 15px; }
.thz-karten { margin-top: 12px; display: flex; gap: 8px; }
.thz .thz-karte {
  flex: 0 0 auto;
  padding: 5px 9px;
  border: 1.5px solid var(--thz-rot);
  border-radius: 6px;
  background: var(--thz-bg);
  font-size: 13px; white-space: nowrap;
}

/* ---------- WinForms-Fenster ---------- */
.thz-fenster {
  position: absolute; left: 660px; top: 66px; width: 296px; height: 346px;
  border: 1.5px solid var(--thz-muted);
  border-radius: 8px;
  overflow: hidden;
  background: var(--thz-bg);
  transition: opacity .3s ease;
}
.thz-fenster-titel {
  height: 32px; padding-inline: 12px;
  display: flex; align-items: center;
  background: var(--thz-ui);
  transition: background .3s ease;
}
.thz .thz-fenster-titel span { font-size: 13px; font-weight: 700; color: var(--thz-auf-farbe); white-space: nowrap; }
.thz .thz-t-haengt { display: none; }
.thz-fenster-inhalt { position: relative; height: 312px; }
.thz .thz-button {
  position: absolute; left: 16px; top: 16px; padding: 7px 14px;
  border: 1.5px solid var(--thz-muted);
  border-radius: 5px;
  background: color-mix(in srgb, var(--thz-muted) 12%, var(--thz-bg));
  font-size: 13px;
}
.thz-liste {
  position: absolute; left: 16px; right: 16px; top: 66px; height: 170px;
  padding: 10px;
  display: flex; flex-direction: column; gap: 12px;
  border: 1.5px solid var(--thz-line);
  border-radius: 5px;
}
.thz .thz-liste span { display: block; height: 12px; border-radius: 3px; background: color-mix(in srgb, var(--thz-muted) 16%, var(--thz-bg)); }
.thz .thz-liste span:nth-child(even) { width: 70%; }
.thz .thz-label {
  position: absolute; left: 16px; right: 16px; top: 256px; height: 40px;
  padding-inline: 10px;
  display: flex; align-items: center;
}
.thz .thz-label b { font-size: 18px; font-weight: 700; }
.thz .thz-l-alt { display: none; }
.thz.thz .thz-l-neu { color: var(--thz-frei); }

/* ---------- Fußzeile ---------- */
.thz .thz-fuss {
  position: absolute; left: 24px; right: 24px; top: 430px; height: 60px;
  display: flex; align-items: center; justify-content: center;
  border-left: 5px solid var(--thz-ui);
  border-radius: 6px;
  background: color-mix(in srgb, var(--thz-ui) 10%, var(--thz-bg));
  font-size: 20px; font-weight: 700;
  transition: opacity .3s ease, filter .3s ease;
}

/* ---------- Schritte (Klicks) ---------- */
/* Kumulativ: Was noch nicht dran ist, bleibt grau; ohne Schritt-Angabe ("alle") ist alles sichtbar */
.thz[data-schritt="0"] [data-e],
.thz[data-schritt="1"] [data-e="2"],
.thz[data-schritt="1"] [data-e="3"],
.thz[data-schritt="2"] [data-e="3"] { opacity: 0.18; filter: grayscale(1); }

/* Während des Wartens reagiert das Fenster nicht */
.thz[data-schritt="1"] .thz-fenster,
.thz[data-schritt="2"] .thz-fenster { opacity: 0.5; }
.thz[data-schritt="1"] .thz-fenster-titel,
.thz[data-schritt="2"] .thz-fenster-titel { background: var(--thz-muted); }
.thz[data-schritt="1"] .thz-t-normal,
.thz[data-schritt="2"] .thz-t-normal { display: none; }
.thz[data-schritt="1"] .thz-t-haengt,
.thz[data-schritt="2"] .thz-t-haengt { display: inline; }

/* Erst am Ende steht „Fertig“ im Label */
.thz[data-schritt="0"] .thz-l-alt,
.thz[data-schritt="1"] .thz-l-alt,
.thz[data-schritt="2"] .thz-l-alt { display: inline; }
.thz[data-schritt="0"] .thz-l-neu,
.thz[data-schritt="1"] .thz-l-neu,
.thz[data-schritt="2"] .thz-l-neu { display: none; }

@media (prefers-reduced-motion: reduce) {
  .thz .thz-balken, .thz-box, .thz-fenster, .thz-fenster-titel, .thz .thz-fuss { transition: none; }
}
</style>
