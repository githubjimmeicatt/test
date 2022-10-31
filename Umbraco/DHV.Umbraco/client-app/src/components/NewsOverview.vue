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
    <nav v-if="pagination?.length > 1">
      <ol
        role="navigation"
      >
        <li
          v-for="({pageNumber, to, isCurrent}, key) in pagination"
          :key="key"
          :aria-current="isCurrent"
        >
          <strong v-if="isCurrent">{{ pageNumber }}</strong>
          <router-link
            v-else
            :to="to"
          >
            {{ pageNumber }}
          </router-link>
        </li>
      </ol>
    </nav>
  </section>
</template>

<script>
import {
  computed, inject,
} from 'vue'

import usePagination from '../composables/usePagination'
import useNewsCards from '../composables/useNewsCards'
import Card from './Card.vue'

export default {
  components: { Card },
  setup() {
    const params = {
      pageNumber: '1',
      pageSize: '100', // voor nu hoog zetten, paginering gebeurd nu nog volledig op de client, geen nieuwe server callbacks
    }
    const content = inject('content')
    const id = computed(() => content.value?._id)
    const articles = useNewsCards(id, params)
    const { currentPage, pagination } = usePagination(articles)

    return {
      currentPage,
      pagination,
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
