<!--
  Datentransfer.vue – „Datentransfer im Überblick“: Connection, Command, DataReader
  Ablage: components/Datentransfer.vue (Slidev registriert die Komponente automatisch)

  Verwendung (Schritt für Schritt, 3 Klicks):
    ---
    layout: full
    clicks: 3
    ---
    <Datentransfer :schritt="$clicks" />

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
  titel: 'Datentransfer im Überblick',
})

// 0 = Bild grau, 1 = + Connection, 2 = + Command, 3 = + DataReader
const stufe = computed(() =>
  typeof props.schritt === 'number'
    ? String(Math.min(Math.max(props.schritt, 0), 3))
    : 'alle'
)
</script>

<template>
<div class="dt" :data-schritt="stufe">
  <div class="dt-titel">{{ titel }}</div>

  <div class="dt-bild">
    <div class="dt-app">
      <span class="dt-lbl">Anwendung</span>
      <b>Deine Anwendung</b>
      <span class="dt-klein">C# · OnlineShop</span>
    </div>

    <div class="dt-leitung" data-e="1">
      <div class="dt-leitung-kopf">
        <b>SqlConnection</b>
        <span>die Leitung zur Datenbank</span>
      </div>

      <div class="dt-spur dt-hin" data-e="2">
        <div class="dt-paket">
          <b>SqlCommand</b>
          <code>SELECT … FROM Artikel</code>
          <code>WHERE Preis &lt; 20</code>
        </div>
        <span class="dt-pfeil dt-pfeil-r"></span>
      </div>

      <div class="dt-spur dt-zurueck" data-e="3">
        <span class="dt-pfeil dt-pfeil-l"></span>
        <div class="dt-zeilen">
          <span class="dt-zeile">HDMI-Kabel · 7,50</span>
          <span class="dt-zeile">USB-Stick · 12,90</span>
        </div>
        <div class="dt-paket">
          <b>SqlDataReader</b>
          <span>Zeile für Zeile</span>
        </div>
      </div>
    </div>

    <div class="dt-db">
      <svg class="dt-zylinder" viewBox="0 0 160 200" preserveAspectRatio="none" aria-hidden="true">
        <path class="dt-zyl-koerper" d="M2 22 V178 A78 20 0 0 0 158 178 V22" />
        <ellipse class="dt-zyl-deckel" cx="80" cy="22" rx="78" ry="20" />
      </svg>
      <div class="dt-db-text">
        <b>SQL Server</b>
        <span class="dt-klein">Datenbank OnlineShop</span>
      </div>
    </div>
  </div>

  <div class="dt-karten">
    <div class="dt-karte dt-k-con" data-k="1">
      <b>Connection</b>
      <p>die Leitung zur Datenbank: öffnen, benutzen, schließen</p>
      <code>con.Open();</code>
    </div>
    <div class="dt-karte dt-k-cmd" data-k="2">
      <b>Command</b>
      <p>der Auftrag: SQL plus Parameter</p>
      <code>new SqlCommand(sql, con)</code>
    </div>
    <div class="dt-karte dt-k-rdr" data-k="3">
      <b>DataReader</b>
      <p>liest das Ergebnis, eine Zeile nach der anderen</p>
      <code>while (reader.Read())</code>
    </div>
  </div>
</div>
</template>

<style>
/* Datentransfer – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.dt {
  --dt-bg: #ffffff;
  --dt-fg: #16212c;
  --dt-muted: #5a6876;
  --dt-con: #2c64c4;     /* Connection (Blau wie ADO.NET) */
  --dt-cmd: #c8620e;     /* Command (Orange wie Schritt 1) */
  --dt-rdr: #7446c2;     /* DataReader */
  --dt-app: #34424f;
  --dt-db: #7a5b3c;
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  padding: 18px 24px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  background: var(--dt-bg);
  color: var(--dt-fg);
  font-size: 14px;
  line-height: 1.3;
  text-align: left;
}
.dark .dt, .dt.dark {
  --dt-bg: #121a21;
  --dt-fg: #e6edf3;
  --dt-muted: #9aabba;
  --dt-con: #6fa1f2;
  --dt-cmd: #f0a04b;
  --dt-rdr: #b08cf0;
  --dt-app: #b7c4d0;
  --dt-db: #c9a27c;
}
.dt *, .dt *::before, .dt *::after { box-sizing: border-box; }

/* Text-Resets gegen Theme-Stile von Slidev */
.dt .dt-titel, .dt b, .dt span, .dt p, .dt code { margin: 0; line-height: 1.25; }
.dt b { display: block; font-weight: 700; }
.dt code {
  display: block;
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  background: none; padding: 0; border: 0; border-radius: 0;
}

.dt .dt-titel { font-size: 28px; font-weight: 800; letter-spacing: -0.01em; }
.dt .dt-lbl {
  display: block; font-size: 10.5px; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase;
  color: var(--dt-muted); margin-bottom: 6px;
}
.dt .dt-klein { display: block; font-size: 12.5px; color: var(--dt-muted); margin-top: 3px; }

/* ---------- Bild: Anwendung | Leitung | Datenbank ---------- */
.dt-bild {
  flex: 1;
  min-height: 0;
  display: grid;
  grid-template-columns: 170px minmax(0, 1fr) 170px;
  align-items: stretch;
}
.dt-app {
  border: 1.5px solid color-mix(in srgb, var(--dt-app) 60%, var(--dt-bg));
  background: color-mix(in srgb, var(--dt-app) 10%, var(--dt-bg));
  border-radius: 12px;
  padding: 14px;
  display: flex; flex-direction: column; justify-content: center;
}
.dt .dt-app b { font-size: 17px; }

/* Die Leitung: oben und unten eine dicke Linie wie ein Rohr */
.dt-leitung {
  position: relative;
  margin-block: 18px;
  border-top: 4px solid var(--dt-con);
  border-bottom: 4px solid var(--dt-con);
  background: color-mix(in srgb, var(--dt-con) 6%, var(--dt-bg));
  display: grid;
  grid-template-rows: auto 1fr 1fr;
  padding: 8px 16px 10px;
  gap: 6px;
  transition: border-color .3s ease, background .3s ease;
}
.dt-leitung-kopf { display: flex; align-items: baseline; justify-content: center; gap: 10px; transition: opacity .3s ease, filter .3s ease; }
.dt .dt-leitung-kopf b { font-size: 15px; color: var(--dt-con); }
.dt .dt-leitung-kopf span { font-size: 12.5px; color: var(--dt-muted); }

.dt-spur { display: flex; align-items: center; gap: 10px; min-height: 0; transition: opacity .3s ease, filter .3s ease; }
.dt-hin { --h: var(--dt-cmd); }
.dt-zurueck { --h: var(--dt-rdr); }

.dt-paket {
  flex: 0 0 auto;
  border: 1.5px solid var(--h);
  background: color-mix(in srgb, var(--h) 12%, var(--dt-bg));
  border-radius: 9px;
  padding: 7px 11px;
  display: flex; flex-direction: column; gap: 2px;
}
.dt .dt-paket b { font-size: 14.5px; color: var(--h); }
.dt .dt-paket code { font-size: 11.5px; color: var(--dt-fg); }
.dt .dt-paket span { font-size: 12px; color: var(--dt-muted); }

/* Pfeile */
.dt-pfeil { flex: 1; height: 2.5px; margin-inline: 4px; background: var(--h); position: relative; min-width: 24px; }
.dt-pfeil-r::after, .dt-pfeil-l::before {
  content: ""; position: absolute; top: 50%; transform: translateY(-50%);
  border: 7px solid transparent;
}
.dt-pfeil-r::after { right: -4px; border-left: 11px solid var(--h); border-right: 0; }
.dt-pfeil-l::before { left: -4px; border-right: 11px solid var(--h); border-left: 0; }

/* Ergebniszeilen auf dem Rückweg */
.dt-zeilen { display: flex; flex-direction: column; gap: 4px; }
.dt .dt-zeile {
  display: block; font-size: 11.5px; white-space: nowrap;
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  padding: 3px 8px; border-radius: 5px;
  border: 1px dashed color-mix(in srgb, var(--h) 70%, var(--dt-bg));
  background: var(--dt-bg);
}

/* Datenbank als Zylinder */
.dt-db { position: relative; display: flex; align-items: center; justify-content: center; text-align: center; }
.dt-zylinder { position: absolute; inset: 0; width: 100%; height: 100%; overflow: visible; }
.dt-zyl-koerper { fill: color-mix(in srgb, var(--dt-db) 12%, var(--dt-bg)); stroke: color-mix(in srgb, var(--dt-db) 70%, var(--dt-bg)); stroke-width: 1.5; vector-effect: non-scaling-stroke; }
.dt-zyl-deckel { fill: color-mix(in srgb, var(--dt-db) 22%, var(--dt-bg)); stroke: color-mix(in srgb, var(--dt-db) 70%, var(--dt-bg)); stroke-width: 1.5; vector-effect: non-scaling-stroke; }
.dt-db-text { position: relative; padding-top: 30px; }
.dt .dt-db-text b { font-size: 17px; }

/* ---------- Erklärkarten ---------- */
.dt-karten { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 14px; }
.dt-karte {
  --h: var(--dt-con);
  border-radius: 10px;
  border: 1.5px solid color-mix(in srgb, var(--h) 55%, var(--dt-bg));
  background: color-mix(in srgb, var(--h) 9%, var(--dt-bg));
  padding: 11px 14px;
  display: flex; flex-direction: column; gap: 5px;
  opacity: 0; transform: translateY(8px);
  transition: opacity .35s ease, transform .35s ease;
}
.dt-k-con { --h: var(--dt-con); }
.dt-k-cmd { --h: var(--dt-cmd); }
.dt-k-rdr { --h: var(--dt-rdr); }
.dt .dt-karte b { font-size: 16px; color: var(--h); }
.dt .dt-karte p { font-size: 13.5px; }
.dt .dt-karte code { font-size: 12px; color: var(--dt-muted); }

/* ---------- Schritte (Klicks) ---------- */
/* Karten bis zum aktuellen Schritt einblenden; ohne Schritt-Angabe ("alle") sind alle sichtbar */
.dt[data-schritt="alle"] .dt-karte,
.dt[data-schritt="1"] .dt-karte[data-k="1"],
.dt[data-schritt="2"] .dt-karte[data-k="1"],
.dt[data-schritt="2"] .dt-karte[data-k="2"],
.dt[data-schritt="3"] .dt-karte { opacity: 1; transform: none; }

/* Im Bild wird Schritt für Schritt eingeblendet: was noch nicht dran war, bleibt grau */
.dt[data-schritt="0"] .dt-spur,
.dt[data-schritt="1"] .dt-spur,
.dt[data-schritt="2"] .dt-zurueck { opacity: 0.18; filter: grayscale(1); }
.dt[data-schritt="0"] .dt-leitung {
  border-color: color-mix(in srgb, var(--dt-muted) 30%, var(--dt-bg));
  background: color-mix(in srgb, var(--dt-muted) 4%, var(--dt-bg));
}
.dt[data-schritt="0"] .dt-leitung-kopf { opacity: 0.18; filter: grayscale(1); }

@media (prefers-reduced-motion: reduce) {
  .dt-karte, .dt-spur, .dt-leitung, .dt-leitung-kopf { transition: none; }
}
</style>