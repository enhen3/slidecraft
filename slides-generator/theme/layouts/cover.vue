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
  font-size: 110px !important;
  color: #1D1D1F !important;
  font-weight: 800 !important;
  letter-spacing: -0.04em !important;
  line-height: 1.08 !important;
  text-align: center !important;
}

.cover-title :deep(p) {
  font-size: 48px !important;
  color: #3A3A3C !important;
  font-weight: 500 !important;
  text-align: center !important;
  line-height: 1.4 !important;
}

.cover-title :deep(img) {
  max-width: 70% !important;
  margin: 16px auto !important;
  border-radius: 24px !important;
}
</style>
