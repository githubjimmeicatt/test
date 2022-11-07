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
        class="link"
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
@import "../assets/scss/_mixins.scss";

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
  margin-block: var(--space-medium);
}

.row > li {
  font-weight: 600;
  padding: var(--space-smaller) var(--space-small);
  background-color: var(--color-base);
  border-radius: 0.75rem;
}

.row .link {
  text-decoration: none;
  color: white;
}
</style>
