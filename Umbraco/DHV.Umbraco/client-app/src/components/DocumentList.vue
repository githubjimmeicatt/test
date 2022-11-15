<template>
  <section
    v-if="documents?.length"
  >
    <h1 v-if="title">
      {{ title }}
    </h1>

    <rich-text
      v-if="section"
      :body="section"
    />

    <ul v-if="documents?.length">
      <li
        v-for="(x, i) in documents"
        :key="i"
        v-bind="x"
      >
        <the-link
          :href="x.document._url || '#'"
          target="_blank"
          rel="noopener noreferrer"
          data-gtm-button-type="cta"
        >
          <span v-if="x.documentLinkText">{{ x.documentLinkText }}</span>
          <span v-else>{{ x.document.name }}</span>
        </the-link>
      </li>
    </ul>
  </section>
</template>

<script>
import RichText from './RichText.vue'
import TheLink from './TheLink.vue'

export default {
  components: { TheLink, RichText },
  props: {
    documents: {
      type: Array,
      default: () => [],
    },
    title: {
      type: String,
      default: '',
    },
    section: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
ul {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: var(--space-small);

  li {
    &::before {
      content: ">";
      margin-inline-end: .5rem;
    }
  }
}
</style>
