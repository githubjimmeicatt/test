<template>
  <article class="card">
    <lazy-img
      v-if="image"
      height="100%"
      width="100%"
      :src="image"
      :alt="title ? `card ${title} banner` : 'card banner'"
    />
    <p
      v-if="subtitle"
      class="toptitle"
    >
      {{ subtitle }}
    </p>
    <h1 v-if="title">
      {{ title }}
    </h1>
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
      class="arrow-before"
    >
      {{ target.name || target.url }}
    </the-link>
    <slot name="postlink" />
  </article>
</template>

<script>
import Beeldmerk from './Beeldmerk.vue'
import LazyImg from './LazyImg.vue'
import RichText from './RichText.vue'
import TheLink from './TheLink.vue'

export default {
  components: {
    Beeldmerk, LazyImg, TheLink, RichText,
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
  color: black;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  height: 100%;

  @include screen-fits-two-cards {
    padding: 2rem;
  }

  .beeldmerkcontainer {
    position: absolute;
    width: var(--card-border);
    left: 0;
    background-color: var(--color-base);
    top: 0;
    bottom: 0;
    overflow: hidden;

    svg {
      margin-left: -2.125rem;
      margin-top: -2.75rem;
      width: 3.5rem;
    }
  }

  ::v-deep(h1) {
    font-size: 1.375rem;
    font-weight: 600;
    margin: 0;
  }
  a:last-child {
    text-decoration: none;
    font-weight: 600;
    margin-top: auto;
    &::before {
      background-color: var(--color-accent-1);
    }
  }
  ::v-deep(.toptitle) {
    margin-top: 0;
    font-size: 0.75rem;
    font-weight:600;
    color: var(--color-accent-1-dark);
    text-transform: uppercase;
    margin-bottom: 0;
  }

  img {
    position: absolute;
    top: 0;
    left: 0.5rem;
    width: calc(100% + 1px);
    height: 12rem;
    object-fit: cover;
    object-position: center;
  }

  img + .toptitle, img + h1, img + p {
    margin-top: var(--space-largest);
  }
}
</style>
