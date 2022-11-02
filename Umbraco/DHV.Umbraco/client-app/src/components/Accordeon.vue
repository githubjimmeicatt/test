<template>
  <section
    v-if="accordeon?.length"
    class="container"
  >
    <h2 v-if="title">
      {{ title }}
    </h2>
    <ul>
      <li
        v-for="(item, index) in accordeon"
        :key="index"
      >
        <card class="richtext">
          <details>
            <summary class="arrow-after">
              {{ item.title }}
            </summary>
            <rich-text :body="item.text" />
          </details>
        </card>
      </li>
    </ul>
  </section>
</template>

<script>
import Card from './Card.vue'
import RichText from './RichText.vue'

export default {
  components: { Card, RichText },
  props: {
    accordeon: {
      type: Array,
      default: () => [],
    },
    title: {
      type: String,
      default: '',
    },
  },
  setup() {
  },
}
</script>

<style lang="scss" scoped>
section.container {
  background-color: var(--color-background-2);
}

ul {
  display: flex;
  flex-direction: column;
  gap: var(--space-small);
  margin: 0;
  padding: 0;
}

li {
  display: block;
}

details > summary {
  list-style-type: none;
  cursor: pointer;
  font-weight: bold;
  position: relative;
  display: flex;
  color: var(--color-base);

  &::-webkit-details-marker {
    display: none;
  }

  &.arrow-after::after {
    margin-left: auto;
    font-weight: 600;
    transition: transform 0.25s ease-in-out;
    background-color: var(--color-base);
  }
}

details[open] > summary {
  &::after {
    transform: rotate(90deg);
  }
  ~ div {
    animation: sweep .25s ease-in-out;
  }
}

@keyframes sweep {
  0%    {opacity: 0; max-height: 0;}
  100%  {opacity: 1; max-height: 100%;}
}
</style>
