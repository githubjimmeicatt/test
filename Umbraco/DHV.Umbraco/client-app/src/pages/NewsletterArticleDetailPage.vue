<template>
  <section class="container topimage">
    <lazy-img
      v-if="content.afbeelding"
      :src="content.afbeelding.src" />
  </section>
  <breadcrumbs class="breadcrumbs" />

  <section class="intro-container container">
    <article class="article-name">
      <h1>{{ content.name }}</h1>

      <p v-if="content.publishDate" class="article-date">
        {{ formatMonthYear(content.publishDate) }}
      </p>

      <rich-text :body="content.body" />
    </article>
  </section>

  <section class="articletext">

    <div v-html="content.artikel" />

  </section>
</template>

<script lang="ts">
import {
  inject, onMounted, ref, type Ref,
} from 'vue'
import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'
import { formatMonthYear } from '@/helpers/formatDate'
import Breadcrumbs from '@/components/Breadcrumbs.vue'
import { useRoute } from 'vue-router'
import { useUmbracoApi } from 'icatt-heartcore'

export default {
  components: {
    RichText, LazyImg, Breadcrumbs,
  },

  setup() {
    const content = inject <Ref<any>>('content')
    if (!content) {
      throw new Error('')
    }
    const route = useRoute()
    content.value.publishDate = ref<string | null>(null)

    onMounted(async () => {
      const getDateFromNewsletterQuery = `{
        allNewsLetterArticleDetailPage(
          where: {
            url_contains: "${route.fullPath}"
          }) {
          items {
            parent{
              ... on Newsletter {
                publishDate
              }
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

      const api = useUmbracoApi()

      if (!api) {
        throw new Error('Umbraco api not setup')
      }

      const json = await api.postGraphQlQuery(getDateFromNewsletterQuery)
      const result = json.data?.allNewsLetterArticleDetailPage?.items
      if (result && result.length > 0) {
      // Assign the publishDate to a reactive variable directly.
        content.value.publishDate = result[0].parent?.publishDate || null
      }
    })

    return {
      content,
      formatMonthYear,
    }
  },
}

</script>

<style scoped lang="scss">

    .articletext {
        padding: var(--space-medium) var(--dynamic-spacing-large);
    }

    ::v-deep.articletext > div p > img {
        max-width: 50em;
        width: 100%;
        object-fit: cover;
        object-position: center;
    }

    ::v-deep > p {
        max-width: 50em;
        line-height: 1.5em;
    }

    .topimage {
        padding-block: 0;

        img {
            width: 100%;
            height: 20rem;
            object-fit: cover;
            object-position: center;
        }
    }

    .article-name h1 {
        margin-bottom: 4px;
    }

    .article-date {
        margin-top: 0;
    }

    .intro-container {
        padding-bottom: 0;
    }
</style>
