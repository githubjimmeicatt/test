<template>
  <section>
    <h1 v-if="title">
      {{ title }}
    </h1>

    <ul v-if="cards?.length">
      <li
        v-for="(card, i) in cards"
        :key="i"
      >
        <the-link
          :href="card.text.url || '#'"
          data-gtm-button-type="cta"
        >
          <img :src="card.icon.src">

          <span>{{ card.text.name }} &gt;</span>
        </the-link>
      </li>
    </ul>
  </section>
</template>

<script>
import TheLink from './TheLink.vue'

export default {
  components: { TheLink },
  props: {
    cards: {
      type: Array,
      default: () => [],
    },
    title: {
      type: String,
      default: '',
    },
    columnCount: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

ul {
  list-style: none;
  margin: 0;
  padding: 0;

  @include screen-fits-two-cards {
    display: flex;
  }
}

li {
  flex: 1;
  margin-block: var(--space-smaller);
  background-color: var(--color-accent-1);
  border-radius: 1rem;

  a {
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100%;
    padding: var(--space-small);
    padding-block-start: var(--space-medium);

    color: white;
    text-decoration: none;

    &:hover {
      text-decoration: underline;
    }

    img {
      margin: auto;
    }

    span {
      margin-block-start: 1rem;
    }
  }
}
</style>
