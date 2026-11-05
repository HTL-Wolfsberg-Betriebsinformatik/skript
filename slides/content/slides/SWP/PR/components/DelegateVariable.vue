<!--
  DelegateVariable.vue – Eine Variable, die eine Methode enthält
  Ablage: components/DelegateVariable.vue (Slidev registriert die Komponente automatisch)

  Verwendung (Schritt für Schritt, 5 Klicks):
    ---
    layout: none
    clicks: 5
    ---
    <DelegateVariable :schritt="$clicks" />

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
  titel: 'Eine Variable für eine Methode',
})

// 0 = Ausgangslage, 1 = int-Variable, 2 = Methode speichern, 3 = aufrufen,
// 4 = andere Methode speichern, 5 = wieder aufrufen
const stufe = computed(() =>
  typeof props.schritt === 'number'
    ? String(Math.min(Math.max(props.schritt, 0), 5))
    : 'alle'
)
</script>

<template>
<div class="dv" :data-schritt="stufe">
  <div class="dv-titel">{{ titel }}</div>

  <!-- Code, Zeile für Zeile -->
  <div class="dv-code">
    <code class="dv-z" data-z="1" data-e="1">int zahl = 5;</code>
    <code class="dv-z" data-z="2" data-e="2">Func&lt;decimal, decimal&gt; rabatt = ZehnProzent;</code>
    <code class="dv-z" data-z="3" data-e="3">decimal a = rabatt(100m);<i>// 90,0</i></code>
    <code class="dv-z" data-z="4" data-e="4">rabatt = FuenfEuro;</code>
    <code class="dv-z" data-z="5" data-e="5">decimal b = rabatt(100m);<i>// 95</i></code>
  </div>

  <!-- Erklärung zum aktuellen Schritt -->
  <div class="dv-text">
    <span data-t="0">Bisher kennt ihr Variablen, die einen <b>Wert</b> enthalten.</span>
    <span data-t="1"><code>zahl</code> enthält den Wert 5. Der Typ <code>int</code> sagt, was hineinpasst: ganze Zahlen.</span>
    <span data-t="2"><code>rabatt</code> enthält eine <b>Methode</b>. Der Typ sagt, was hineinpasst: Methoden, die ein <code>decimal</code> bekommen und ein <code>decimal</code> liefern. Ausgeführt wird noch nichts.</span>
    <span data-t="3">Erst die <b>Klammern</b> rufen die Methode auf, die gerade in <code>rabatt</code> steckt.</span>
    <span data-t="4">Wie jede Variable bekommt <code>rabatt</code> einen neuen Inhalt: jetzt eine andere Methode.</span>
    <span data-t="5"><b>Gleicher Aufruf, andere Methode, anderes Ergebnis.</b></span>
  </div>

  <!-- Variablen -->
  <div class="dv-var dv-var-zahl" data-e="1">
    <span class="dv-typ">int</span>
    <b class="dv-name">zahl</b>
    <span class="dv-inhalt dv-inhalt-wert">5</span>
  </div>

  <div class="dv-var dv-var-rabatt" data-e="2">
    <span class="dv-typ">Func&lt;decimal, decimal&gt;</span>
    <b class="dv-name">rabatt</b>
    <span class="dv-inhalt dv-inhalt-m">
      <span class="dv-m1">ZehnProzent</span>
      <span class="dv-m2">FuenfEuro</span>
    </span>
  </div>

  <svg class="dv-pfeile" viewBox="0 0 980 552" aria-hidden="true">
    <defs>
      <marker id="dv-spitze" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto">
        <path d="M0,0 L10,5 L0,10 z" class="dv-spitze" />
      </marker>
    </defs>
    <path class="dv-linie dv-p1" data-e="2" d="M752 284 C778 284 770 160 798 160" marker-end="url(#dv-spitze)" />
    <path class="dv-linie dv-p2" data-e="4" d="M752 284 C778 284 770 368 798 368" marker-end="url(#dv-spitze)" />
  </svg>

  <!-- Methoden im Programm -->
  <div class="dv-methode dv-k1">
    <span class="dv-kicker">Methode</span>
    <code class="dv-m-name">ZehnProzent</code>
    <code class="dv-m-code">preis * 0.9m</code>
    <span class="dv-ergebnis" data-e="3">100 → <b>90,0</b></span>
  </div>
  <div class="dv-methode dv-k2">
    <span class="dv-kicker">Methode</span>
    <code class="dv-m-name">FuenfEuro</code>
    <code class="dv-m-code">preis - 5m</code>
    <span class="dv-ergebnis" data-e="5">100 → <b>95</b></span>
  </div>

  <div class="dv-fuss" data-e="5">
    <span><code>Func&lt;…&gt;</code> ist ein <b>Delegate</b>: ein Typ für Variablen, die eine Methode enthalten.</span>
  </div>
</div>
</template>

<style>
/* DelegateVariable – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.dv {
  --dv-bg: #ffffff;
  --dv-fg: #16212c;
  --dv-muted: #5a6876;
  --dv-line: #d4dce3;
  --dv-var: #2c64c4;
  --dv-methode: #17835a;
  --dv-pfeil: #c8620e;
  box-sizing: border-box;
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: var(--dv-bg);
  color: var(--dv-fg);
  font-size: 14px;
  line-height: 1.25;
  text-align: left;
}
.dark .dv, .dv.dark {
  --dv-bg: #121a21;
  --dv-fg: #e6edf3;
  --dv-muted: #9aabba;
  --dv-line: #2e3b48;
  --dv-var: #6fa1f2;
  --dv-methode: #4fc58f;
  --dv-pfeil: #f0a04b;
}
.dv *, .dv *::before, .dv *::after { box-sizing: border-box; }

/* Text-Resets gegen Theme-Stile von Slidev */
.dv.dv b, .dv.dv span, .dv.dv code { margin: 0; line-height: 1.25; }
.dv.dv code {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  background: none; padding: 0; border: 0; border-radius: 0;
}

.dv .dv-titel { position: absolute; left: 24px; top: 14px; font-size: 28px; font-weight: 800; letter-spacing: -0.01em; }

/* ---------- Code ---------- */
.dv-code {
  position: absolute; left: 24px; top: 66px; width: 476px; height: 190px;
  padding: 10px;
  display: flex; flex-direction: column; justify-content: space-between;
  border: 1.5px solid var(--dv-line);
  border-radius: 10px;
  background: color-mix(in srgb, var(--dv-muted) 6%, var(--dv-bg));
}
.dv.dv .dv-z {
  display: flex; justify-content: space-between;
  padding: 6px 8px;
  border-radius: 5px;
  font-size: 14.5px;
  white-space: pre;
  transition: background .25s ease, opacity .3s ease, filter .3s ease;
}
.dv .dv-z i { font-style: normal; color: var(--dv-muted); }

/* ---------- Erklärung ---------- */
.dv-text {
  position: absolute; left: 24px; top: 272px; width: 476px; height: 190px;
  padding: 14px 16px;
  display: flex; align-items: center;
  border-left: 5px solid var(--dv-var);
  border-radius: 6px;
  background: color-mix(in srgb, var(--dv-var) 9%, var(--dv-bg));
}
.dv .dv-text > span { display: none; font-size: 19px; line-height: 1.35; }
.dv.dv .dv-text code { font-size: 17px; font-weight: 700; }
.dv.dv .dv-text b { font-weight: 800; }

/* ---------- Variablen ---------- */
.dv-var {
  position: absolute; left: 530px; width: 222px;
  padding: 10px 12px;
  border: 2px solid var(--dv-var);
  border-radius: 10px;
  background: color-mix(in srgb, var(--dv-var) 7%, var(--dv-bg));
  transition: opacity .3s ease, filter .3s ease;
}
.dv-var-zahl { top: 66px; height: 122px; }
.dv-var-rabatt { top: 214px; height: 140px; }
.dv .dv-typ {
  display: block;
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 12.5px; color: var(--dv-muted);
}
.dv .dv-name { display: block; font-size: 19px; font-weight: 800; color: var(--dv-var); }
.dv .dv-inhalt {
  display: block; margin-top: 8px; padding: 6px 8px; text-align: center;
  border: 1.5px dashed var(--dv-muted);
  border-radius: 6px;
  background: var(--dv-bg);
}
.dv .dv-inhalt-wert { font-size: 24px; font-weight: 800; }
.dv .dv-inhalt-m { padding-block: 12px; }
.dv .dv-inhalt-m span {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 16px; font-weight: 700; color: var(--dv-methode);
}
.dv .dv-m1 { display: none; }

/* ---------- Pfeile ---------- */
.dv-pfeile { position: absolute; left: 0; top: 0; width: 980px; height: 552px; pointer-events: none; }
.dv-linie { fill: none; stroke: var(--dv-pfeil); stroke-width: 2.5; transition: opacity .3s ease, filter .3s ease; }
.dv-spitze { fill: var(--dv-pfeil); }

/* ---------- Methoden ---------- */
.dv-methode {
  position: absolute; left: 800px; width: 156px; height: 188px;
  padding: 12px;
  display: flex; flex-direction: column; gap: 6px;
  border: 2px solid color-mix(in srgb, var(--dv-methode) 55%, var(--dv-bg));
  border-radius: 10px;
  background: color-mix(in srgb, var(--dv-methode) 7%, var(--dv-bg));
  transition: border-color .3s ease;
}
.dv-k1 { top: 66px; }
.dv-k2 { top: 274px; }
.dv .dv-kicker { font-size: 11px; font-weight: 700; letter-spacing: .08em; text-transform: uppercase; color: var(--dv-muted); }
.dv.dv .dv-m-name { font-size: 15px; font-weight: 700; color: var(--dv-methode); }
.dv.dv .dv-m-code { font-size: 14px; }
.dv .dv-ergebnis {
  margin-top: auto;
  font-size: 19px;
  transition: opacity .3s ease, filter .3s ease;
}
.dv .dv-ergebnis b { font-weight: 800; color: var(--dv-methode); }

/* ---------- Fußzeile ---------- */
.dv .dv-fuss {
  position: absolute; left: 24px; right: 24px; top: 476px; height: 54px;
  display: flex; align-items: center; justify-content: center;
  border-left: 5px solid var(--dv-methode);
  border-radius: 6px;
  background: color-mix(in srgb, var(--dv-methode) 10%, var(--dv-bg));
  font-size: 18px;
  transition: opacity .3s ease, filter .3s ease;
}
.dv.dv .dv-fuss code { font-size: 17px; font-weight: 700; }
.dv.dv .dv-fuss b { font-weight: 800; }

/* ---------- Schritte (Klicks) ---------- */
/* Kumulativ: Was noch nicht dran ist, bleibt grau; ohne Schritt-Angabe ("alle") ist alles sichtbar */
.dv[data-schritt="0"] [data-e],
.dv[data-schritt="1"] [data-e="2"], .dv[data-schritt="1"] [data-e="3"], .dv[data-schritt="1"] [data-e="4"], .dv[data-schritt="1"] [data-e="5"],
.dv[data-schritt="2"] [data-e="3"], .dv[data-schritt="2"] [data-e="4"], .dv[data-schritt="2"] [data-e="5"],
.dv[data-schritt="3"] [data-e="4"], .dv[data-schritt="3"] [data-e="5"],
.dv[data-schritt="4"] [data-e="5"] { opacity: 0.18; filter: grayscale(1); }

/* Aktuelle Codezeile */
.dv[data-schritt="1"] .dv-z[data-z="1"],
.dv[data-schritt="2"] .dv-z[data-z="2"],
.dv[data-schritt="3"] .dv-z[data-z="3"],
.dv[data-schritt="4"] .dv-z[data-z="4"],
.dv[data-schritt="5"] .dv-z[data-z="5"],
.dv[data-schritt="alle"] .dv-z[data-z="5"] {
  background: color-mix(in srgb, var(--dv-var) 18%, var(--dv-bg));
}

/* Erklärtext je Schritt */
.dv[data-schritt="0"] [data-t="0"],
.dv[data-schritt="1"] [data-t="1"],
.dv[data-schritt="2"] [data-t="2"],
.dv[data-schritt="3"] [data-t="3"],
.dv[data-schritt="4"] [data-t="4"],
.dv[data-schritt="5"] [data-t="5"],
.dv[data-schritt="alle"] [data-t="5"] { display: inline; }

/* Bis Schritt 3 steckt ZehnProzent in der Variable, danach FuenfEuro */
.dv[data-schritt="0"] .dv-m1,
.dv[data-schritt="1"] .dv-m1,
.dv[data-schritt="2"] .dv-m1,
.dv[data-schritt="3"] .dv-m1 { display: inline; }
.dv[data-schritt="0"] .dv-m2,
.dv[data-schritt="1"] .dv-m2,
.dv[data-schritt="2"] .dv-m2,
.dv[data-schritt="3"] .dv-m2 { display: none; }

/* Der alte Pfeil verblasst, sobald die Variable neu belegt ist */
.dv[data-schritt="4"] .dv-p1,
.dv[data-schritt="5"] .dv-p1,
.dv[data-schritt="alle"] .dv-p1 { opacity: 0.18; }

/* Die Methode, die gerade läuft */
.dv[data-schritt="3"] .dv-k1,
.dv[data-schritt="5"] .dv-k2,
.dv[data-schritt="alle"] .dv-k2 { border-color: var(--dv-methode); }

@media (prefers-reduced-motion: reduce) {
  .dv.dv .dv-z, .dv-var, .dv-linie, .dv-methode, .dv .dv-ergebnis, .dv .dv-fuss { transition: none; }
}
</style>
