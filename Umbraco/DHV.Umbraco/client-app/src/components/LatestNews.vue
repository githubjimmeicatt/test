<template>
  <EndlessNews :max-items="maxItems" :news-parent="newsParent">
    <template #default="{ items, isLoading }">
      <cards
        v-bind="$attrs"
        :cards="items.map(mapNewsItem)"
        :title="title"
      />
      <Spinner v-if="isLoading" />
    </template>
  </EndlessNews>
</template>

<script lang="ts" setup>
import Spinner from '@/assets/spinner.svg'
import Cards from '@/components/Cards.vue'
import { formatDate } from '@/helpers/formatDate'
import EndlessNews from '@/icatt-heartcore/components/EndlessNews.vue'
import type { NewsCard } from '@/icatt-heartcore/composables/useNewsCards'

defineProps<{ maxItems?: number; title: string; newsParent: { _id: string } }>()

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
  }
}
</script>
