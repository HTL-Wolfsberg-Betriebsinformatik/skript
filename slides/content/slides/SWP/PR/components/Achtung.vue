<template>
  <div class="callout">
    <div class="callout-title">{{ title }}</div>
    <div class="callout-body"><slot /></div>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{ title?: string }>(), {
  title: '⚠️ Häufiger Fehler',
})
</script>

<style scoped>
.callout {
  margin-top: 0.8rem;
  padding: 0.45rem 0.9rem;
  border-left: 5px solid #dc2626;
  border-radius: 6px;
  background: #fef2f2;
  color: #450a0a;
  font-size: 0.85rem;
  line-height: 1.45;
  text-align: left;
}
.callout-title {
  font-weight: 700;
  color: #b91c1c;
  margin-bottom: 0.15rem;
}
.callout-body :deep(p) {
  margin: 0;
}
</style>
