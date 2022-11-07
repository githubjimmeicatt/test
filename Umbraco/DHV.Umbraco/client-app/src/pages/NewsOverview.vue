<template>
  <breadcrumbs class="breadcrumbs" />

  <LatestNews :news-parent="newsParent" :title="title" />
</template>

<script>
import { computed, defineComponent, inject } from 'vue'
import LatestNews from '@/components/LatestNews.vue'
import Breadcrumbs from '@/components/Breadcrumbs.vue'

export default defineComponent({
  components: { LatestNews, Breadcrumbs },
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
