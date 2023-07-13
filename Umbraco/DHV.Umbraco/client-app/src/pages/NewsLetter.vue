<template>
  <section class="container topimage">
    <lazy-img
      v-if="content.image"
      :src="content.image"
    />
  </section>
  <breadcrumbs class="breadcrumbs" />

  <section class="container">
    <article>
      <h1>{{ content.name }}</h1>

      <p v-if="date" class="article-date">
        {{ date }}
      </p>

      <rich-text :body="content.body" />

      <a href="www.google.nl" class="cta"> Schrijf je in voor de nieuwsbrief</a>
    </article>
  </section>

  <section class="newsletters">
    <!-- article ipv div  -->
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

