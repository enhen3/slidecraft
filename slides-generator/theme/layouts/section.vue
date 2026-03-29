<template>
  <div class="section-layout">
    <div class="section-content">
      <slot />
    </div>
  </div>
</template>

<style scoped>
.section-layout {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  padding-bottom: 160px;
  text-align: center;
  background: #FFFFFF !important;
}

.section-content {
  max-width: 85%;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 28px;
}

.section-content :deep(h2) {
  font-family: 'Noto Serif SC', 'Songti SC', Georgia, serif !important;
  font-size: 96px !important;
  font-weight: 900 !important;
  color: #1D1D1F !important;
  letter-spacing: -0.02em !important;
  line-height: 1.15 !important;
}

.section-content :deep(p) {
  font-family: 'Noto Sans SC', 'PingFang SC', sans-serif !important;
  font-size: 44px !important;
  color: #006B54 !important;
  font-weight: 500 !important;
  line-height: 1.4 !important;
  letter-spacing: 0.02em !important;
}
</style>
