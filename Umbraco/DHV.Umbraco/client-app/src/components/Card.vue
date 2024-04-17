<template>
  <article class="card">

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
        v-if="target?.url"
        :href="target.url"
        :target="target.target"
      >
        {{ target.name || target.url }} &gt;
      </the-link>

      <slot name="postlink" />
    </div>
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
  background-color: var(--card-background-color, white);

  display: flex;
  flex-direction: column;
  overflow: hidden;
  height: 100%;
  border-radius: 0 0 0.75rem 0.75rem;
  box-shadow: 0 0 0.625rem rgba(0, 0, 0, 0.25);

 img{
    width: 100%;
    // height: 217px;

    // @include mobile {
    //     .strip {
    //       height: 130px;
    //     }
    //   }

    // @include screen-fits-two-cards {
    //   height: 188px;
    // }

    // @include screen-fits-three-cards {
    //   height: 122px;
    //  }

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
