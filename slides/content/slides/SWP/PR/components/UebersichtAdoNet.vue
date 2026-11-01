<!--
  AdoNetUebersicht.vue – Übersichtsfolie „Was ist ADO.NET?“
  Ablage: components/AdoNetUebersicht.vue (Slidev registriert die Komponente automatisch)

  Verwendung:
    <AdoNetUebersicht />                         SQL Server als „im Unterricht“ markiert
    <AdoNetUebersicht markiert="keiner" />       ohne Markierung
    markiert: "sqlserver" | "oracle" | "postgres" | "mysql" | "sqlite" | "keiner"

  Ausgelegt für die Slidev-Fläche 980 × 552 → am besten mit „layout: full“.
  Dunkles Design folgt automatisch dem Slidev-Dark-Mode (html.dark).
-->
<script setup lang="ts">
withDefaults(defineProps<{
  markiert?: 'sqlserver' | 'oracle' | 'postgres' | 'mysql' | 'sqlite' | 'keiner'
  titel?: string
}>(), {
  markiert: 'sqlserver',
  titel: 'ADO.NET',
})
</script>

<template>
<div class="ado" :data-markiert="markiert">
  <div class="ado-kopf">
    <div class="ado-titel">{{ titel }}</div>
    <p class="ado-def">
      Die Klassenbibliothek von .NET für den Zugriff auf Datenbanken (<code>System.Data</code>).
      Sie legt fest, wie <b>Verbindung</b>, <b>Befehl</b> und <b>Ergebnis</b> aussehen, und zwar für jede Datenbank gleich.
      Den passenden Treiber liefert ein <b>Provider</b>.
    </p>
  </div>

  <div class="ado-raster">
    <div class="ado-lbl" style="grid-area: l1">Anwendung</div>
    <div class="ado-blk ado-h-app" style="grid-area: app">
      <b>Dein C#-Programm</b>
      <span>öffnet eine Verbindung, schickt SQL, liest das Ergebnis</span>
    </div>

    <div class="ado-lbl" style="grid-area: l2">ADO.NET</div>
    <div class="ado-blk ado-h-core" style="grid-area: core">
      <b>DbConnection · DbCommand · DbParameter · DbDataReader</b>
      <span>gemeinsame Basisklassen in System.Data.Common, jeder Provider erbt davon</span>
    </div>

    <div class="ado-lbl" style="grid-area: l3">Provider<br>(NuGet)</div>
    <div class="ado-blk ado-h-prov ado-prov" data-p="sqlserver" style="grid-area: p1">
      <i class="ado-wir">im Unterricht</i>
      <code>Microsoft.<wbr>Data.<wbr>SqlClient</code>
      <span><b>Sql</b>Connection<br><b>Sql</b>Command<br><b>Sql</b>DataReader</span>
    </div>
    <div class="ado-blk ado-h-prov ado-prov" data-p="oracle" style="grid-area: p2">
      <i class="ado-wir">im Unterricht</i>
      <code>Oracle.<wbr>ManagedDataAccess.<wbr>Core</code>
      <span><b>Oracle</b>Connection<br><b>Oracle</b>Command<br><b>Oracle</b>DataReader</span>
    </div>
    <div class="ado-blk ado-h-prov ado-prov" data-p="postgres" style="grid-area: p3">
      <i class="ado-wir">im Unterricht</i>
      <code>Npgsql</code>
      <span><b>Npgsql</b>Connection<br><b>Npgsql</b>Command<br><b>Npgsql</b>DataReader</span>
    </div>
    <div class="ado-blk ado-h-prov ado-prov" data-p="mysql" style="grid-area: p4">
      <i class="ado-wir">im Unterricht</i>
      <code>MySqlConnector</code>
      <span><b>MySql</b>Connection<br><b>MySql</b>Command<br><b>MySql</b>DataReader</span>
    </div>
    <div class="ado-blk ado-h-prov ado-prov" data-p="sqlite" style="grid-area: p5">
      <i class="ado-wir">im Unterricht</i>
      <code>Microsoft.<wbr>Data.<wbr>Sqlite</code>
      <span><b>Sqlite</b>Connection<br><b>Sqlite</b>Command<br><b>Sqlite</b>DataReader</span>
    </div>

    <div class="ado-lbl" style="grid-area: l4">Datenbank</div>
    <div class="ado-blk ado-h-db ado-db" data-p="sqlserver" style="grid-area: d1"><b>SQL Server</b><span>Microsoft</span></div>
    <div class="ado-blk ado-h-db ado-db" data-p="oracle" style="grid-area: d2"><b>Oracle Database</b><span>Oracle</span></div>
    <div class="ado-blk ado-h-db ado-db" data-p="postgres" style="grid-area: d3"><b>PostgreSQL</b><span>Open Source</span></div>
    <div class="ado-blk ado-h-db ado-db" data-p="mysql" style="grid-area: d4"><b>MySQL · MariaDB</b><span>Open Source</span></div>
    <div class="ado-blk ado-h-db ado-db" data-p="sqlite" style="grid-area: d5"><b>SQLite</b><span>Datei, kein Server</span></div>
  </div>

  <div class="ado-fuss">
    <span class="ado-lbl">Merke</span>
    <span>Gleiches Muster, anderes Präfix: Wer <code>SqlConnection</code> kann, kann jeden Provider.</span>
  </div>
</div>
</template>

<style>
/* ADO.NET-Übersicht – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.ado {
  --ado-bg: #ffffff;
  --ado-fg: #16212c;
  --ado-muted: #5a6876;
  --ado-a: #2c64c4;      /* ADO.NET-Kern (wie im Schichtenmodell) */
  --ado-r: #c8620e;      /* Hervorhebung: im Unterricht */
  --ado-prov: #4b5d70;
  --ado-db: #7a5b3c;
  --ado-app: #34424f;
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  padding: 16px 20px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  background: var(--ado-bg);
  color: var(--ado-fg);
  font-size: 14px;
  line-height: 1.05;
  text-align: left;
}
.dark .ado, .ado.dark {
  --ado-bg: #121a21;
  --ado-fg: #e6edf3;
  --ado-muted: #9aabba;
  --ado-a: #6fa1f2;
  --ado-r: #f0a04b;
  --ado-prov: #93a7bb;
  --ado-db: #c9a27c;
  --ado-app: #b7c4d0;
}
.ado *, .ado *::before, .ado *::after { box-sizing: border-box; }

/* Gemeinsame Text-Resets gegen Theme-Stile von Slidev */
.ado .ado-titel, .ado .ado-def, .ado .ado-lbl,
.ado .ado-blk b, .ado .ado-blk span, .ado .ado-blk code, .ado .ado-blk i,
.ado .ado-fuss span { margin: 0; line-height: 1.05; }
.ado code {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  background: none; padding: 0; border: 0; border-radius: 0;
}

/* Kopf mit Begriffserklärung */
.ado-kopf { display: grid; grid-template-columns: auto 1fr; gap: 18px; align-items: center; }
.ado .ado-titel { font-size: 30px; font-weight: 800; letter-spacing: -0.01em; }
.ado .ado-def {
  font-size: 13.5px; line-height: 1.4; color: var(--ado-fg);
  padding-left: 18px; border-left: 2px solid color-mix(in srgb, var(--ado-a) 50%, var(--ado-bg));
}
.ado .ado-def b { font-weight: 700; }
.ado .ado-def code { font-size: 12.5px; color: var(--ado-a); }

/* Raster */
.ado-raster {
  flex: 1;
  min-height: 0;
  display: grid;
  grid-template-columns: 84px repeat(5, minmax(0, 1fr));
  grid-template-rows: auto auto 1fr auto;
  grid-template-areas:
    "l1 app  app  app  app  app"
    "l2 core core core core core"
    "l3 p1   p2   p3   p4   p5"
    "l4 d1   d2   d3   d4   d5";
  gap: 8px 10px;
}
.ado .ado-lbl {
  font-size: 10.5px; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase;
  color: var(--ado-muted); display: flex; align-items: center;
}

/* Bausteine */
.ado-blk {
  --h: var(--ado-a);
  position: relative;
  min-width: 0;
  min-height: 0;
  padding: 7px 11px;
  border-radius: 8px;
  border: 1.5px solid color-mix(in srgb, var(--h) 60%, var(--ado-bg));
  background: color-mix(in srgb, var(--h) 11%, var(--ado-bg));
  display: flex; flex-direction: column; justify-content: center; gap: 2px;
}
.ado .ado-blk b { display: block; font-size: 14.5px; font-weight: 700; }
.ado .ado-blk span { display: block; font-size: 12.5px; color: var(--ado-muted); }
.ado-h-core { --h: var(--ado-a); }
.ado-h-prov { --h: var(--ado-prov); }
.ado-h-db { --h: var(--ado-db); border-style: dashed; }
.ado-h-app { --h: var(--ado-app); }

/* Provider-Karten */
.ado .ado-prov { justify-content: center; gap: 12px; padding: 12px; }
.ado .ado-prov code {
  display: block; font-size: 13px; font-weight: 700; color: var(--ado-fg);
  overflow-wrap: normal; word-break: normal; white-space: normal; line-height: 1.3;
}
.ado .ado-prov span { font-family: ui-monospace, "JetBrains Mono", Consolas, monospace; font-size: 13px; line-height: 1.6; }
.ado .ado-prov span b { display: inline; font-size: inherit; color: var(--h); }
.ado .ado-db b { font-size: 14.5px; }
.ado .ado-db span { font-size: 12px; }

/* Markierung „im Unterricht“ */
.ado .ado-wir {
  display: none; position: absolute; top: -9px; left: 10px;
  font-style: normal; font-size: 9.5px; font-weight: 700; letter-spacing: 0.04em; text-transform: uppercase;
  padding: 2px 7px; border-radius: 99px;
  background: var(--ado-r); color: var(--ado-bg);
}
.ado[data-markiert="sqlserver"] [data-p="sqlserver"],
.ado[data-markiert="oracle"] [data-p="oracle"],
.ado[data-markiert="postgres"] [data-p="postgres"],
.ado[data-markiert="mysql"] [data-p="mysql"],
.ado[data-markiert="sqlite"] [data-p="sqlite"] {
  --h: var(--ado-r);
  border-width: 2px;
}
.ado[data-markiert="sqlserver"] [data-p="sqlserver"] .ado-wir,
.ado[data-markiert="oracle"] [data-p="oracle"] .ado-wir,
.ado[data-markiert="postgres"] [data-p="postgres"] .ado-wir,
.ado[data-markiert="mysql"] [data-p="mysql"] .ado-wir,
.ado[data-markiert="sqlite"] [data-p="sqlite"] .ado-wir { display: block; }

/* Fußzeile */
.ado-fuss {
  display: flex; align-items: center; gap: 14px;
  padding: 9px 14px; border-radius: 10px;
  background: color-mix(in srgb, var(--ado-a) 8%, var(--ado-bg));
}
.ado .ado-fuss span:last-child { font-size: 13.5px; }
.ado .ado-fuss code { font-size: 12.5px; color: var(--ado-a); }
</style>
