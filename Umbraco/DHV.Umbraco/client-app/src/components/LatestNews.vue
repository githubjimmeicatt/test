<template>
  <cards
    v-bind="$attrs"
    :cards="currentPage.map(mapNewsItem)"
    :title="title"
  />
  <Spinner v-if="isLoading" />
  <EndlessScroll v-else-if="hasNextPage" :get-next-page="getNextPage" />
</template>

<script lang="ts" setup>
import Spinner from '@/assets/spinner.svg'
import Cards from '@/components/Cards.vue'
import { formatDate } from '@/helpers/formatDate'
import EndlessScroll from '@/icatt-heartcore/components/EndlessScroll.vue'
import type { NewsCard } from '@/icatt-heartcore/composables/useNewsCards'
import useNewsCards from '@/icatt-heartcore/composables/useNewsCards'
import { computed } from 'vue'

const props = defineProps<{ maxItems?: number; title: string; newsParent: { _id: string } }>()

const defaultPageSize = 15

const pageSize = computed(() => Math.min(props.maxItems ?? defaultPageSize, defaultPageSize))
const id = computed(() => props.newsParent._id)

const {
  currentPage, isLoading, getNextPage, hasNextPage,
} = useNewsCards(id, { pageSize })

function mapNewsItem({
  summary, name, publishDate, url, image,
}: NewsCard) {
  return {
    body: summary,
    title: name,
    date: publishDate,
    subtitle: formatDate(publishDate),
    target: { url, name: 'Lees meer' },
    image,
    hasNextPage,
    getNextPage,
  }
}
</script>
