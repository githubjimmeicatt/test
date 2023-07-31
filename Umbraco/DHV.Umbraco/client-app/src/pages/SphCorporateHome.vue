<template>

  <page-header
    v-bind="content.hero"
  >
    <template #above v-if="latestDekkingsgraad">
      <article class="page-header-highlight">
        <header>Financiële situatie</header>

        <dl>
          <dt>Actuele dekkingsgraad</dt>
          <dd>{{ latestDekkingsgraad }}</dd>
        </dl>
        <the-link
          v-if="content?.dekkingsgraadLink?._url"
          class="highlight-link"
          :href="content.dekkingsgraadLink._url"
          title="Ga naar de dekkingsgraadpagina"
        >
          Ga naar de dekkingsgraadpagina
        </the-link>
      </article>
    </template>
  </page-header>

  <LiveEventCards
    class="container"
    v-bind="content.cards"
  />

  <LatestNews
    class="container"
    v-bind="content.newsPicker"
  />

  <TextNextToImage
    class="container"
    v-bind="content.textNextToImage"
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
import { parseUmbracoDate } from 'icatt-heartcore'
import { parseAndFormatPercentage } from '@/helpers/percentage'
import TheLink from '@/components/TheLink.vue'
import PageHeader from '../components/PageHeader.vue'

export default {
  components: {
    PageHeader,
    LatestNews,
    LiveEventCards,
    TextNextToImage,
    FormElement,
    TheLink,
  },
  setup() {
    const content = inject('content')
    const latestDekkingsgraad = computed(() => {
      if (!Array.isArray(content?.value?.dekkingsgraad?.data)) return undefined
      const ordered = content.value.dekkingsgraad.data.map((x) => ({
        ...x,
        date: parseUmbracoDate(x.date),
      })).sort((a, b) => b.date - a.date)
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

    :deep(.chart-wrapper), :deep(tbody tr:nth-child(even) td)  {
        background-color:  var(--color-table);
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

.page-header-highlight {
  display: flex;
  flex-direction: column;
  align-items: center;
  row-gap: var(--space-smaller);
  position: relative;

  header {
    font-size: 1.5rem;
    color: var(--color-base);
    font-weight: 600;
    text-align: center;
  }

  dl {
    margin: 0;
    text-align: center;

    dt {
      font-weight: 600;
      margin-block-end: var(--space-smaller);
    }

    dd {
      font-size: 2rem;
      margin: 0;
    }
  }
  .highlight-link {
    position: absolute;
    font-size: 0;
    top: 0;
    left: 0;
    inline-size: 100%;
    block-size: 100%;
    display: block;
  }
}
</style>
