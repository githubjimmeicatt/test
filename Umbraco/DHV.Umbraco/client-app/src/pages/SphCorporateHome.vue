<template>

  <page-header
    v-bind="content.hero" />

  <LiveEventCards
    v-bind="content.cards" />

  <TextNextToImage
    v-bind="content.textNextToImage" />

  <LatestNews
    v-bind="content.newsPicker" />

  <FormElement
    v-bind="content.formulier" />

</template>

<script>
import { inject } from 'vue'
import LatestNews from '@/components/LatestNews.vue'
import LiveEventCards from '@/components/LiveEventCards.vue'
import TextNextToImage from '@/components/TextNextToImage.vue'
import FormElement from '@/components/FormElement.vue'
import PageHeader from '../components/PageHeader.vue'

export default {
  components: {
    PageHeader,
    LatestNews,
    LiveEventCards,
    TextNextToImage,
    FormElement,
  },
  setup() {
    const content = inject('content')
    return {
      content,
    }
  },

}
</script>
