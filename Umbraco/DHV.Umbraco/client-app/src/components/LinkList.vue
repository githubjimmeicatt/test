<template>
  <h3
    v-if="title"
    class="row"
  >
    {{ title }}
  </h3>

  <ul
    v-if="links.length"
    class="row"
  >
    <li
      v-for="({ url, name }, i) in links"
      :key="i"
    >
      <router-link
        class="cta"
        :to="url"
      >
        {{ name }}
      </router-link>
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: null,
    },
    links: {
      type: Array,
      default: () => [],
    },
  },
}
</script>

<style lang="scss" scoped>
h3 {
  margin-top: var(--space-medium);
  font-variant: all-small-caps;
  margin-bottom: calc(-1 * var(--space-medium) + var(--space-small));
}

.row {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  gap: var(--space-small);
  padding: 0;
  margin-block: var(--space-small);
}
</style>
