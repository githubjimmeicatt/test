<template>
  <slot name="default" :items="limitedPage" :is-loading="isLoading" />
  <span
    v-if="!hideTrackEl"
    ref="trackEl"
    class="visually-hidden"
  />
</template>

<script lang="ts">
export default {
  inheritAttrs: false,
}
</script>

<script lang="ts" setup>
import {
  computed, ref, type PropType,
} from 'vue'
import { useElementVisibility, whenever } from '@vueuse/core'
import useNewsCards from '@/icatt-heartcore/composables/useNewsCards'

const props = defineProps({
  maxItems: {
    type: Number,
    default: undefined,
  },
  newsParent: {
    type: Object as PropType<{ _id: string }>,
    required: true,
  },
})

const trackEl = ref()

const defaultPageSize = 15

const pageSize = computed(() => Math.min(props.maxItems ?? defaultPageSize, defaultPageSize))
const id = computed(() => props.newsParent._id)

const {
  currentPage, hasNextPage, getNextPage, isLoading,
} = useNewsCards(id, { pageSize })

const limitedPage = computed(() => {
  if (!props.maxItems || props.maxItems > currentPage.value.length) return currentPage.value
  return currentPage.value.slice(0, props.maxItems)
})

const hideTrackEl = computed(() => isLoading.value || !hasNextPage.value
  || (props.maxItems && props.maxItems <= currentPage.value.length))

const isVisible = useElementVisibility(trackEl)

whenever(isVisible, getNextPage, {
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
