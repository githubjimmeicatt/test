<template>
  <span ref="trackEl" class="visually-hidden" />
</template>

<script lang="ts">
export default {
  inheritAttrs: false,
}
</script>

<script lang="ts" setup>
import { ref } from 'vue'
import { useElementVisibility, whenever } from '@vueuse/core'

const props = defineProps({
  getNextPage: {
    type: Function,
    required: true,
  },
})

const trackEl = ref()

const isVisible = useElementVisibility(trackEl)

whenever(isVisible, () => props.getNextPage(), {
  immediate: true,
})
</script>

<style lang="scss" scoped>
.visually-hidden {
  opacity: 0;
  font-size: 0;
  margin: 0;
  padding: 0;
}
</style>
