<template>
  <section :class="[imagePosition !== 'Links' && 'align-right']">
    <figure>
      <img
        :src="image?.src"
        :alt="title ? title : ''"
      >
    </figure>

    <div>
      <h1 v-if="title">
        {{ title }}
      </h1>

      <rich-text
        v-if="text"
        :body="text"
      />

      <the-link
        v-if="button?.url"
        :href="button.url"
        class="cta"
        data-gtm-button-type="cta"
      >
        {{buttonText}}
      </the-link>
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
    button: {
      type: Object,
      default: () => {},
    },
  },

  computed: {
    buttonText() {
      return this.button?.name ?? 'Meer informatie'
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
  margin: 0;

  .align-right & {
    order: 1;
  }

  img {
    max-width: var(--max-text-width);
    margin-top:0px;
    max-height: 25rem;

    @include screen-fits-two-cards {
      max-height: 100%;
    }
  }
}
</style>
