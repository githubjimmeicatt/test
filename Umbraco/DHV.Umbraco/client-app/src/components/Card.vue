<template>

  <article class="card" :class="{ clickable: linkOfTarget?.url }" @click="followLink">

    <img
      v-if="image?.media?._url "

      :alt="image?.media?.name ? `card ${image?.media?.name} banner` : 'card banner'"

      :src="image.media._url "
      loading="lazy">

    <img
      v-else-if="image?.url"
      alt="card banner"
      :src="image?.url"
      loading="lazy">

    <div class="article-inner">
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
        v-if="linkOfTarget?.url"
        :href="linkOfTarget.url"
        :target="linkOfTarget.target"
      >
        {{ linkOfTarget.name || linkOfTarget.url }} &gt;
      </the-link>

      <slot name="postlink" />
    </div>
  </article>

</template>

<script>
import { useRouter } from 'vue-router'
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
    link: {
      type: Object,
      default: () => {},
    },
  },

  setup() {
    const router = useRouter()

    return {
      router,

    }
  },

  computed: {
    linkOfTarget() {
      const x = this.target || this.link
      if (!x) {
        return null
      }
      if (!x.target) {
        x.target = '_self'
      }
      return x
    },
  },
  methods: {
    followLink() {
      this.router.push(this.linkOfTarget.url)
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

.clickable{
 cursor: pointer;
}

article {
  position: relative;
  background-color: var(--card-background-color, white);

  display: flex;
  flex-direction: column;
  overflow: hidden;
  height: 100%;
  border-radius: 0 0 0.75rem 0.75rem;
  box-shadow: 0 0 0.625rem rgba(0, 0, 0, 0.25);

 img{
    width: 100%;
    object-position: center;
    object-fit: cover;
  }

  ::v-deep(h1) {
    font-size: 1.25rem;
    margin: 0;
  }

  ::v-deep(.subtitle) {
    text-transform: capitalize;
    margin-block: var(--space-smaller);
  }

  .article-inner{
    padding: 1.5rem;
  }
}

</style>
