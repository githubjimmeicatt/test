<template>
  <pageheader
    v-if="content.hero.title"
    class="pageheader"
    v-bind="content.hero"
    :narrow="!content.heroBig"
  />

  <breadcrumbs class="breadcrumbs" />

  <template
    v-for="(c,i) in main"
    :key="i"
  >
    <div
      v-if="i === 0 && aside.length"
      class="aside-with-content container"
    >
      <section
        v-if="c.component === 'richtext'"
        class="container"
      >
        <h1 v-if="i === 0">
          {{ content.name }}
        </h1>

        <richtext :body="c.props.body" />
      </section>
      <component
        :is="c.component"
        v-else
        v-bind="c.props"
      />
      <aside>
        <template
          v-for="(a,j) in aside"
          :key="j"
        >
          <component
            :is="a.component"
            v-bind="a.props"
          />
        </template>
      </aside>
    </div>
    <section
      v-else-if="c.component === 'richtext'"
      class="container"
    >
      <h1 v-if="i === 0">
        {{ content.name }}
      </h1>

      <richtext :body="c.props.body" />
    </section>
    <component
      :is="c.component"
      v-else
      v-bind="c.props"
      class="container"
    />
  </template>
</template>
<script>
import { inject, defineComponent, computed } from 'vue'
import cleanGlobImport from '../helpers/cleanGlobImport'

const components = cleanGlobImport(import.meta.glob('../components/*.vue'))

function mapComponent(props) {
  const contentTypeAlias = (props.contentTypeAlias ?? '').toLowerCase()
  if (contentTypeAlias === 'textblock') {
    return {
      component: 'richtext',
      props: {
        body: props.textEditor,
      },
    }
  }
  if (contentTypeAlias === 'cardsandmore') {
    return {
      component: 'cards',
      props,
    }
  }

  return {
    component: contentTypeAlias,
    props: {
      ...props,
    },
  }
}

export default defineComponent({
  components,
  setup() {
    const content = inject('content')
    const main = computed(() => (Array.isArray(content.value?.main) ? content.value.main.map(mapComponent) : []))
    const aside = computed(() => (Array.isArray(content.value?.sidebar) ? content.value.sidebar.map(mapComponent) : []))
    return {
      main,
      aside,
      content,
    }
  },
})
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
