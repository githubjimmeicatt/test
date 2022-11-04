<template>
  <LatestNews :news-parent="newsParent" :title="title" />
</template>

<script>
import { computed, defineComponent, inject } from 'vue'

import LatestNews from '@/icatt-heartcore/components/LatestNews.vue'

export default defineComponent({
  components: { LatestNews },
  setup() {
    const content = inject('content')
    const newsParent = computed(() => ({
      _id: content.value?._id,
    }))
    const title = computed(() => content.value?.name)
    return {
      newsParent,
      title,
    }
  },
})
</script>
