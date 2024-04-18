<template>
  <article>
    <h1 v-if="title">
      {{ title }}
    </h1>
    <rich-text
      v-if="body"
      :body="body"
    />
    <the-link
      v-if="link?.url"
      :target="link.target"
      :href="link.url"
      class="cta"
      data-gtm-button-type="cta"
    >
      {{ link.name }}
    </the-link>
  </article>
</template>

<script>
import RichText from './RichText.vue'
import TheLink from './TheLink.vue'

export default
{
  components: { TheLink, RichText },
  props: {
    title: {
      type: String,
      default: '',
    },
    body: {
      type: String,
      default: '',
    },
    link: {
      type: Object,
      default: null,
    },
  },

}
</script>
