<template>
  <section class="container topimage">
    <lazy-img
      v-if="content.image"
      :src="content.image.src"
    />
  </section>

  <breadcrumbs class="breadcrumbs" />

  <section class="container">
    <article>
      <h1>{{ content.name }}</h1>

      <p v-if="date" class="article-date">
        {{ date }}
      </p>

      <rich-text :body="content.body" />
    </article>
  </section>
</template>

<script lang="ts">
import { inject, computed } from 'vue'

import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'
import { formatDate } from '@/helpers/formatDate'
import Breadcrumbs from '@/components/Breadcrumbs.vue'

export default {
  components: {
    RichText, LazyImg, Breadcrumbs,
  },
  setup() {
    const content = inject<any>('content')

    return {
      content,
      date: computed(() => {
        const { publishDate, _createDate } = content.value ?? {}
        return formatDate(publishDate) || formatDate(_createDate)
      }),
    }
  },
}
</script>

<style lang="scss" scoped>

.topimage {
  padding-block: 0;

  img {
    width: 100%;
    height: 20rem;
    object-fit: cover;
    object-position: center;
  }
}

.article-date {
  text-transform: capitalize;
  margin-block-start: -1rem;
}

</style>
