<template>
  <cards
    nr-of-columns="4"
    :title="title"
    :cards="employees"
  >
    <template #card="{card}">
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
