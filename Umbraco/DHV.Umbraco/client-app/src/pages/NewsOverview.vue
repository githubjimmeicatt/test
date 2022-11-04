<template>
  <LatestNews :news-parent="newsParent" />
</template>

<script>
import { computed, defineComponent, inject } from 'vue'

import LatestNews from '../components/LatestNews.vue'

export default defineComponent({
  components: { LatestNews },
  setup() {
    const content = inject('content')
    const newsParent = computed(() => ({
      _id: content._id,
    }))
    return {
      newsParent,
    }
  },
})
</script>
