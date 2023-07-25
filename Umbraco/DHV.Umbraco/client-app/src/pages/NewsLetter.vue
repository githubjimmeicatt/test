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
    <article class="dekkingsgraad">
      <div>
        <h2>Dekkingsgraad</h2>
      </div>

      <h4>Dekkingsgraad eind februari gestegen naar 131,8%</h4>
      <p>Sinds eind januari 2023 zagen we de actuele dekkingsgraad fors stijgen. Van 126,5% naar 131,8% eind februari. Deze stijging is voor een klein deel te danken aan de toename van de waarde van onze beleggingen,
        maar vooral aan de stijging van de rente. We voorzien echter dat de dekkingsgraad eind maart weer gedaald zal zijn. De lange termijn rente fluctueert nogal en ook op de beurzen zien we deze maand een dalende lijn.
        Per 1 april 2023 daalt de dekkingsgraad nog eens met ongeveer 8% vanwege de indexatie van de pensioenaanspraken en pensioenen per 1 april 2023.</p>
      <a href="www.google.nl"> Lees meer </a>
      <img class="dekkingsgraadtabel" src="https://media.umbraco.io/dev-pensioenfonds-haskoningdhv/nbmnubc4/dekkingsgraad.jpg" />

    </article>

    <article class="newslettercard">

      <div class="newslettercontent">
        <div>
          <h2>Nieuwsbrief artikel 2</h2>
        </div>
        <div class="image-and-paragraph">
          <img class="test-img" src="https://media.umbraco.io/dev-pensioenfonds-haskoningdhv/vdhnpzk3/winkelkarretje.jpg" />
          <p>Dit is een samenvatting van dit nieuwsbrief artikel. Deze wordt op artikelniveau geschreven, maar moet 1 niveau hoger zichtbaar worden.</p>
        </div>
        <a href="www.google.nl"> Lees meer </a>
      </div>
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

    console.log(content, useNewsCards(parentId))

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

.test-img {
  max-width: 100%;
  max-height: 100%;
}

.iamge-and-paragraph {
  display: flex;
  flex-direction: row;
  align-items: center;
}

.newsletter {
  background-color: var(--color-background-2);
  display: flex;
  flex-direction: column;
  padding: var(--space-medium) var(--dynamic-spacing-large);

}

.dekkingsgraad {

  background-color: var(--card-background-color, white);
  padding: 1.5rem;
  min-width: 200px;
  max-width: var(--max-text-width);
  margin-bottom: var(--space-small);
  margin-bottom: var(--space-small);
  border-radius: 0px 0px 12px 12px;
  border-left-style: solid;
  border-color: var(--color-sph-accent-1);
  border-left-width: 6px;

}

.newslettercard {

  background-color: var(--card-background-color, white);
  padding: 1.5rem;
  min-width: 420px;
  max-width: var(--max-text-width);
  margin-bottom: var(--space-small);
  margin-bottom: var(--space-small);
  border-radius: 0px 0px 12px 12px;
  display: flex;
  border-left-style: solid;
  border-color: var(--color-sph-accent-1);
  border-left-width: 6px;

}

.newsletter div {
  display: flex;
}

.newslettercontent {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
}

  .newsletters div h2 {

    margin:0px;
  }

  div h2 {

  }

  .newslettercard img {
    display: inline;
  }
</style>
