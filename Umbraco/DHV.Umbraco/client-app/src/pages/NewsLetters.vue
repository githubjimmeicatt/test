<template>
  <breadcrumbs class="breadcrumbs" />

  <pre>{{ items }}</pre>

  <section class="container">
    <article>
      <h1>{{ content.name }}</h1>

      <rich-text :body="content.body" />

      <a href="www.google.nl" class="cta"> Schrijf je in voor de nieuwsbrief</a>
    </article>
  </section>

  <section class="newsletters">
    <!-- article ipv div  -->
    <NewsLetterIntro v-bind="content.NewsLetterIntro" />

    <article class="newslettercards">
      <div>
        <h2>Nieuwsbrief 2 - Maart 2023 </h2>
        <p class="date">01-03-2023</p>
      </div>

      <p>Een kleine intro over de nieuwsbrief van deze maand. Deze tekst maak ik wat langer om te kijken wat er gebeurt met de paragraaf. (werkt naar behoren)</p>
      <a href="www.google.nl"> Lees meer </a>
    </article>

    <article class="newslettercards">
      <div>
        <h2>Nieuwsbrief 1 - februari 2023 </h2>
        <p class="date">01-02-2023</p>
      </div>
      <p>Een kleine intro over de nieuwsbrief van deze maand.</p>
      <a href="www.google.nl"> Lees meer </a>
    </article>

    <article class="newslettercards">
      <div>
        <h2>Nieuwsbrief 0 - januari 2023 </h2>
        <p class="date">01-01-2023</p>
      </div>

      <p>Een kleine intro over de nieuwsbrief van deze maand.</p>
      <a href="www.google.nl"> Lees meer </a>
    </article>

    <article class="newslettercards">
      <div>
        <h2>Nieuwsbrief 12 - december 2022 </h2>
        <p class="date">01-12-2022</p>
      </div>
      <p>Een kleine intro over de nieuwsbrief van deze maand.</p>
      <a href="www.google.nl"> Lees meer </a>
    </article>

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
import LazyImg from '@/components/LazyImg.vue'
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
    RichText, LazyImg, Cards, Spinner, Breadcrumbs, NewsLetterIntro,
  },

  async setup() {
    const route = useRoute()
    const parentPath = computed(() => upOneLevel(route.path))
    const content = inject<any>('content')
    const parentId = computed(() => content.value?.parentId)
    const { currentPage, isLoading } = useNewsCards(parentId, {
      maxItems: maxItems + 1, // one more so we can exclude the current if necessary
    })

    /// ////////////////////////////////////////////
    const des = ref({})
    // loading.value = true
    // content.value = null
    // try {

    const q = `{
  allNewsletter(
 orderBy: [publishDate_DESC], 
    first: 15
    where: { 
   
url_starts_with: "/pensioenfonds-haskoningdhv/nieuwsbrieven/"  }
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

    const json = await api.postGraphQlQuery(q)

    const result = json.data?.allNewsletter ?? {}

    const { pageInfo } = result

    const items = (result.items ?? []).map((item: any) => {
      const {
        updateDate, publishDate, createDate, image,
      } = item
      return {
        ...item,
      // publishDate: parseUmbracoDate(publishDate),
      // updateDate: parseUmbracoDate(updateDate),
      // createDate: parseUmbracoDate(createDate),
      // image: {
      //   ...image,
      //   // for backwards compatibility
      //   umbracoFile: {
      //     ...image,
      //   },
      // },
      }
    })

    const alvastdequeryvoordenieuwsbrief = `{
  allNewsLetterArticleDetailPage(
 
    first: 15
    where: { 
   
url_starts_with: "/pensioenfonds-haskoningdhv/nieuwsbrieven/nieuwsbrief-1-januari-2023/"  }
  ) {
    items {
      id
      name
      url
  
 artikel
       
     
    }
    pageInfo {
      startCursor
      endCursor
      hasPreviousPage
      hasNextPage
    }
  }
}`

    //   const umbracoApi = useUmbracoApi()
    //   if (umbracoApi) {
    //     const { data: result } = await umbracoApi.url(content._links.descendants)
    //     // if (result?.redirect?._url) {
    //     //  window.UMBRACO_INITIAL_STATE = result.redirect
    //     //  router.push(result.redirect._url)
    //     //  return
    //     // }
    //     des.value = result
    //   }
    // } catch (error) {
    // //  errorCode.value = error
    // } finally {
    // //  loading.value = false
    // }

    /// ////////////////////////////////////////////

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
      des,
    }
  },
}

</script>

<style>

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

  div h2 {

  }
</style>
