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

          <span v-if="card.text?.name">{{ card.text.name }}</span>
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
  column-gap: var(--space-medium);
  row-gap: var(--space-small);

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
    align-items: center;
    height: 100%;
    padding-inline: var(--space-small);
    padding-block: var(--space-small);
    gap: var(--space-smaller);

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
      inline-size: 1rem;
    }

    &::after {
      content: '>';
      margin-inline-start: auto;
    }
  }
}
</style>
