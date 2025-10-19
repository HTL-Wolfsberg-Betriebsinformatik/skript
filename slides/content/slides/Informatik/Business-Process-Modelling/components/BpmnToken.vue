<script setup lang="ts">
defineProps({
  size: {
    type: Number,
    default: 32,
  },
  color: {
    type: String,
    default: 'blue',
  },
  x: {
    type: Number,
    default: 0,
  },
  y: {
    type: Number,
    default: 0,
  },
})
</script>

<template>
  <span
    :style="{
      fontSize: size + 'px',
      color,
      transform: `translate(${x}px, ${y}px)`,
    }"
  >
    &#9679;
  </span>
</template>
