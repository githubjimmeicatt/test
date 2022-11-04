<template>
  <breadcrumbs class="breadcrumbs" />
  <section class="container">
    <router-link :to="parentPath">
      🡨 Nieuws
    </router-link>
    <article class="richtext">
      <p v-if="date">
        {{ date }}
      </p>
      <h1>{{ content.name }}</h1>
      <lazy-img
        v-if="content.image"
        :src="content.image"
        class="topimage"
      />
      <rich-text :body="content.body" />
    </article>
  </section>
  <Spinner v-if="isLoading" />
  <Cards v-else title="Bekijk ook" :cards="otherNews" />
</template>

<script>
import { inject, computed } from 'vue'
import { useRoute } from 'vue-router'
import useNewsCards from '@/composables/useNewsCards'
import Cards from '@/components/Cards.vue'
import Spinner from '@/assets/spinner.svg'
import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'

function formatDate(date) {
  if (!date || date === '0001-01-01T00:00:00') return null
  return new Date(date).toLocaleDateString('nl-NL', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric',
  })
}

function upOneLevel(path) {
  const upperPath = path.replace(/\/$/, '').split('/')

  if (upperPath.length > 0) {
    upperPath.splice(upperPath.length - 1)
    return upperPath.join('/')
  }
  return path
}

const maxItems = 3

export default {
  components: {
    RichText, LazyImg, Cards, Spinner,
  },
  setup() {
    const route = useRoute()
    const parentPath = computed(() => upOneLevel(route.path))
    const content = inject('content')
    const parentId = computed(() => content.value?.parentId)
    const { currentPage, isLoading } = useNewsCards(parentId, {
      pageSize: maxItems + 1,
    })

    const otherNews = computed(() => currentPage.value.filter(({ id }) => id !== content.value?._id).slice(0, maxItems))

    return {
      content,
      parentPath,
      isLoading,
      otherNews,
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
  width: 100%;
  height: 20rem;
  margin-top: 2rem;
  margin-bottom: var(--space-small);
  object-fit: cover;
  object-position: center;
}
</style>
