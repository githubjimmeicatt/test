<template>
  <cards
    nr-of-columns="4"
    :title="title"
    :cards="brochures"
    class="brochures"
  >
    <template #card="{card}">
      <brochure-card
        v-bind="card"
      />
    </template>
  </cards>
</template>

<script>
import Cards from './Cards.vue'
import BrochureCard from './BrochureCard.vue'

export default {
  components: { Cards, BrochureCard },
  props: {
    brochures: {
      type: Array,
      default: () => [],
    },
    title: {
      type: String,
      default: '',
    },
  },

}
</script>

<style lang="scss" scoped>
.brochures {
  background-color: var(--color-background-1);
}
</style>
