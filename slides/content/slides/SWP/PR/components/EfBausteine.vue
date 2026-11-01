<!--
  EfBausteine.vue – „EF Core: die Bausteine“: Entity, DbContext, DbSet, Provider, Migration
  Ablage: components/EfBausteine.vue (Slidev registriert die Komponente automatisch)

  Verwendung (Schritt für Schritt, 5 Klicks):
    ---
    layout: full
    clicks: 5
    ---
    <EfBausteine :schritt="$clicks" />

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
  titel: 'EF Core: die Bausteine',
})

// 0 = Bild grau, dann nacheinander Entity, DbContext, DbSet, Provider, Migration
const stufe = computed(() =>
  typeof props.schritt === 'number'
    ? String(Math.min(Math.max(props.schritt, 0), 5))
    : 'alle'
)
</script>

<template>
<div class="efb" :data-schritt="stufe">
  <div class="efb-titel">{{ titel }}</div>

  <div class="efb-bild">
    <div class="efb-box efb-c-ent" data-s="1" style="grid-area: ent">
      <b>Entities</b>
      <span>C#-Klassen, je eine pro Tabelle</span>
      <div class="efb-liste">
        <code>class Kunde</code>
        <code>class Artikel</code>
        <code>class Bestellung</code>
        <code>class Bestellposition</code>
      </div>
    </div>

    <div class="efb-verb efb-linie" data-s="2" style="grid-area: v1"></div>

    <div class="efb-box efb-c-ctx" data-s="2" style="grid-area: ctx">
      <b>DbContext</b>
      <code class="efb-name">ShopContext</code>
      <div class="efb-sets efb-c-set" data-s="3">
        <span class="efb-sets-kopf">DbSet&lt;T&gt; je Tabelle</span>
        <code>Kunden</code>
        <code>Artikel</code>
        <code>Bestellungen</code>
        <code>Bestellpositionen</code>
      </div>
    </div>

    <div class="efb-verb efb-pfeil" data-s="4" style="grid-area: v2"></div>

    <div class="efb-box efb-c-prov" data-s="4" style="grid-area: prov">
      <b>Provider</b>
      <code>UseSqlServer(…)</code>
      <span>übersetzt in T-SQL, nutzt Microsoft.Data.SqlClient</span>
    </div>

    <div class="efb-verb efb-pfeil" data-s="4" style="grid-area: v3"></div>

    <div class="efb-db" style="grid-area: db">
      <svg class="efb-zylinder" viewBox="0 0 160 200" preserveAspectRatio="none" aria-hidden="true">
        <path class="efb-zyl-koerper" d="M2 22 V178 A78 20 0 0 0 158 178 V22" />
        <ellipse class="efb-zyl-deckel" cx="80" cy="22" rx="78" ry="20" />
      </svg>
      <div class="efb-db-text">
        <b>SQL Server</b>
        <span>OnlineShopEf</span>
      </div>
    </div>

    <div class="efb-ecke" data-s="5" style="grid-area: m1">
      <span class="efb-ecke-text">migrations add</span>
      <span class="efb-spitze"></span>
    </div>

    <div class="efb-box efb-c-mig efb-mig" data-s="5" style="grid-area: mig">
      <b>Migrations</b>
      <span>Entities geändert → neue Migration → Tabellen angepasst</span>
      <code>dotnet ef database update</code>
    </div>

    <div class="efb-verb efb-pfeil efb-gestrichelt" data-s="5" style="grid-area: v4"></div>
  </div>

  <div class="efb-karten">
    <div class="efb-karte efb-c-ent" data-k="1">
      <b>Entity</b>
      <p>Klasse, die einer Tabelle entspricht</p>
      <span>aus ADO.NET: <code>Artikel</code>-Klasse</span>
    </div>
    <div class="efb-karte efb-c-ctx" data-k="2">
      <b>DbContext</b>
      <p>Sitzung mit der Datenbank, verwaltet die Entities</p>
      <span>aus ADO.NET: Connection + Repository</span>
    </div>
    <div class="efb-karte efb-c-set" data-k="3">
      <b>DbSet&lt;T&gt;</b>
      <p>Zugriff auf eine Tabelle</p>
      <span>aus ADO.NET: <code>FROM Artikel</code></span>
    </div>
    <div class="efb-karte efb-c-prov" data-k="4">
      <b>Provider</b>
      <p>übersetzt für eine bestimmte Datenbank</p>
      <span>aus ADO.NET: <code>Microsoft.<wbr>Data.<wbr>SqlClient</code></span>
    </div>
    <div class="efb-karte efb-c-mig" data-k="5">
      <b>Migration</b>
      <p>versionierte Schemaänderung, erzeugt aus den Entities</p>
      <span>aus ADO.NET: <code>setup.sql</code></span>
    </div>
  </div>
</div>
</template>

<style>
/* EF Core: die Bausteine – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.efb {
  --efb-bg: #ffffff;
  --efb-fg: #16212c;
  --efb-muted: #5a6876;
  --efb-ent: #0f7d87;    /* Entity */
  --efb-ctx: #17835a;    /* DbContext (Grün wie EF Core im Schichtenmodell) */
  --efb-set: #7446c2;    /* DbSet */
  --efb-prov: #4b5d70;   /* Provider */
  --efb-mig: #a0457a;    /* Migration */
  --efb-db: #7a5b3c;
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  padding: 18px 24px;
  display: flex;
  flex-direction: column;
  gap: 14px;
  background: var(--efb-bg);
  color: var(--efb-fg);
  font-size: 14px;
  line-height: 1.3;
  text-align: left;
}
.dark .efb, .efb.dark {
  --efb-bg: #121a21;
  --efb-fg: #e6edf3;
  --efb-muted: #9aabba;
  --efb-ent: #45c3cc;
  --efb-ctx: #4fc58f;
  --efb-set: #b08cf0;
  --efb-prov: #93a7bb;
  --efb-mig: #e88bbf;
  --efb-db: #c9a27c;
}
.efb *, .efb *::before, .efb *::after { box-sizing: border-box; }

/* Text-Resets gegen Theme-Stile von Slidev */
.efb .efb-titel, .efb b, .efb span, .efb p, .efb code { margin: 0; line-height: 1.25; }
.efb b { display: block; font-weight: 700; }
.efb code {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  background: none; padding: 0; border: 0; border-radius: 0;
}
.efb .efb-titel { font-size: 28px; font-weight: 800; letter-spacing: -0.01em; }

.efb-c-ent { --h: var(--efb-ent); }
.efb-c-ctx { --h: var(--efb-ctx); }
.efb-c-set { --h: var(--efb-set); }
.efb-c-prov { --h: var(--efb-prov); }
.efb-c-mig { --h: var(--efb-mig); }

/* ---------- Bild ---------- */
.efb-bild {
  flex: 1;
  min-height: 0;
  display: grid;
  grid-template-columns: 212px 26px 222px 36px minmax(0, 1fr) 36px 132px;
  grid-template-rows: minmax(0, 1fr) auto;
  grid-template-areas:
    "ent v1 ctx v2 prov v3 db"
    "m1  m1 mig mig mig v4 db";
  row-gap: 14px;
  align-items: center;
}
/* Entities unten bündig, damit die Verbindung zu den Migrations sauber ansetzt */
.efb-bild > [style*="grid-area: ent"] { align-self: end; }
.efb-box {
  border-radius: 11px;
  border: 1.5px solid color-mix(in srgb, var(--h) 65%, var(--efb-bg));
  background: color-mix(in srgb, var(--h) 10%, var(--efb-bg));
  padding: 11px 13px;
  display: flex; flex-direction: column; gap: 4px;
  transition: opacity .3s ease, filter .3s ease;
}
.efb .efb-box > b { font-size: 16px; color: var(--h); }
.efb .efb-box > span { display: block; font-size: 12px; color: var(--efb-muted); }
.efb .efb-box > code { display: block; font-size: 12px; }
.efb-liste { display: flex; flex-direction: column; gap: 3px; margin-top: 4px; }
.efb .efb-liste code {
  display: block; font-size: 12px;
  padding: 3px 8px; border-radius: 5px;
  background: var(--efb-bg); border: 1px solid color-mix(in srgb, var(--h) 40%, var(--efb-bg));
}
.efb .efb-name { font-weight: 700; }
.efb-sets {
  margin-top: 6px;
  border-radius: 8px;
  border: 1.5px solid color-mix(in srgb, var(--h) 65%, var(--efb-bg));
  background: color-mix(in srgb, var(--h) 9%, var(--efb-bg));
  padding: 7px 9px;
  display: flex; flex-direction: column; gap: 2px;
  transition: opacity .3s ease, filter .3s ease;
}
.efb .efb-sets-kopf { display: block; font-size: 11px; font-weight: 700; color: var(--h); margin-bottom: 2px; }
.efb .efb-sets code { display: block; font-size: 12px; }
.efb-mig { flex-direction: row; align-items: baseline; gap: 12px; flex-wrap: wrap; }
.efb .efb-mig code { color: var(--efb-muted); margin-left: auto; }

/* Verbindungen */
.efb-verb { position: relative; height: 2.5px; align-self: center; margin-inline: 3px; transition: opacity .3s ease; }
.efb-linie { background: var(--efb-muted); }
.efb-pfeil { background: var(--efb-muted); margin-right: 8px; }
.efb-pfeil::after {
  content: ""; position: absolute; right: -9px; top: 50%; transform: translateY(-50%);
  border: 6px solid transparent; border-left: 10px solid var(--efb-muted); border-right: 0;
}
.efb-gestrichelt { background: repeating-linear-gradient(to right, var(--efb-mig) 0 6px, transparent 6px 10px); }
.efb-gestrichelt::after { border-left-color: var(--efb-mig); }

/* Ecke Entities → Migrations: senkrecht von der Mitte der Entities nach unten, dann nach rechts */
.efb-ecke { position: relative; align-self: stretch; transition: opacity .3s ease, filter .3s ease; }
.efb-ecke::before {
  content: ""; position: absolute; left: 106px; top: -14px; height: calc(50% + 14px);
  border-left: 2.5px dashed var(--efb-mig);
}
.efb-ecke::after {
  content: ""; position: absolute; left: 106px; right: 9px; top: 50%;
  border-top: 2.5px dashed var(--efb-mig); transform: translateY(-1px);
}
.efb .efb-ecke-text {
  position: absolute; left: 118px; bottom: calc(50% + 5px);
  font-size: 10.5px; font-weight: 700; color: var(--efb-mig);
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace; white-space: nowrap;
}
.efb-spitze {
  position: absolute; right: 0; top: 50%; transform: translateY(-50%);
  border: 6px solid transparent; border-left: 10px solid var(--efb-mig); border-right: 0;
}

/* Datenbank */
.efb-db { position: relative; align-self: stretch; display: flex; align-items: center; justify-content: center; text-align: center; min-height: 0; }
.efb-zylinder { position: absolute; inset: 0; width: 100%; height: 100%; overflow: visible; }
.efb-zyl-koerper { fill: color-mix(in srgb, var(--efb-db) 12%, var(--efb-bg)); stroke: color-mix(in srgb, var(--efb-db) 70%, var(--efb-bg)); stroke-width: 1.5; vector-effect: non-scaling-stroke; }
.efb-zyl-deckel { fill: color-mix(in srgb, var(--efb-db) 22%, var(--efb-bg)); stroke: color-mix(in srgb, var(--efb-db) 70%, var(--efb-bg)); stroke-width: 1.5; vector-effect: non-scaling-stroke; }
.efb-db-text { position: relative; padding-top: 26px; }
.efb .efb-db-text b { font-size: 16px; }
.efb .efb-db-text span { display: block; font-size: 12.5px; color: var(--efb-muted); font-family: ui-monospace, "JetBrains Mono", Consolas, monospace; margin-top: 3px; }

/* ---------- Erklärkarten ---------- */
.efb-karten { display: grid; grid-template-columns: repeat(5, minmax(0, 1fr)); gap: 10px; }
.efb-karte {
  border-radius: 10px;
  border: 1.5px solid color-mix(in srgb, var(--h) 55%, var(--efb-bg));
  background: color-mix(in srgb, var(--h) 9%, var(--efb-bg));
  padding: 9px 11px;
  display: flex; flex-direction: column; gap: 4px;
  opacity: 0; transform: translateY(8px);
  transition: opacity .35s ease, transform .35s ease;
}
.efb .efb-karte b { font-size: 15px; color: var(--h); }
.efb .efb-karte p { font-size: 12.5px; }
.efb .efb-karte span { display: block; font-size: 11.5px; color: var(--efb-muted); margin-top: auto; padding-top: 4px; border-top: 1px solid color-mix(in srgb, var(--h) 25%, var(--efb-bg)); }
.efb .efb-karte code { font-size: 11px; color: var(--efb-fg); overflow-wrap: normal; word-break: normal; }

/* ---------- Schritte (Klicks) ---------- */
/* Karten bis zum aktuellen Schritt einblenden; ohne Schritt-Angabe ("alle") sind alle sichtbar */
.efb[data-schritt="alle"] .efb-karte,
.efb[data-schritt="1"] .efb-karte[data-k="1"],
.efb[data-schritt="2"] .efb-karte[data-k="1"],
.efb[data-schritt="2"] .efb-karte[data-k="2"],
.efb[data-schritt="3"] .efb-karte[data-k="1"],
.efb[data-schritt="3"] .efb-karte[data-k="2"],
.efb[data-schritt="3"] .efb-karte[data-k="3"],
.efb[data-schritt="4"] .efb-karte[data-k="1"],
.efb[data-schritt="4"] .efb-karte[data-k="2"],
.efb[data-schritt="4"] .efb-karte[data-k="3"],
.efb[data-schritt="4"] .efb-karte[data-k="4"],
.efb[data-schritt="5"] .efb-karte[data-k="1"],
.efb[data-schritt="5"] .efb-karte[data-k="2"],
.efb[data-schritt="5"] .efb-karte[data-k="3"],
.efb[data-schritt="5"] .efb-karte[data-k="4"],
.efb[data-schritt="5"] .efb-karte[data-k="5"] { opacity: 1; transform: none; }

/* Im Bild: was noch nicht dran war, bleibt grau */
.efb[data-schritt="0"] [data-s="1"],
.efb[data-schritt="0"] [data-s="2"],
.efb[data-schritt="0"] [data-s="3"],
.efb[data-schritt="0"] [data-s="4"],
.efb[data-schritt="0"] [data-s="5"],
.efb[data-schritt="1"] [data-s="2"],
.efb[data-schritt="1"] [data-s="3"],
.efb[data-schritt="1"] [data-s="4"],
.efb[data-schritt="1"] [data-s="5"],
.efb[data-schritt="2"] [data-s="3"],
.efb[data-schritt="2"] [data-s="4"],
.efb[data-schritt="2"] [data-s="5"],
.efb[data-schritt="3"] [data-s="4"],
.efb[data-schritt="3"] [data-s="5"],
.efb[data-schritt="4"] [data-s="5"] { opacity: 0.18; filter: grayscale(1); }

@media (prefers-reduced-motion: reduce) {
  .efb-karte, .efb-box, .efb-sets, .efb-verb { transition: none; }
}
</style>