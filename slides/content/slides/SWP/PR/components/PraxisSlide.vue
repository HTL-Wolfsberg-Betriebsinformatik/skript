<template>
  <div class="praxis-root">
    <div class="praxis-head">
      <span class="praxis-badge">🛠 Praxis<span v-if="block"> · Block {{ block }}</span></span>
      <span v-if="time" class="praxis-time">⏱ {{ time }}</span>
    </div>

    <h2 class="praxis-title">{{ title }}</h2>

    <div class="praxis-body">
      <slot />
    </div>

    <div v-if="$slots.hinweis" class="praxis-hint">
      <strong>💡 Hinweis:</strong>
      <slot name="hinweis" />
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  title: string
  time?: string
  block?: number | string
}>()
</script>

<style>
/* färbt die gesamte Folie ein, sobald die Komponente darauf vorkommt */
.slidev-layout:has(.praxis-root) {
  background: linear-gradient(135deg, #fff8e6 0%, #ffefc7 100%) !important;
  border-left: 14px solid #f59e0b;
}
</style>

<style scoped>
.praxis-root {
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
  height: 100%;
  color: #3b2a07;
}

.praxis-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.praxis-badge {
  background: #f59e0b;
  color: #fff;
  font-weight: 700;
  padding: 0.2rem 0.8rem;
  border-radius: 999px;
  font-size: 0.9rem;
  letter-spacing: 0.03em;
}

.praxis-time {
  border: 2px solid #f59e0b;
  color: #92400e;
  font-weight: 600;
  padding: 0.1rem 0.7rem;
  border-radius: 999px;
  font-size: 0.9rem;
}

.praxis-title {
  margin: 0 !important;
  font-size: 1.8rem !important;
  font-weight: 700;
  color: #92400e;
}

.praxis-body {
  font-size: 0.95rem;
}

.praxis-hint {
  margin-top: auto;
  background: #fffbeb;
  border: 1px dashed #d97706;
  border-radius: 8px;
  padding: 0.4rem 0.8rem;
  font-size: 0.85rem;
}
</style>
