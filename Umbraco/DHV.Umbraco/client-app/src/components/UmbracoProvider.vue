<template>
  <component
    :is="component"
    v-if="component"
  />
</template>

<script>
import { inject } from 'vue'

export default {
  setup() {
    return {
      component: inject('component'),
    }
  },
}
</script>
