<template>

  <section class="container topimage pageheader">

    <img
      class="background"
      v-if="content.afbeelding"
      :src="content.afbeelding.src + immageRequestSuffix"
      :alt="content.name" />
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
  inject, onMounted, type Ref,
} from 'vue'
import { useRoute } from 'vue-router'
import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'
import { formatMonthYear } from '@/helpers/formatDate'
import Breadcrumbs from '@/components/Breadcrumbs.vue'
import { useUmbracoApi } from 'icatt-heartcore'

export default {

  components: {
    RichText, LazyImg, Breadcrumbs,
  },

  setup() {
    const content = inject <Ref<any>>('content')
    const imageSuffix = inject<any>('umbracoImageUrlMaxWidthSuffix')
    if (!content) {
      throw new Error('')
    }
    const route = useRoute()

    const api = useUmbracoApi()

    if (!api) {
      throw new Error('Umbraco api not setup')
    }

    onMounted(async () => {
      const getDekkingsGraadDateFromNewsletterQuery = `{
        allNewsLetterDekkingsgraadDetailPage(
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

      const json = await api.postGraphQlQuery(getDekkingsGraadDateFromNewsletterQuery)
      const result = json.data?.allNewsLetterDekkingsgraadDetailPage?.items
      if (result && result.length > 0) {
      // Assign the publishDate to a reactive variable directly.
        content.value.publishDate = result[0].parent?.publishDate || null
      }
    })

    return {
      content,
      formatMonthYear,
      immageRequestSuffix: imageSuffix.large,
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
