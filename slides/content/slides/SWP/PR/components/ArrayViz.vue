<template>
  <div class="av-root" :style="{ fontFamily: mono ? 'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace' : 'inherit' }">
    <div v-if="label" class="av-label">{{ label }}</div>

    <div class="av-rows">
      <!-- values row -->
      <div class="av-row">
        <div
          v-for="(item, i) in normalizedItems"
          :key="i"
          class="av-cell"
          :class="{ 'is-highlight': isHighlighted(i) }"
          :style="cellStyle"
          :title="String(item)"
        >
          {{ format(item) }}
        </div>
      </div>

      <!-- indices row -->
      <div v-if="showIndices" class="av-row av-index-row">
        <div
          v-for="(_, i) in normalizedItems"
          :key="i"
          class="av-index"
          :style="{ width: cellWidthPx, color: '#ff0000' }"
        >
          {{ startIndex + i }}
        </div>
      </div>
    </div>

    <div v-if="showLength" class="av-meta">
      <span><strong>Length</strong>: {{ normalizedItems.length }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

type Primitive = string | number | boolean | null | undefined

const props = withDefaults(
  defineProps<{
    items: Primitive[]
    label?: string
    showIndices?: boolean
    startIndex?: number
    highlightIndex?: number | null
    showLength?: boolean
    cellWidth?: number
    cellHeight?: number
    mono?: boolean
    maxChars?: number
    decimals?: number
  }>(),
  {
    label: '',
    showIndices: true,
    startIndex: 0,
    highlightIndex: null,
    showLength: false,
    cellWidth: 72,
    cellHeight: 58,
    mono: true,
    maxChars: 10,
    decimals: 2,
  }
)

const normalizedItems = computed(() => Array.isArray(props.items) ? props.items : [])

const cellWidthPx = computed(() => `${props.cellWidth}px`)
const cellStyle = computed(() => ({
  width: `${props.cellWidth}px`,
  height: `${props.cellHeight}px`,
}))

function isHighlighted(localIndex: number) {
  if (props.highlightIndex === null || props.highlightIndex === undefined) return false
  return props.highlightIndex === props.startIndex + localIndex
}

function format(v: Primitive) {
  // show null/undefined clearly
  if (v === null) return 'null'
  if (v === undefined) return 'undef'

  // numbers: optionally format with decimals (useful for doubles)
  if (typeof v === 'number') {
    // keep integers as-is
    if (Number.isInteger(v)) return String(v)
    return v.toFixed(props.decimals)
  }

  // strings: shorten if too long
  const s = String(v)
  if (s.length <= props.maxChars) return s
  return s.slice(0, Math.max(0, props.maxChars - 1)) + '…'
}
</script>

<style scoped>
.av-root {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  margin-top: 24px;
}

.av-label {
  font-size: 18px;
  opacity: 0.9;
}

.av-rows {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.av-row {
  display: flex;
}

.av-cell {
  border: 2px solid rgba(0,0,0,0.65);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  line-height: 1;
  user-select: none;
  background: rgba(255,255,255,0.55);
}

.av-index-row {
  margin-top: 2px;
}

.av-index {
  text-align: center;
  font-size: 13px;
  opacity: 0.65;
}

.is-highlight {
  outline: 4px solid rgba(0,0,0,0.75);
  outline-offset: -4px;
  background: rgba(0,0,0,0.08);
}

.av-meta {
  font-size: 14px;
  opacity: 0.75;
}
</style>