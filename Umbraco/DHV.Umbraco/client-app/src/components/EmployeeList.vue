<template>
  <section class="container">
    <h1 v-if="title">{{ title }}</h1>
    <ul

    >
      <li v-for="(employee, index) in employees " :key="index">
        <employee v-bind="employee" />
      </li>
    </ul></section>
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
@import "../assets/scss/_mixins.scss";

ul{
 display: flex;
 flex-wrap: wrap;
 padding-left:0;
 margin-left:0;
 gap: var(--space-medium);
 justify-content: flex-start;
  @include mobile {
       justify-content: center;
      }
}

li{
list-style: none;
}

:deep(article) {
  padding: 0;
  box-shadow: none !important;
}

:deep(h1) {
  font-size: 1.25rem;
  margin-block-end: var(--space-small);
}

:deep(.article-inner) {
 padding: 0px !important;
}
</style>
