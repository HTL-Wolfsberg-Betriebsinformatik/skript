<template>
  <div class="callout">
    <div class="callout-title">{{ title }}</div>
    <div class="callout-body"><slot /></div>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{ title?: string }>(), {
  title: '💡 Merke',
})
</script>

<style scoped>
.callout {
  margin-top: 0.8rem;
  padding: 0.45rem 0.9rem;
  border-left: 5px solid #16a34a;
  border-radius: 6px;
  background: #f0fdf4;
  color: #052e16;
  font-size: 0.85rem;
  line-height: 1.45;
  text-align: left;
}
.callout-title {
  font-weight: 700;
  color: #15803d;
  margin-bottom: 0.15rem;
}
.callout-body :deep(p) {
  margin: 0;
}
</style>
