<template>

  <page-header
    v-bind="content.hero"
  >
    <template #above v-if="latestDekkingsgraad">
      <article>
        <header>Financiele situatie</header>
        <dl>
          <dt>Actuele dekkingsgraad</dt>
          <dd>{{latestDekkingsgraad}}</dd>
        </dl>
      </article>
    </template>
  </page-header>

  <LiveEventCards
    class="container"
    v-bind="content.cards"
  />

  <TextNextToImage
    class="container"
    v-bind="content.textNextToImage"
  />

  <LatestNews
    class="container"
    v-bind="content.newsPicker"
  />

  <FormElement
    class="container"
    v-bind="content.formulier"
  />

</template>

<script>
import { inject, computed } from 'vue'
import LatestNews from '@/components/LatestNews.vue'
import LiveEventCards from '@/components/LiveEventCards.vue'
import TextNextToImage from '@/components/TextNextToImage.vue'
import FormElement from '@/components/FormElement.vue'
import parseDate from '@/icatt-heartcore/api/parse-date'
import { parseAndFormatPercentage } from '@/helpers/percentage'
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
    const latestDekkingsgraad = computed(() => {
      if (!Array.isArray(content?.value?.dekkingsgraad?.data)) return undefined
      const ordered = content.value.dekkingsgraad.data.map((x) => ({
        ...x,
        date: parseDate(x.date),
      })).sort((a, b) => a.date - b.date)
      const first = ordered[0]?.actueel
      return first && parseAndFormatPercentage(first)
    })
    return {
      content,
      latestDekkingsgraad,
    }
  },

}
</script>

<style lang="scss" scoped>
.aside-with-content {
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  row-gap: var(--space-medium);

  > :first-child {
    width: min(100%, 40rem);
  }

  .container {
    padding: 0;
  }
}

.pageheader {
  overflow: hidden;
}

main > .container {
  --card-shadow: rgba(0, 0, 0, 0.02) 0px 1px 3px 0px, rgba(27, 31, 35, 0.15) 0px 0px 0px 1px;

  &:nth-child(4n+2), &:nth-child(4n+4) {
    background-color: white;

    :deep(.card) {
      box-shadow: var(--card-shadow);
    }
  }

  &:nth-child(4n+1) {
    background-color: var(--color-background-1);

    :deep(.card) {
      box-shadow: none;
    }
  }

  &:nth-child(4n+3) {
    background-color: var(--color-background-2);

    :deep(.card) {
      box-shadow: none;
    }
  }
}

.pageheader ~ .container {
  &:nth-child(4n+1), &:nth-child(4n+3) {
    background-color: white;

    :deep(.card) {
      box-shadow: var(--card-shadow);
    }
  }

  &:nth-child(4n+2) {
    background-color: var(--color-background-1);

    :deep(.card) {
      box-shadow: none;
    }
  }

  &:nth-child(4n+4) {
    background-color: var(--color-background-2);

    :deep(.card) {
      box-shadow: none;
    }
  }
}

.container section.container {
  background: none;
}
</style>
