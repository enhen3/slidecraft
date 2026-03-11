<template>
  <div class="diagram-layout">
    <div class="diagram-body">
      <slot />
    </div>
  </div>
</template>

<style scoped>
.diagram-layout {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  background: #FFFFFF !important;
  color: #1D1D1F !important;
}

.diagram-body {
  width: 100%;
  max-width: 95%;
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
