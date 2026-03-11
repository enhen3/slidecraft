<template>
  <div class="content-layout">
    <div class="content-body">
      <slot />
    </div>
  </div>
</template>

<style scoped>
.content-layout {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  background: #FFFFFF !important;
  color: #1D1D1F !important;
}

.content-body {
  width: 100%;
  max-width: 92%;
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
