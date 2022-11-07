<template>
  <cards
    nr-of-columns="4"
    :title="title"
    :cards="employees"
  >
    <template #card="{ card }">
      <employee v-bind="card" />
    </template>
  </cards>
</template>

<script>
import Cards from './Cards.vue'
import Employee from './Employee.vue'

export default {
  components: { Cards, Employee },
  props: {
    title: {
      type: String,
      default: '',
    },
    employees: {
      type: Array,
      default: () => [],
    },
  },
  setup() {
    return {
    }
  },
}
</script>

<style lang="scss" scoped>
.container {
  background-color: white !important;
}

:deep(article) {
  padding: 0;
  box-shadow: none !important;
}

:deep(h1) {
  font-size: 1.25rem;
  margin-block-end: var(--space-small);
}
</style>
