<template>
  <cards
    :cards="limitedPage"
    :title="title"
  />
  <Spinner v-if="isLoading" />
  <span
    v-if="!hideTrackEl"
    ref="trackEl"
    class="visually-hidden"
  >Hi mum</span>
</template>

<script lang="ts" setup>
import {
  computed, ref,
} from 'vue'
import { useElementVisibility, whenever } from '@vueuse/core'
import useNewsCards from '../composables/useNewsCards'
import Cards from './Cards.vue'
import Spinner from '../assets/spinner.svg'

const props = defineProps<{ maxItems?: number; title: string; newsParent: { _id: string } }>()

const trackEl = ref()

const pageSize = computed(() => Math.min(props.maxItems ?? 0, 15))
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
