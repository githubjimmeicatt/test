<template>
  <section class="container cards">
    <h1 v-if="content.name">
      {{ content.name }}
    </h1>
    <ol class="cards">
      <li
        v-for="(card, key) in currentPage"
        :key="key"
      >
        <card v-bind="card" />
      </li>
    </ol>
    <Spinner v-if="isLoading" />
    <button
      v-else-if="hasNextPage"
      type="button"
      @click="getNextPage"
    >
      Meer laden
    </button>
  </section>
</template>

<script>
import {
  computed, inject,
} from 'vue'

import useNewsCards from '../composables/useNewsCards'
import Card from './Card.vue'
import Spinner from '../assets/spinner.svg'

export default {
  components: { Card, Spinner },
  setup() {
    const content = inject('content')
    const id = computed(() => content.value?._id)
    const {
      currentPage, hasNextPage, getNextPage, isLoading,
    } = useNewsCards(id)

    return {
      currentPage,
      hasNextPage,
      isLoading,
      getNextPage,
      content,
      id,
    }
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";
a {
  text-decoration: none;
}

ol {
  margin: 0;
  padding: 0;
  > li {
    display: block;
  }
}

ol.cards {
  display: inline-grid;
  gap: var(--space-medium);
  grid-template-columns: 1fr;
  justify-content: center;
  align-content: start;
  width: 100%;

  @include screen-fits-two-cards {
    grid-template-columns: repeat(2, var(--card-width-large));
  }

  @include screen-fits-three-cards {
    grid-template-columns: repeat(3, var(--card-width));
  }
}

nav > ol {
  margin-top: 2rem;
  display: flex;
  flex-direction: row;
  gap: var(--space-small);

  a:hover {
    text-decoration: underline;
  }
}
</style>
