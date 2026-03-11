<template>
  <div class="section-layout">
    <div class="section-content">
      <slot />
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  color: { type: String, default: 'emerald' }
})

const colorMap = {
  emerald: '#006B54',
  amber:   '#B35A00',
  indigo:  '#3F3BBB',
  teal:    '#00838F',
}
</script>

<style scoped>
.section-layout {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  text-align: center;
  background: #FFFFFF !important;
}

.section-content {
  max-width: 85%;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 32px;
}

.section-content :deep(h2) {
  font-size: 96px !important;
  font-weight: 800 !important;
  color: #1D1D1F !important;
  letter-spacing: -0.03em !important;
  line-height: 1.1 !important;
}

.section-content :deep(p) {
  font-size: 48px !important;
  color: #006B54 !important;
  font-weight: 600 !important;
  line-height: 1.4 !important;
}
</style>
