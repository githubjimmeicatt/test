<template>
  <article class="card">
    <lazy-img
      v-if="image?._url || image?.url"
      height="100%"
      width="100%"
      :src="image"
      :alt="title ? `card ${title} banner` : 'card banner'"
    />

    <h1 v-if="title">
      {{ title }}
    </h1>

    <p
      v-if="subtitle"
      class="subtitle"
    >
      {{ subtitle }}
    </p>

    <slot>
      <rich-text
        v-if="body"
        :body="body"
      />
    </slot>

    <the-link
      v-if="target?.url"
      :href="target.url"
      :target="target.target"
    >
      {{ target.name || target.url }} &gt;
    </the-link>

    <slot name="postlink" />
  </article>
</template>

<script>
import LazyImg from './LazyImg.vue'
import RichText from './RichText.vue'
import TheLink from './TheLink.vue'

export default {
  components: {
    LazyImg, TheLink, RichText,
  },
  props: {
    contentTypeAlias: {
      type: String,
      default: '',
    },
    title: {
      type: String,
      default: '',
    },
    body: {
      type: String,
      default: '',
    },
    subtitle: {
      type: String,
      default: '',
    },
    image: {
      type: Object,
      default: null,
    },
    target: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

article {
  position: relative;
  padding: 1.5rem;
  background-color: var(--card-background-color, white);

  display: flex;
  flex-direction: column;
  overflow: hidden;
  height: 100%;
  border-radius: 0 0 0.75rem 0.75rem;
  box-shadow: 0 0 0.625rem rgba(0, 0, 0, 0.25);

  @include screen-fits-two-cards {
    padding: 2rem;
  }

  ::v-deep(h1) {
    font-size: 1.25rem;
    margin: 0;
  }

  ::v-deep(.subtitle) {
    text-transform: capitalize;
    margin-block: var(--space-smaller);
  }

  img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 12rem;
    object-fit: cover;
    object-position: center;
  }

  img + .subtitle, img + h1, img + p {
    margin-top: var(--space-largest);
  }
}
</style>
