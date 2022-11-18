<template>
  <cards
    v-bind="$attrs"
    :cards="currentPage.map(mapNewsItem)"
    :title="title"
    :extra-urls="extraUrls"
  />

  <Spinner v-if="isLoading" class="spinner" />

  <EndlessScroll v-else-if="hasNextPage" :get-next-page="getNextPage" />
</template>

<script lang="ts" setup>
import Spinner from '@/assets/spinner.svg'
import Cards from '@/components/Cards.vue'
import { formatDate } from '@/helpers/formatDate'
import { EndlessScroll, useNewsCards, type NewsCard } from 'icatt-heartcore'
import { computed, inject } from 'vue'

const props = defineProps<{
  maxItems?: number;
  title: string;
  newsParent: { _id: string, _url: string; }
}>()

const id = computed(() => props.newsParent._id)
const maxItems = computed(() => props.maxItems)
const content = inject<any>('content')

const {
  currentPage, isLoading, getNextPage, hasNextPage,
} = useNewsCards(id, { maxItems })

const extraUrls = computed(() => (props.newsParent._id === content?.value?._id
  ? []
  : [{ url: props.newsParent._url, name: 'Bekijk al het nieuws' }]))

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

<style lang="scss" scoped>
.spinner {
  align-self: center;
  margin-block: var(--space-medium);
}
</style>
