<template>
  <section class="container">
    <search-results v-bind="$props">
      <template #query>
        <h2>{{ searchQuery }}</h2>
      </template>

      <template #results="{ result }">
        <div class="searchResultItem-Title">
          <router-link
            :to="getUrl(result)"
            class="search-link"
          >
            {{ getTitle(result) }}
          </router-link>
        </div>
      </template>
    </search-results>
  </section>
</template>

<script>

import SearchResults from '../components/SearchResults.vue'

export default {
  components: {
    SearchResults,
  },
  props: {
    searchQuery: {
      type: String,
      default: '',
    },
  },
  setup() {
    const getTitle = (page) => ((page?.header?.title) ? page.header.title : page.name)
    const getUrl = (page) => page._url

    return {
      getTitle, getUrl,
    }
  },

}
</script>
