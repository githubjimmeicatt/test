<template>
  <section class="breadcrumbsSection">
    <breadcrumbs class="breadcrumbs" />
  </section>

  <section class="container newsContainer">
    <article>
      <h1>{{ content.name }}</h1>

      <rich-text :body="content.body" />
      <!-- moet later weer aangezet worden -->
      <!-- <a :href="content.callToAction.url" class="cta"> {{ content.callToAction.name }}</a> -->
    </article>
  </section>

  <section class="newsletters">
    <newsletter-intro :items="items" />
  </section>

</template>

<script lang="ts">
import { inject, ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { useUmbracoApi } from 'icatt-heartcore'
import RichText from '@/components/RichText.vue'
import Breadcrumbs from '@/components/Breadcrumbs.vue'
import NewsletterIntro from '@/components/NewsletterIntro.vue'

export default {
  components: {
    RichText, Breadcrumbs, NewsletterIntro,
  },

  setup() {
    const route = useRoute()
    const content = inject<any>('content')
    const items = ref<any[]>([])

    onMounted(async () => {
      const newsLetterQuery = `{
        allNewsletter(
          orderBy: [publishDate_DESC],
          where: { url_contains: "${route.fullPath}" }
        ) {
          items {
            id
            name
            url
            publishDate
            body
            headerImage {
              url
              ... on MediaWithCrops {
                focalPoint {
                  left
                  top
                }
                focalPointUrlTemplate
              }
            }
            children {
              items {
                ... on NewsLetterArticleDetailPage {
                  id
                  url
                  samenvatting
                }
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
        throw new Error('umbraco api not setup')
      }

      const json = await api.postGraphQlQuery(newsLetterQuery)
      const result = json.data?.allNewsletter ?? {}
      items.value = (result.items ?? []).map((item: any) => ({ ...item }))
    })

    return {
      content,
      items,
    }
  },
}

</script>

<style lang="scss" scoped>

    .breadcrumbsSection {
        padding-top: 32px;
    }

    .newsletters {
        background-color: var(--color-background-2);
        display: flex;
        flex-direction: column;
        padding: var(--space-medium) var(--dynamic-spacing-large);
    }

    .newsContainer {
        padding-bottom: 5em;
    }
</style>
