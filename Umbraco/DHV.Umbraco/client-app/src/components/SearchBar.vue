<template>
  <section>
    <label
      id="searchLabel"
      class="screen-reader-only"
    >zoekterm</label>
    <input
      ref="searchInput"
      v-model="searchText"
      type="text"
      placeholder="Waar ben je naar op zoek?"
      aria-labelledby="searchLabel"
      @keydown.enter="navigateToSearch"
    >
    <router-link
      :to="searchLink"
      class="cta"
      data-gtm-button-type="cta"
      @click="navigateToSearch"
    >
      Zoeken
    </router-link>
    <slot />
  </section>
</template>

<script>
import { computed, ref } from 'vue'
import { useRouter } from 'vue-router'

export default {
  setup() {
    const router = useRouter()
    const searchText = ref('')
    const searchInput = ref(null)
    const searchLink = computed(() => ({
      name: 'Search',
      params: {
        searchQuery: searchText.value,
      },
    }))
    return {
      searchText,
      searchInput,
      searchLink,
      navigateToSearch() {
        router.push(searchLink.value)
      },
      focus() {
        const { value } = searchInput
        if (value?.focus) {
          value.focus()
        }
      },
    }
  },
}
</script>

<style lang="scss" scoped>
section {
  display: flex;
  background-color: var(--color-accent-1);
  align-items: center;

  input {
    flex: 1;
    border: none;
    box-sizing: content-box;
    border-radius: 1rem;
    padding: 0.75rem 1.5rem;
    margin-right: var(--space-small);

    &:focus {
      outline: none !important;
      border:2px solid black;
    }
  }
  a.cta{
    display: block;
    margin-top: 0;
  }
}
</style>
