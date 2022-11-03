<template>
  <cards
    :cards="currentPage"
    :title="content.name"
  />
  <Spinner v-if="isLoading" />
  <span
    v-if="!isLoading && hasNextPage"
    ref="trackEl"
    class="visually-hidden"
  >Hi mum</span>
</template>

<script>
import {
  computed, inject, ref,
} from 'vue'
import { useElementVisibility, whenever } from '@vueuse/core'
import useNewsCards from '../composables/useNewsCards'
import Cards from './Cards.vue'
import Spinner from '../assets/spinner.svg'

export default {
  components: { Cards, Spinner },
  setup() {
    const trackEl = ref()
    const content = inject('content')
    const id = computed(() => content.value?._id)
    const {
      currentPage, hasNextPage, getNextPage, isLoading,
    } = useNewsCards(id)

    const isVisible = useElementVisibility(trackEl)

    whenever(isVisible, getNextPage, {
      immediate: true,
    })

    return {
      currentPage,
      hasNextPage,
      isLoading,
      getNextPage,
      content,
      id,
      trackEl,
      isVisible,
    }
  },
}
</script>

<style lang="scss" scoped>
.visually-hidden {
  opacity: 0;
  font-size: 0;
  margin: 0;
  padding: 0;

}
</style>
