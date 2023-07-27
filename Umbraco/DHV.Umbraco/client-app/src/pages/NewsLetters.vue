<template>
  <section class="breadcrumbsSection">
    <breadcrumbs class="breadcrumbs" />
  </section>

  <section class="container newsContainer">
    <article>
      <h1>{{ content.name }}</h1>

      <rich-text :body="content.body" />

      <a href="www.google.nl" class="cta"> Schrijf je in voor de nieuwsbrief</a>
    </article>
  </section>

  <section class="newsletters">
    <news-letter-intro :items="items" />
  </section>

  <Spinner v-if="isLoading" class="spinner" />

  <Cards v-else title="Bekijk ook" :cards="otherNews" />
</template>

<script lang="ts">
import { inject, computed, ref } from 'vue'

import { useRoute } from 'vue-router'
import { useNewsCards, type NewsCard, useUmbracoApi } from 'icatt-heartcore'
import Cards from '@/components/Cards.vue'
import Spinner from '@/assets/spinner.svg'
import RichText from '@/components/RichText.vue'
import { formatDate } from '@/helpers/formatDate'
import Breadcrumbs from '@/components/Breadcrumbs.vue'
import NewsLetterIntro from '@/components/NewsLetterIntro.vue'

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
    RichText, Cards, Spinner, Breadcrumbs, NewsLetterIntro,
  },

  async setup() {
    const route = useRoute()
    const parentPath = computed(() => upOneLevel(route.path))
    const content = inject<any>('content')
    const parentId = computed(() => content.value?.parentId)
    const { currentPage, isLoading } = useNewsCards(parentId, {
      maxItems: maxItems + 1, // one more so we can exclude the current if necessary
    })

    const des = ref({})

    const q = `{
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
       items
      {
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
    const json = await api.postGraphQlQuery(q)

    const result = json.data?.allNewsletter ?? {}

    const items = (result.items ?? []).map((item: any) => {
      const {
        updateDate, publishDate, createDate, image,
      } = item
      return {
        ...item,
      }
    })

    console.log(items)

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
      des,
    }
  },
}

</script>

<style lang="scss">

.breadcrumbsSection {
  padding-top: 32px;
}

.newsletters {
  background-color: var(--color-background-2);
  display: flex;
  flex-direction: column;
  padding: var(--space-medium) var(--dynamic-spacing-large);

}

.newslettercards {
  background-color: var(--card-background-color, white);
  padding: 1.5rem;
  min-width: 200px;
  max-width: var(--max-text-width);
  margin-bottom: var(--space-small);
  margin-bottom: var(--space-small);
  border-radius: 0px 0px 12px 12px;
}

.newsletters div {
  display: flex;     justify-content: space-between;
    align-items: center;
      flex-wrap: wrap;

}

.newsletters div h2, .newsletters div p {
  margin:0px;
}

.newsContainer {
  padding-bottom: 5em;
}
</style>
