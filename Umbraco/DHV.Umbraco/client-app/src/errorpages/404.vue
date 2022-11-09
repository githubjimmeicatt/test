<template>
  <section class="container">
    <h1>Pagina niet gevonden</h1>
    <a href="/">Klik hier om terug naar de homepagina te gaan.</a>
    <search-bar class="search-bar-404" />
  </section>
</template>

<script>
import SearchBar from '../components/SearchBar.vue'

export default {
  components: { SearchBar },
}
</script>

<style lang="scss" scoped>
.search-bar-404 {
  margin-top: var(--space-medium);
  max-width: 28rem;
  height: 3.5rem;
  padding: 0 var(--space-small);

  :deep(.cta-inverse) {
    display: none;
  }
}
</style>
