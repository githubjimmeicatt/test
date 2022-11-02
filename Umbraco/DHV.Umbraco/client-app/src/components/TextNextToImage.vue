<template>
  <section>
    <h1 v-if="title">
      {{ title }}
    </h1>

    <div>
      <img
        :src="image.src"
        height="250"
      >

      <p v-if="text">
        {{ text }}
      </p>
    </div>
  </section>
</template>

<script>
import TheLink from './TheLink.vue'

export default {
  components: { TheLink },
  props: {
    title: {
      type: String,
      default: '',
    },
    text: {
      type: String,
      default: '',
    },
    image: {
      type: Object,
      default: () => {},
    },
  },
}
</script>

<style lang="scss" scoped>
div {
  display: flex;

  p {
    padding: 2rem;
  }
}
</style>
