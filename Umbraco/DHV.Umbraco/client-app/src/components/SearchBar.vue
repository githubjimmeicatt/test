<template>
  <section>
    <fieldset>
      <label
        for="searchLabel"
        class="screen-reader-only"
      >Zoekterm</label>

      <input
        ref="searchInput"
        v-model="searchText"
        type="text"
        placeholder="Waar ben je naar op zoek?"
        id="searchLabel"
        @keydown.enter="navigateToSearch"
      >

      <router-link
        :to="searchLink"
        data-gtm-button-type="cta"
        class="cta-search"
        @click="navigateToSearch"
      >
        <SearchIcon />

        <span class="screen-reader-only">Zoeken</span>
      </router-link>
    </fieldset>

    <the-link
      href="https://mijn.pensioenfondshaskoningdhv.nl"
      class="cta cta-inverse"
    >
      Mijn pensioen
    </the-link>

    <slot />
  </section>
</template>

<script>
import { computed, ref } from 'vue'
import { useRouter } from 'vue-router'
import SearchIcon from '../assets/search.svg'
import TheLink from './TheLink.vue'

export default {
  components: {
    SearchIcon,
    TheLink,
  },
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
@import "../assets/scss/_mixins.scss";

section {
  --item-width: 36rem;

  display: flex;
  background-color: var(--color-accent-1);
  justify-content: flex-end;
  align-items: center;
  row-gap: var(--space-small);

  fieldset {
    display: flex;
    align-items: center;
    width: min(100%, var(--item-width));
    padding: 0;
    margin-inline: auto;
    border: none;

    padding-inline-end: 0.5rem;

    input {
      flex: 1;
      border: none;
      border-radius: 1rem;
      padding-block: 0.75rem;
      padding-inline: 1.5rem 3rem;

      &:focus {
        outline: none !important;
        border: 2px solid black;
      }
    }
    a.cta-search {
      display: block;
      width: 2rem;
      height: 2rem;
      margin-inline-start: -2.5rem;
    }
  }

  a.cta-inverse {
    display: flex;
    justify-content: center;
    align-items: center;
    color: var(--color-base);
    white-space: nowrap;
    background-color: white;
    margin-block-start: 0;

    width: min(100%, var(--item-width));
    margin-inline: auto;

    @include screen-fits-two-cards {
      width: auto;
      margin-inline: 0;
    }

    &:hover {
      text-decoration: underline;
    }

    &::before {
      content: "";
      mask: url(../assets/user.svg) center / cover;
      -webkit-mask: url(../assets/user.svg) center / cover;
      width: 0.873rem;
      height: 1rem;
      margin-inline-end: var(--space-smaller);
      background-color: var(--color-base);
    }
  }
}
</style>
