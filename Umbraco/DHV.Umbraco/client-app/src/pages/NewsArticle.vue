<template>
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
</template>

<script>
import { inject, computed } from 'vue'
import { useRoute } from 'vue-router'
import RichText from '../components/RichText.vue'
import LazyImg from '../components/LazyImg.vue'

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

export default {
  components: { RichText, LazyImg },
  setup() {
    const route = useRoute()
    const parentPath = computed(() => upOneLevel(route.path))
    const content = inject('content')
    return {
      content,
      parentPath,
      date: computed(() => {
        const { publishDate, _createDate } = content.value
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
