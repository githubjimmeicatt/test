<template>
  <section>
    <h1 v-if="Title">
      {{ Title }}
    </h1>

    <ul v-if="Card?.length">
      <li
        v-for="(x, i) in Card"
        :key="i"
        v-bind="x"
      >
        <img
          :src="x.icon.src"
          height="50"
        >
        <the-link
          :href="x.text.url || '#'"
          target="_blank"
          data-gtm-button-type="cta"
        >
          <span>{{ x.text.name }}</span>
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
    Card: {
      type: Array,
      default: () => [],
    },
    Title: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
ul {
  display: grid;
  grid: auto / repeat(5, 1fr);
  margin: 0;
  padding: 0;
}

li {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: var(--space-medium);
  background-color: var(--color-accent-1);
  border-radius: 1rem;
}
</style>
