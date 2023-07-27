<template>
  <article class="newsLetterTopicCard" v-for="item in items" :key="item.id">
    <div>
      <h2>{{ item.name }}</h2>
    </div>
    <div v-html="item.samenvatting" />
    <a :href="item.url"> Lees meer > </a>
    <img class="dekkingsgraadtabel" :src="item.afbeelding.url" />

  </article>
</template>

<script lang="ts">
import Cards from '@/components/Cards.vue'
import Spinner from '@/assets/spinner.svg'
import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'
import Breadcrumbs from '@/components/Breadcrumbs.vue'

export default {
  components: {
    RichText, LazyImg, Cards, Spinner, Breadcrumbs,
  },
  props: {
    items: {
      type: Array,
      default: () => [],
    },
  },
}
</script>
<style lang="scss" scoped>

.newsLetterTopicCard {
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

::v-deep .newsLetterTopicCard img {
    max-width: 100%;
    max-height: 100%;
}

.dekkingsgraadtabel {
    max-height: 100%;
    max-width: 100%;
    padding-top: 1.5em
}

</style>
