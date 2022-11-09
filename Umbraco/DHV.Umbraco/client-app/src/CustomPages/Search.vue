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
            class="arrow-before search-link"
            active-class="is-active"
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

<style  lang="scss"  scoped>
.search-link {
  text-decoration: none;
  font-weight: 600;
  margin-top: auto;
  background: none;
  color: var(--color-base);
  padding: .5rem .75rem;
  display: inline-block;
  &::before {
    background-color: var(--color-accent-1);
  }
}
</style>
