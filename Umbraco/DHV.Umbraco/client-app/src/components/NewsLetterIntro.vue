<template>
  <article class="newslettercards" v-for="item in items" :key="item.id">
    <div>
      <h2>{{ item.name }} </h2>
      <p class="date">{{ shortDate(item.publishDate) }}</p>
    </div>
    <p v-html="item.body" />
    <a :href="item.url"> Lees Meer ></a>
  </article>
</template>

<script lang="ts">

import { shortDate } from '@/helpers/formatDate'

export default {
  props: {
    items: {
      type: Array,
      default: () => [],
    },
  },
  setup() {
    return {
      shortDate,
    }
  },
}
</script>
