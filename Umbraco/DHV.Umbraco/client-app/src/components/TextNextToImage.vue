<template>
  <section :class="[imagePosition !== 'Links' && 'align-right']">
    <figure>
      <img :src="image?.src">
    </figure>

    <div>
      <h1 v-if="title">
        {{ title }}
      </h1>

      <!-- <rich-text
        v-if="text"
        :body="text"
      /> -->

      <p v-if="text">
        {{ text }}
      </p>

      <!-- TODO: button property? -->
      <a
        href=""
        class="cta"
      >Meer informatie</a>
    </div>
  </section>
</template>

<script>
import TheLink from './TheLink.vue'
import RichText from './RichText.vue'

export default {
  components: { TheLink, RichText },
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
    imagePosition: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

section {
  display: grid;
  gap: var(--space-medium);

  @include screen-fits-two-cards {
    grid-template-columns: 2fr 3fr;

    &.align-right {
      grid-template-columns: 3fr 2fr;
    }
  }
}

figure {
  display: flex;
  justify-content: center;
  margin: 0;

  .align-right & {
    order: 1;
  }

  img {
    height: 100%;
    width: 100%;
    object-fit: cover;
    object-position: center;

    max-width: var(--card-width-large); // ...
  }
}
</style>
