<template>
  <the-link
    class="link"
    :href="document?._url || '#'"
    :target="openInNewTab ? '_blank' : '_self' "
  >
    <card>
      <lazy-img
        v-if="image"
        class="doc"
        :src="image"
        :alt="name ? `card ${name} banner` : 'card banner'"
      />
      <h1 v-if="name">
        {{ name }}
      </h1>
      <p
        v-if="formattedDate"
        class="toptitle"
      >
        {{ formattedDate }}
      </p>
    </card>
  </the-link>
</template>

<script>
import { computed } from 'vue'
import { formatDate } from '../helpers/formatDate'
import Card from './Card.vue'
import LazyImg from './LazyImg.vue'
import TheLink from './TheLink.vue'

export default {
  components: {
    Card,
    LazyImg,
    TheLink,
  },
  props: {
    image: {
      type: [Object, String],
      default: null,
    },
    document: {
      type: Object,
      default: () => ({ _url: '#' }),
    },
    documentLinkText: {
      type: String,
      default: '',
    },
    date: {
      type: String,
      default: '',
    },
    openInNewTab: {
      type: Boolean,
      default: true,
    },
  },
  setup(props) {
    return {
      formattedDate: computed(() => formatDate(props.date) || formatDate(props.document?._updateDate)),
      name: computed(() => props.documentLinkText || props.document?.name || ''),
    }
  },
}
</script>

<style lang="scss" scoped>
.toptitle {
  margin-top: 0;
}

.link {
  text-decoration: none;
}

.doc {
  width: 6rem;
  height: 9rem;
  margin-bottom: var(--space-small);
}
</style>
