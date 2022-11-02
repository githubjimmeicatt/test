<template>
  <slot
    name="query"
    :searchQuery="searchQuery"
  />
  <slot
    v-if="loading"
    name="loading"
  >
    <div
      class="spinner"
      role="spinner"
    >
      <div class="spinner-icon" />
    </div>
  </slot>
  <div
    v-else-if="searchResults.length"
    class="searchresultsContainer"
  >
    <ul

      class="searchresults"
    >
      <li
        v-for="(result, i) in searchResults"
        :key="i"
      >
        <slot
          name="results"
          :result="result"
        />
      </li>
    </ul>
  </div>
  <slot
    v-else
    name="noresults"
  >
    <div>Er zijn geen resultaten gevonden</div>
  </slot>
</template>

<script>
import {
  ref, watch, computed,
} from 'vue'
import { useRoute } from 'vue-router'
import { Portal } from '../api/umbraco'

export default {

  setup() {
    const response = ref({
      content: {
        items: [],
      },
    })

    const loading = ref(true)

    const searchResults = computed(() => {
      const items = response.value?.content?.items
      if (!Array.isArray(items)) return []
      return items.map((x) => ({
        ...x,
        _url: x.url,
        ...x.properties,
      }))
    })

    const route = useRoute()
    const searchQuery = computed(() => route.query.searchQuery)

    watch(searchQuery, async (val) => {
      try {
        if (val) {
          loading.value = true
          response.value = await Portal.search(val)
        }
      } finally {
        loading.value = false
      }
    }, { immediate: true })

    return {
      searchResults,
      searchQuery,
      loading,
    }
  },

}
</script>

<style lang="scss" scoped>
  ul{
    list-style: none;
    padding:0px;
  }
  .spinner {
  display: block;
  z-index: 1031;
  top: 15px;
  right: 15px;
  }

  .spinner-icon {
    width:30px;
    height:30px;
    box-sizing: border-box;

    border: solid 2px transparent;
    border-top-color: var(--color-accent-1);
      border-left-color: #FFBB00;
    border-radius: 50%;

    -webkit-animation: nprogress-spinner 400ms linear infinite;
            animation: nprogress-spinner 400ms linear infinite;
  }

@-webkit-keyframes nprogress-spinner {
  0%   { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}
@keyframes nprogress-spinner {
  0%   { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

</style>
