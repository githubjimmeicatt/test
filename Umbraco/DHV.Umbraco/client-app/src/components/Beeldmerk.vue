<template>
  <svg class="beeldmerk" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 141.73 215.43" preserveAspectRatio="xMidYMid meet" width="100%">
    <use :href="svg + '#left'" />
    <use fill="currentColor" :href="svg + '#right'" />
  </svg>
</template>

<script>
const svg = '/assets/beeldmerk.svg'

export default {
  setup() {
    return { svg }
  },
}
</script>

<style>
svg.beeldmerk {
  fill: var(--color-accent-1);
  color: var(--color-accent-2);
}
</style>
