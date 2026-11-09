<!--
  ForZerlegung.vue – Die drei Teile des for-Kopfs und ihre Entsprechung in einer while-Schleife
  Ablage: components/ForZerlegung.vue (Slidev registriert die Komponente automatisch)

  Verwendung (3 Klicks: Startwert → Bedingung → Veränderung):
    ---
    clicks: 3
    ---
    # for = while in kompakt
    <ForZerlegung :schritt="$clicks" />

  Ohne :schritt sind alle drei Teile sichtbar.
  Fließt im normalen Layout unter einer Überschrift. Dunkles Design folgt dem Slidev-Dark-Mode (html.dark).
-->
<script setup lang="ts">
import { computed } from 'vue'

const props = withDefaults(defineProps<{ schritt?: number | 'alle' }>(), { schritt: 'alle' })

const stufe = computed(() =>
  typeof props.schritt === 'number' ? Math.min(Math.max(props.schritt, 0), 3) : 3
)
// Teil n ist sichtbar ab Stufe n, aktuell genau bei Stufe n
const cls = (n: number) => ({ 'is-an': stufe.value >= n, 'is-jetzt': stufe.value === n && props.schritt !== 'alle' })

const teile = [
  { n: 1, nr: '①', name: 'Startwert', wann: 'einmal, ganz am Anfang', code: 'int i = 1' },
  { n: 2, nr: '②', name: 'Bedingung', wann: 'vor jedem Durchlauf: true → weiter, false → Ende', code: 'i <= 3' },
  { n: 3, nr: '③', name: 'Veränderung', wann: 'am Ende jedes Durchlaufs', code: 'i++' },
]
</script>

<template>
<div class="fz">
  <div class="fz-kopf">
    <span class="fz-k">for</span> (<span class="fz-t fz-a" :class="cls(1)">int i = 1</span>; <span class="fz-t fz-b" :class="cls(2)">i &lt;= 3</span>; <span class="fz-t fz-c" :class="cls(3)">i++</span>)
  </div>

  <div class="fz-reihe">
    <div class="fz-karten">
      <div v-for="t in teile" :key="t.n" class="fz-karte" :class="[`fz-${'abc'[t.n - 1]}`, cls(t.n)]">
        <div class="fz-karte-kopf"><span class="fz-nr">{{ t.nr }}</span> {{ t.name }}</div>
        <code class="fz-karte-code">{{ t.code }}</code>
        <div class="fz-wann">{{ t.wann }}</div>
      </div>
    </div>

    <div class="fz-pfeil" aria-label="entspricht"></div>

    <pre class="fz-while"><span class="fz-t fz-a" :class="cls(1)"><span class="fz-k">int</span> i = 1;</span>
<span class="fz-k">while</span> (<span class="fz-t fz-b" :class="cls(2)">i &lt;= 3</span>)
{
    Console.WriteLine(i);
    <span class="fz-t fz-c" :class="cls(3)">i++;</span>
}</pre>
  </div>
</div>
</template>

<style>
.fz {
  --fz-fg: #17202b;
  --fz-muted: #5b6676;
  --fz-rule: #d5dce6;
  --fz-code-bg: #121a26;
  --fz-code-fg: #dfe6f0;
  --fz-kw: #8fb4ff;
  --fz-a: #2563eb;
  --fz-b: #d97706;
  --fz-c: #7c3aed;
  margin-top: 12px;
  color: var(--fz-fg);
  text-align: left;
}
.dark .fz {
  --fz-fg: #e6ebf2;
  --fz-muted: #98a4b5;
  --fz-rule: #2a3546;
  --fz-code-bg: #0a1018;
  --fz-a: #6f9cff;
  --fz-b: #f2a541;
  --fz-c: #b18cff;
}
.fz * { box-sizing: border-box; }
.fz .fz-kopf, .fz .fz-while, .fz code {
  font-family: ui-monospace, "JetBrains Mono", Consolas, monospace;
}
.fz .fz-kopf {
  display: inline-block;
  background: var(--fz-code-bg);
  color: var(--fz-code-fg);
  font-size: 30px;
  padding: 12px 24px;
  border-radius: 12px;
}
.fz .fz-k { color: var(--fz-kw); }

/* farbige Teile: grau, solange noch nicht besprochen */
.fz .fz-t {
  border-radius: 6px;
  padding: 0 4px;
  border-bottom: 3px solid transparent;
  opacity: .45;
  transition: all .35s;
}
.fz .fz-t.is-an { opacity: 1; }
.fz .fz-t.fz-a.is-an { border-bottom-color: var(--fz-a); background: color-mix(in srgb, var(--fz-a) 28%, transparent); }
.fz .fz-t.fz-b.is-an { border-bottom-color: var(--fz-b); background: color-mix(in srgb, var(--fz-b) 28%, transparent); }
.fz .fz-t.fz-c.is-an { border-bottom-color: var(--fz-c); background: color-mix(in srgb, var(--fz-c) 32%, transparent); }
.fz .fz-t.is-jetzt { box-shadow: 0 0 0 2px currentColor; }

.fz-reihe { display: flex; align-items: center; gap: 22px; margin-top: 22px; }
.fz-karten { display: flex; flex-direction: column; gap: 10px; flex: 1.4; }
.fz-karte {
  display: grid;
  grid-template-columns: 7.8em 5.6em 1fr;
  align-items: center;
  gap: 12px;
  padding: 8px 14px;
  border: 1.5px solid var(--fz-rule);
  border-left-width: 6px;
  border-radius: 10px;
  opacity: .25;
  transform: translateX(-10px);
  transition: all .35s;
}
.fz-karte.is-an { opacity: 1; transform: none; }
.fz-karte.fz-a { border-left-color: var(--fz-a); }
.fz-karte.fz-b { border-left-color: var(--fz-b); }
.fz-karte.fz-c { border-left-color: var(--fz-c); }
.fz-karte.is-jetzt.fz-a { border-color: var(--fz-a); }
.fz-karte.is-jetzt.fz-b { border-color: var(--fz-b); }
.fz-karte.is-jetzt.fz-c { border-color: var(--fz-c); }
.fz-karte-kopf { font-weight: 700; font-size: 17px; }
.fz-nr { font-size: 20px; }
.fz-a .fz-nr { color: var(--fz-a); }
.fz-b .fz-nr { color: var(--fz-b); }
.fz-c .fz-nr { color: var(--fz-c); }
.fz .fz-karte-code { font-size: 15px; background: none; padding: 0; }
.fz-wann { font-size: 13.5px; color: var(--fz-muted); line-height: 1.3; }

.fz-pfeil { font-size: 28px; color: var(--fz-muted); font-weight: 700; }
.fz-pfeil::after { content: "≙"; }

.fz .fz-while {
  margin: 0;
  background: var(--fz-code-bg);
  color: var(--fz-code-fg);
  font-size: 16px;
  line-height: 1.75;
  padding: 12px 20px;
  border-radius: 12px;
  white-space: pre;
}
</style>
