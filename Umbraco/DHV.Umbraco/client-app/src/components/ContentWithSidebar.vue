<template>
  <section
    v-if="textBlock || items?.length"
    class="container sidebar"
  >
    <slot name="textblock">
      <article
        v-if="textBlock"
        class="richtext"
      >
        <h1 v-if="title">
          {{ title }}
        </h1>
        <richtext :body="textBlock" />
      </article>
    </slot>
    <slot name="sidebar">
      <ul
        v-if="items?.length"
      >
        <template
          v-for="(item, index) in items"
          :key="index"
        >
          <li
            v-if="item?.component === 'textblock'"
            class="richtext"
          >
            <richtext :body="item.textEditor" />
          </li>
          <li>
            <component
              :is="item.component"
              v-bind="item"
            />
          </li>
        </template>
      </ul>
    </slot>
  </section>
</template>

<script>
import { computed } from 'vue'
import cleanGlobImport from '../helpers/cleanGlobImport'

const components = cleanGlobImport(import.meta.glob('./*.vue'))

export default {
  components,
  props: {
    title: {
      type: String,
      default: '',
    },
    textBlock: {
      type: String,
      default: '',
    },
    contentGroupSidebar: {
      type: Object,
      default: () => {},
    },
  },
  setup(props) {
    return {
      props,
      components,
      items: computed(() => props?.contentGroupSidebar?.map((x) => ({
        ...x,
        component: x?.contentTypeAlias?.toLowerCase(),
      }))),
    }
  },
}
</script>
