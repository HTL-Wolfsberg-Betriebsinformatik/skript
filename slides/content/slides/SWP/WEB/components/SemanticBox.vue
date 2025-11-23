<script setup lang="ts">
const props = defineProps({
  label: {
    type: String,
    required: true
  },
  width: {
    type: String,
    default: 'full'   // full, half, third, quarter
  },
  height: {
    type: [String, Number],
    default: null // z.B. "200", "250px"
  }
})

const widthClasses = {
  full: 'w-full',
  half: 'w-1/2',
  third: 'w-1/3',
  quarter: 'w-1/4'
}
</script>

<template>
  <div
    class="flex m-2 frame border border-2 border-white bg-blue-500 rounded-xl p-4 shadow-sm items-center justify-center text-white font-semibold"
    :class="widthClasses[width]"
    :style="height ? { height: typeof height === 'number' ? height + 'px' : height } : {}"
  >
    <div class="text-center w-full flex flex-col items-center">
      {{ label }}

      <!-- Hier können weitere Boxen verschachtelt werden -->
      <slot />
    </div>
  </div>
</template>

<style scoped>
div.frame {
  transition: transform 0.2s ease;
}
div.frame:hover {
  transform: scale(1.01);
}
</style>