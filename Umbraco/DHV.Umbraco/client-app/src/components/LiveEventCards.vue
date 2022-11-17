<template>
  <section>
    <h1 v-if="title">
      {{ title }}
    </h1>

    <ul
      v-if="cards?.length"
      :class="[{ 3: 'three', 4: 'four', 5: 'five' }[Number(columnCount)]]"
    >
      <li
        v-for="(card, i) in cards"
        :key="i"
      >
        <the-link
          :href="card.text?.url || '#'"
          data-gtm-button-type="cta"
        >
          <img
            v-if="card.icon?.src"
            :src="card.icon.src"
            :alt="card.text?.name"
          >

          <span v-if="card.text?.name">{{ card.text.name }} &gt;</span>
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
  display: grid;
  row-gap: var(--space-smaller);

  @include reset-list;

  @include screen-fits-two-cards {
    grid-template-columns: repeat(2, 1fr);
  }

  @include screen-fits-four-cards {
    &.three {
      grid-template-columns: repeat(3, 1fr);
    }

    &.four {
      grid-template-columns: repeat(4, 1fr);
    }

    &.five {
      grid-template-columns: repeat(5, 1fr);
    }
  }
}

li {
  background-color: var(--color-accent-1);
  border-radius: 1rem;

  a {
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100%;
    padding-inline: var(--space-smaller);
    padding-block-start: var(--space-medium);
    padding-block-end: var(--space-small);

    color: white;
    font-weight: 600;
    text-decoration: none;
    outline-offset: -1px;

    &:hover,
    &:active,
    &:focus {
      text-decoration: underline;
    }

    img {
      margin: auto;
      min-width: 2rem;
    }

    span {
      margin-block-start: 1rem;
    }
  }
}
</style>
