<!--
  Schichtenmodell.vue – Überblicksfolie „Datenbankzugriff in C#“
  Ablage: components/Schichtenmodell.vue (Slidev registriert die Komponente automatisch)

  Verwendung:
    <Schichtenmodell />                                   alles sichtbar
    <Schichtenmodell fokus="ef" titel="Wo sind wir?" />   Schritt hervorgehoben: "reader" oder "ef"

  Ausgelegt für die Slidev-Fläche 980 × 552 → am besten mit „layout: full“.
  Dunkles Design folgt automatisch dem Slidev-Dark-Mode (html.dark).
-->
<script setup lang="ts">
withDefaults(defineProps<{
  fokus?: 'alle' | 'reader' | 'ef'
  titel?: string
}>(), {
  fokus: 'alle',
  titel: 'Datenbankzugriff in C# – unser Weg',
})
</script>

<template>
<div class="sm" :data-fokus="fokus">
  <div class="sm-kopf">
    <div class="sm-titel">{{ titel }}</div>
    <div class="sm-weg">
      <span class="sm-chip sm-h-r" data-t="reader"><b>1</b> SqlCommand + DataReader</span>
      <span class="sm-pfeil">→</span>
      <span class="sm-chip sm-h-d" data-t="ef"><b>2</b> EF Core + LINQ</span>
    </div>
  </div>

  <div class="sm-raster">
    <div class="sm-lbl" style="grid-area: l1">Anwendung</div>
    <div class="sm-blk sm-h-app" data-t="reader ef" style="grid-area: app">
      <b>Deine Anwendung</b>
      <span>Konsole · WinForms · ASP.NET Core</span>
    </div>

    <div class="sm-achse" style="grid-area: l2">
      <span class="sm-lbl">Zugriff</span>
      <span class="sm-achse-linie"></span>
      <span class="sm-lbl sm-lbl-klein">mehr Abstraktion</span>
    </div>

    <div class="sm-turm" style="grid-area: a">
      <div class="sm-blk sm-h-r sm-hoch" data-t="reader">
        <b>SqlCommand + SqlDataReader</b>
        <span>SQL selbst schreiben · Parameter</span>
        <span>ExecuteScalar · NonQuery · Reader</span>
        <span>Mapping von Hand · Transaktion</span>
      </div>
    </div>

    <div class="sm-orm sm-h-d" style="grid-area: ef">
      <div class="sm-orm-kopf" data-t="ef">ORM · Entity Framework Core</div>
      <div class="sm-blk sm-h-c" data-t="ef">
        <b>LINQ-Abfrage wird zu SQL</b>
        <code>db.Artikel.Where(a =&gt; a.Preis &lt; 20)</code>
      </div>
      <div class="sm-blk sm-h-d" data-t="ef">
        <b>DbContext · Change Tracking</b>
        <span>merkt sich geänderte Objekte, SaveChanges() speichert sie</span>
      </div>
      <div class="sm-blk sm-h-d" data-t="ef">
        <b>Migrations</b>
        <span>Datenbankschema aus C#-Klassen</span>
      </div>
      <div class="sm-blk sm-h-d" data-t="ef">
        <b>EF-Core-Provider</b>
        <span>Microsoft.EntityFrameworkCore.SqlServer</span>
      </div>
    </div>

    <div class="sm-lbl" style="grid-area: l3">ADO.NET</div>
    <div class="sm-blk sm-h-a" data-t="reader ef" style="grid-area: core">
      <b>SqlConnection · SqlCommand · SqlParameter · SqlDataReader · SqlTransaction</b>
      <span>direkt verwendet in Schritt 1, intern verwendet von EF Core</span>
    </div>

    <div class="sm-lbl" style="grid-area: l4">Provider</div>
    <div class="sm-blk sm-h-prov" data-t="reader ef" style="grid-area: prov">
      <b>Microsoft.Data.SqlClient</b>
      <span>NuGet-Paket · spricht direkt mit SQL Server</span>
    </div>

    <div class="sm-lbl" style="grid-area: l5">Datenbank</div>
    <div class="sm-blk sm-h-db sm-db" data-t="reader ef" style="grid-area: db">
      <b>SQL Server · OnlineShop</b>
      <span>Kunde · Artikel · Bestellung · Bestellposition</span>
    </div>
  </div>
</div>
</template>

<style>
/* Schichtenmodell – ausgelegt für die Slidev-Fläche 980 × 552 (16:9) */
.sm {
  --sm-bg: #ffffff;
  --sm-fg: #16212c;
  --sm-muted: #5a6876;
  --sm-line: #d4dce3;
  --sm-a: #2c64c4;      /* ADO.NET-Kern */
  --sm-r: #c8620e;      /* Schritt 1: SqlCommand + SqlDataReader */
  --sm-c: #7446c2;      /* LINQ */
  --sm-d: #17835a;      /* Schritt 2: EF Core */
  --sm-prov: #4b5d70;
  --sm-db: #7a5b3c;
  --sm-app: #34424f;
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  padding: 16px 20px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  background: var(--sm-bg);
  color: var(--sm-fg);
  font-size: 14px;
  line-height: 1.05;
  text-align: left;
}
.dark .sm, .sm.dark {
  --sm-bg: #121a21;
  --sm-fg: #e6edf3;
  --sm-muted: #9aabba;
  --sm-line: #2e3b48;
  --sm-a: #6fa1f2;
  --sm-r: #f0a04b;
  --sm-c: #b08cf0;
  --sm-d: #4fc58f;
  --sm-prov: #93a7bb;
  --sm-db: #c9a27c;
  --sm-app: #b7c4d0;
}
.sm *, .sm *::before, .sm *::after { box-sizing: border-box; }
.sm p { margin: 0; }

/* Kopfzeile */
.sm-kopf { display: flex; justify-content: space-between; align-items: center; gap: 16px; }
.sm-titel { font-size: 24px; font-weight: 700; letter-spacing: -0.01em; }
.sm-weg { display: flex; align-items: center; gap: 6px; flex-wrap: nowrap; }
.sm-chip {
  --h: var(--sm-a);
  font-size: 12px; white-space: nowrap;
  padding: 3px 9px; border-radius: 99px;
  border: 1.5px solid var(--h);
  color: var(--sm-fg);
  background: color-mix(in srgb, var(--h) 10%, var(--sm-bg));
}
.sm-chip b { color: var(--h); margin-right: 3px; }
.sm-pfeil { color: var(--sm-muted); font-size: 12px; }

/* Raster */
.sm-raster {
  flex: 1;
  min-height: 0;
  display: grid;
  grid-template-columns: 84px 1fr 1.5fr;
  grid-template-rows: auto 1fr auto auto auto;
  grid-template-areas:
    "l1 app  app"
    "l2 a    ef"
    "l3 core core"
    "l4 prov prov"
    "l5 db   db";
  gap: 8px 14px;
}
.sm-lbl {
  font-size: 10.5px; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase;
  color: var(--sm-muted); display: flex; align-items: center;
}
.sm-lbl-klein { font-size: 9.5px; letter-spacing: 0.05em; }

.sm-achse { display: flex; flex-direction: column; align-items: flex-start; gap: 6px; padding-block: 2px; }
.sm-achse-linie {
  flex: 1; width: 2px; margin-left: 9px; position: relative;
  background: linear-gradient(to top, var(--sm-line), var(--sm-muted));
}
.sm-achse-linie::before {
  content: ""; position: absolute; top: -2px; left: -5px;
  border: 6px solid transparent; border-bottom: 9px solid var(--sm-muted); border-top: 0;
}

/* Bausteine */
.sm-blk {
  --h: var(--sm-a);
  position: relative;
  min-height: 0;
  padding: 6px 11px;
  border-radius: 8px;
  border: 1.5px solid color-mix(in srgb, var(--h) 60%, var(--sm-bg));
  background: color-mix(in srgb, var(--h) 11%, var(--sm-bg));
  display: flex; flex-direction: column; justify-content: center; gap: 1px;
}
/* Textelemente: Zeilenhöhe und Abstände fest setzen, damit Theme-Stile von Slidev
   (z. B. line-height 1.75, Abstände bei p/code) nichts aus den Kästen schieben */
.sm .sm-blk b,
.sm .sm-blk span,
.sm .sm-blk code {
  display: block;
  margin: 0;
  line-height: 1.05;
}
.sm .sm-blk b { font-size: 14.5px; font-weight: 700; }
.sm .sm-blk span { font-size: 12.5px; color: var(--sm-muted); }
.sm .sm-blk code {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
  font-size: 12px; color: var(--h); background: none; padding: 0; border: 0; border-radius: 0;
}
.sm .sm-titel, .sm .sm-chip, .sm .sm-lbl, .sm .sm-orm-kopf { line-height: 1.2; margin: 0; }
.sm-h-a { --h: var(--sm-a); }
.sm-h-r { --h: var(--sm-r); }
.sm-h-c { --h: var(--sm-c); }
.sm-h-d { --h: var(--sm-d); }
.sm-h-prov { --h: var(--sm-prov); }
.sm-h-db { --h: var(--sm-db); }
.sm-h-app { --h: var(--sm-app); }
.sm-db { border-style: dashed; }

/* Schritt 1: niedriger Turm (wenig Abstraktion) */
.sm-turm { display: flex; flex-direction: column; justify-content: flex-end; min-height: 0; }
.sm-hoch { flex: 0 0 52%; justify-content: flex-start; gap: 3px; padding-top: 8px; }
.sm .sm-hoch b { margin-bottom: 4px; }

/* Schritt 2: ORM-Rahmen um EF Core */
.sm-orm {
  min-height: 0;
  border: 1.5px dashed var(--h);
  border-radius: 12px;
  padding: 6px;
  display: grid;
  grid-template-rows: auto repeat(4, minmax(0, 1fr));
  gap: 5px;
}
.sm-orm-kopf {
  position: relative; display: flex; align-items: center; height: 18px; padding-left: 4px;
  font-size: 10.5px; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase; color: var(--h);
}

/* Fokus: alles, was nicht zum gewählten Schritt gehört, wird abgeblendet */
.sm [data-t] { transition: opacity .25s ease, filter .25s ease; }
.sm[data-fokus="reader"] [data-t]:not([data-t~="reader"]),
.sm[data-fokus="ef"] [data-t]:not([data-t~="ef"]) {
  opacity: 0.22;
  filter: grayscale(0.7);
}
/* ORM-Rahmen: nur der Rahmen wird blasser, die Bausteine darin regeln sich selbst */
.sm[data-fokus="reader"] .sm-orm { border-color: color-mix(in srgb, var(--h) 30%, var(--sm-bg)); }
@media (prefers-reduced-motion: reduce) { .sm [data-t] { transition: none; } }
</style>
