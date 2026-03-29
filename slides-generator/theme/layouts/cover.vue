<template>
  <div class="cover-layout">
    <div class="cover-title">
      <slot />
    </div>
  </div>
</template>

<style scoped>
.cover-layout {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  padding-bottom: 160px;
  text-align: center;
  background: #FFFFFF !important;
  color: #1D1D1F !important;
}

.cover-title {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 32px;
  max-width: 90%;
}

.cover-title :deep(h1) {
  font-family: 'Noto Serif SC', 'Songti SC', Georgia, serif !important;
  font-size: 110px !important;
  color: #1D1D1F !important;
  font-weight: 900 !important;
  letter-spacing: -0.02em !important;
  line-height: 1.15 !important;
  text-align: center !important;
}

.cover-title :deep(p) {
  font-family: 'Noto Sans SC', 'PingFang SC', sans-serif !important;
  font-size: 48px !important;
  color: #8E8E93 !important;
  font-weight: 400 !important;
  text-align: center !important;
  line-height: 1.4 !important;
  letter-spacing: 0.08em !important;
}

.cover-title :deep(img) {
  max-width: 70% !important;
  margin: 16px auto !important;
  border-radius: 24px !important;
}
</style>
