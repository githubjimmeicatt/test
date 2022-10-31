<template>
  <section
    v-if="spotlightItems?.length"
    :class="{[orientation]: orientation}"
  >
    <article
      v-for="(item, index) in spotlightItems"
      :key="index"
      class="richtext"
    >
      <h1>{{ item.title }}</h1>
      <rich-text :body="item.body" />
      <the-link
        v-if="item.target"
        class="cta"
        data-gtm-button-type="cta"
        :href="item.target.url || '#'"
        :target="item.target.target"
      >
        {{ item.target.name }}
      </the-link>
    </article>
  </section>
</template>

<script>
import RichText from './RichText.vue'
import TheLink from './TheLink.vue'

export default {
  components: { TheLink, RichText },
  props: {
    contentTypeAlias: {
      type: String,
      default: '',
    },
    orientation: {
      type: String,
      default: 'horizontal',
    },
    spotlightItems: {
      type: Array,
      default: () => [],
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";
section {
  display: inline-grid;
  gap: var(--space-medium);
  grid-template-columns: 1fr;
  padding: 5rem var(--dynamic-spacing-medium);
  justify-content: center;
  align-content: start;
  width: 100%;

  @include screen-fits-three-cards {
    &.horizontal {
      grid-template-columns: repeat(3, var(--card-width));
    }
  }
}
</style>
