<template>
  <slot
    name="query"
  />
  <slot
    v-if="loading"
    name="loading"
  >
    <div
      class="spinner"
    >
      <div class="spinner-icon" />
    </div>
  </slot>
  <div
    v-else-if="searchResults.length"
    class="searchresultsContainer"
  >
    <ul class="searchresults">
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
import { Portal } from '@/icatt-heartcore/api/umbraco'

export default {
  props: {
    searchQuery: {
      type: String,
      default: '',
    },
  },
  setup(props) {
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

    watch(() => props.searchQuery, async (val) => {
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
      loading,
    }
  },

}
</script>

<style lang="scss" scoped>
  ul {
    list-style: none;
    padding: 0;

    li {
      display: flex;
      margin-block: var(--space-smaller);

      &::before {
        content: ">";
        margin-inline-end: var(--space-smaller);
      }
    }
  }

  .spinner {
    display: block;
    z-index: 1031;
    top: 15px;
    right: 15px;
  }

  .spinner-icon {
    width: 2rem;
    height: 2rem;
    box-sizing: border-box;

    border: solid 2px transparent;
    border-top-color: var(--color-base);
    border-left-color: var(--color-accent-1);
    border-bottom-color: var(--color-accent-2);
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
