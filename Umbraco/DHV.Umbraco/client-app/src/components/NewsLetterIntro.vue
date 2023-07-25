<template>
  <article class="newslettercards">
    <div>
      <h2>{{ titel }} </h2>
      <p class="date">{{ datum }}</p>
    </div>
    <p>{{ inleiding }}</p>
    <a :href="target"> {{ target }} </a>
  </article>
</template>

<script lang="ts">
import { inject, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useNewsCards, type NewsCard } from 'icatt-heartcore'
import Cards from '@/components/Cards.vue'
import Spinner from '@/assets/spinner.svg'
import RichText from '@/components/RichText.vue'
import LazyImg from '@/components/LazyImg.vue'
import { formatDate } from '@/helpers/formatDate'
import Breadcrumbs from '@/components/Breadcrumbs.vue'

function upOneLevel(path: string) {
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
    RichText, LazyImg, Cards, Spinner, Breadcrumbs,
  },
  props: {
    titel: {
      type: String,
      default: '',
    },
    inleiding: {
      type: String,
      default: '',
    },
    datum: {
      type: Date,
      // default() { return new Date() },
      default: '',
    },

  },
  setup() {
    const route = useRoute()
    const parentPath = computed(() => upOneLevel(route.path))
    const content = inject<any>('content')
    const parentId = computed(() => content.value?.parentId)
    const { currentPage, isLoading } = useNewsCards(parentId, {
      maxItems: maxItems + 1, // one more so we can exclude the current if necessary
    })
    function mapNewsItem({
      summary, name, publishDate, url, image,
    }: NewsCard) {
      return {
        body: summary,
        title: name,
        date: publishDate,
        subtitle: formatDate(publishDate),
        target: { url, name: 'Lees meer' },
        image,
        hasNextPage,
        getNextPage,
      }
    }
    const otherNews = computed(() => currentPage.value.filter(({ id }) => id !== content.value?._id).slice(0, maxItems).map(mapNewsItem))

    console.log(content, parentPath, route, otherNews)
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
