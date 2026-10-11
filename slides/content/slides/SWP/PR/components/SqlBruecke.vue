<template>
  <div class="callout">
    <div class="callout-title">{{ title }}</div>
    <div class="callout-body"><slot /></div>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{ title?: string }>(), {
  title: '🔁 Kennst du aus SQL',
})
</script>

<style scoped>
.callout {
  margin-top: 0.8rem;
  padding: 0.45rem 0.9rem;
  border-left: 5px solid #2563eb;
  border-radius: 6px;
  background: #eff6ff;
  color: #172554;
  font-size: 0.85rem;
  line-height: 1.45;
  text-align: left;
}
.callout-title {
  font-weight: 700;
  color: #1d4ed8;
  margin-bottom: 0.15rem;
}
.callout-body :deep(p) {
  margin: 0;
}
</style>
