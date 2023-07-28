<template>
  <section class="container topimage">
    <lazy-img
      v-if="content.headerImage"
      :src="content.headerImage.src"
    />
  </section>
  <breadcrumbs class="breadcrumbs" />

  <section class="container">
    <article>
      <h1>{{ content.name }}</h1>

      <rich-text :body="content.body" />

    </article>
  </section>

  <section class="newsletter">

    <news-letter-topic-card-dekkingsgraad :items="items.DekkingsgraadItems" />

    <news-letter-topic-cards :items="items.newsItems" />

  </section>

  <Spinner v-if="isLoading" class="spinner" />

  <Cards v-else title="Bekijk ook" :cards="otherNews" />
</template>

<script lang="ts">
import { inject, computed } from 'vue'

import { useRoute } from 'vue-router'
import { useUmbracoApi, useNewsCards, type NewsCard } from 'icatt-heartcore'
import Cards from '@/components/Cards.vue'
import Spinner from '@/assets/spinner.svg'
import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'
import NewsLetterTopicCards from '@/components/NewsLetterTopicCards.vue'
import NewsLetterTopicCardDekkingsgraad from '@/components/NewsLetterTopicCardDekkingsgraad.vue'
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
    RichText, LazyImg, Cards, Spinner, Breadcrumbs, NewsLetterTopicCards, NewsLetterTopicCardDekkingsgraad,
  },

  async setup() {
    const route = useRoute()
    const parentPath = computed(() => upOneLevel(route.path))
    const content = inject<any>('content')
    const parentId = computed(() => content.value?.parentId)
    const { currentPage, isLoading } = useNewsCards(parentId, {
      maxItems: maxItems + 1, // one more so we can exclude the current if necessary
    })

    const newsLetterQuery = `{
  allNewsLetterArticleDetailPage(
    where: {  
    url_contains: "${route.fullPath}"
    }) {
    items {
      id
      name
      url
      artikel
      samenvatting
      afbeelding {
        url
        cropUrl
      }
    }
    pageInfo {
      startCursor
      endCursor
      hasPreviousPage
      hasNextPage
    }
  }
}`

    const dekkingsgraadQuery = `{ 
  allNewsLetterDekkingsgraadDetailPage(
    where: {  
    url_contains: "${route.fullPath}"
    }) {
    items {
      id
      name
      url
      artikel
      samenvatting
      afbeelding {
        url
        cropUrl
      }
    }
    
    pageInfo {
      startCursor
      endCursor
      hasPreviousPage
      hasNextPage
    }
  }
}
`

    const api = useUmbracoApi()

    if (!api) {
      throw new Error('umbraco api not setup')
    }
    const newsJson = await api.postGraphQlQuery(newsLetterQuery)
    const dekkingsgraadJson = await api.postGraphQlQuery(dekkingsgraadQuery)

    const newsResult = newsJson.data?.allNewsLetterArticleDetailPage ?? {}
    const dekkingsgraadResult = dekkingsgraadJson.data?.allNewsLetterDekkingsgraadDetailPage ?? {}
    const combinedItems = {
      newsItems: [...(newsResult.items ?? [])],
      DekkingsgraadItems: [...(dekkingsgraadResult.items ?? [])],
    }
    const items = {
      newsItems: combinedItems.newsItems.map((item: any) => ({
        ...item,
      })),
      DekkingsgraadItems: combinedItems.DekkingsgraadItems.map((item: any) => ({
        ...item,
      })),
    }

    const otherNews = computed(() => currentPage.value.filter(({ id }) => id !== content.value?._id).slice(0, maxItems).map(mapNewsItem))

    return {
      content,
      parentPath,
      isLoading,
      otherNews,
      items,
      date: computed(() => {
        const { publishDate, _createDate } = content.value ?? {}
        return formatDate(publishDate) || formatDate(_createDate)
      }),
    }
  },
}

</script>

<style lang="scss" scoped>

.topimage {
  padding-block: 0;

  img {
    width: 100%;
    height: 20rem;
    object-fit: cover;
    object-position: center;
  }
}

.newsletter {
  background-color: var(--color-background-2);
  display: flex;
  flex-direction: column;
  padding: var(--space-medium) var(--dynamic-spacing-large);

}
.newsletter div {
  display: flex;
}

</style>
