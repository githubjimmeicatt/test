<template>
  <section class="narrow hasImage pageheader">
    <img class="background" :src="content.image.src + immageRequestSuffix" :alt="content.name">
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
    const imageSuffix = inject<any>('umbracoImageUrlMaxWidthSuffix')
    return {
      content,
      date: computed(() => {
        const { publishDate, _createDate } = content.value ?? {}
        return formatDate(publishDate) || formatDate(_createDate)
      }),
      immageRequestSuffix: imageSuffix.large,
    }
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

section {
  position: relative;
  aspect-ratio: 3/1;

  .background {

    position: absolute;
    inset: 0;
    inline-size: 100%;
    block-size: 100%;

  }

  &.narrow {
    @include screen-fits-two-cards {
      margin-inline: var(--dynamic-spacing-large);
      padding-inline: var(--space-small);
    }
  }
}
</style>
