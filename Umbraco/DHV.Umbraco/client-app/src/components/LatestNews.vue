<template>
  <cards
    v-bind="$attrs"
    :cards="currentPage.map(mapNewsItem)"
    :title="title"
    :extra-urls="[{ url: newsParent._url, name: 'Meer nieuws' }]"
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

const props = defineProps<{
  maxItems?: number;
  title: string;
  newsParent: { _id: string, _url: string; }
}>()

const id = computed(() => props.newsParent._id)
const maxItems = computed(() => props.maxItems)

const {
  currentPage, isLoading, getNextPage, hasNextPage,
} = useNewsCards(id, { maxItems })

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
