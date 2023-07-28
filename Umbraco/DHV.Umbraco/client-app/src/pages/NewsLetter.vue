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

    <newsletter-topic-cards-dekkingsgraad :items="items.DekkingsgraadItems" />

    <newsletter-topic-cards :items="items.newsItems" />

  </section>

</template>

<script lang="ts">
import { inject } from 'vue'

import { useRoute } from 'vue-router'
import { useUmbracoApi } from 'icatt-heartcore'
import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'
import NewsletterTopicCards from '@/components/NewsletterTopicCards.vue'
import NewsletterTopicCardsDekkingsgraad from '@/components/NewsletterTopicCardsDekkingsgraad.vue'
import Breadcrumbs from '@/components/Breadcrumbs.vue'

export default {
  components: {
    RichText, LazyImg, Breadcrumbs, NewsletterTopicCards, NewsletterTopicCardsDekkingsgraad,
  },

  async setup() {
    const route = useRoute()
    const content = inject<any>('content')

    const newsletterQuery = `{
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
    const newsJson = await api.postGraphQlQuery(newsletterQuery)
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

    return {
      content,
      items,

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
