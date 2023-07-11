<template>
  <section class="container topimage">
    <lazy-img
      v-if="content.image"
      :src="content.image"
    />
  </section>
  <h1>TEST</h1>
  <breadcrumbs class="breadcrumbs" />

  <section class="container">
    <article>
      <h1>{{ content.name }}</h1>

      <p v-if="date" class="article-date">
        {{ date }}
      </p>

      <rich-text :body="content.body" />
    </article>
  </section>

  <Spinner v-if="isLoading" class="spinner" />

  <Cards v-else title="Bekijk ook" :cards="otherNews" />
</template>

<script lang="ts">
import { inject, computed } from 'vue'

import { useRoute } from 'vue-router'
import { useNewsCards, type NewsCard } from 'icatt-heartcore'
import Cards from '@/components/Cards.vue'
import Spinner from '@/assets/spinner.svg'
import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'
import { formatDate } from '@/helpers/formatDate'
import Breadcrumbs from '@/components/Breadcrumbs.vue'

function mapNewsItem({
  summary, name, publishDate, url, image,
}: NewsCard) {
  return {
    body: summary,
    title: name,
    date: publishDate,
    subtitle: formatDate(publishDate),
    image,
    target: { url, name: 'Lees meer' },
  }
}

function upOneLevel(path: string) {
  const upperPath = path.replace(/\/$/, '').split('/')

  if (upperPath.length > 0) {
    upperPath.splice(upperPath.length - 1)
    return upperPath.join('/')
  }
  return path
}

const maxItems = 3

export default {
  components: {
    RichText, LazyImg, Cards, Spinner, Breadcrumbs,
  },

  setup() {
    const route = useRoute()
    const parentPath = computed(() => upOneLevel(route.path))
    const content = inject<any>('content')
    const parentId = computed(() => content.value?.parentId)
    const { currentPage, isLoading } = useNewsCards(parentId, {
      maxItems: maxItems + 1, // one more so we can exclude the current if necessary
    })

    const otherNews = computed(() => currentPage.value.filter(({ id }) => id !== content.value?._id).slice(0, maxItems).map(mapNewsItem))

    return {
      content,
      parentPath,
      isLoading,
      otherNews,
      date: computed(() => {
        const { publishDate, _createDate } = content.value ?? {}
        return formatDate(publishDate) || formatDate(_createDate)
      }),
    }
  },
}

</script>
