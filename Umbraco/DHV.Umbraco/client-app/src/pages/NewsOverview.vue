<template>
  <NewsOverview v-bind="content" />
</template>

<script>
import { defineComponent, inject } from 'vue'
import NewsOverview from '../components/NewsOverview.vue'

export default defineComponent({
  components: { NewsOverview },
  setup() {
    const content = inject('content')
    return {
      content,
    }
  },
})
</script>
