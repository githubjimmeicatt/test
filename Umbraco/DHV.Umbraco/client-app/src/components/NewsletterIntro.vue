<template>
  <ol
    v-show="isEnabled"
    :class="{ isMobile }"
  >
    <li
      v-for="({ href, title, contentTypeAlias }, i) in items"
      :key="i"
      :class="{ 'gt-after': href && !isMobile, 'gt-before': href && isMobile }"
    >
      <router-link
        v-if="href && contentTypeAlias !== 'contentGroup'"
        class="link"
        :to="href"
      >
        {{ title }}
      </router-link>
      <span v-else>
        {{ title }}
      </span>
    </li>
  </ol>
</template>

<script>
import { computed, inject } from 'vue'
import { useMediaQuery } from '@vueuse/core'

function flatten(menu) {
  if (!menu?.length) return []
  return menu.flatMap((x) => [x, ...flatten(x?.children)])
}

function getList(menu, item) {
  if (!menu?.length || !item) return []
  const parent = menu.find((x) => x.children.some((c) => c === item))
  if (!parent) return []
  return [...getList(menu, parent), parent]
}

function getItems(menu, content, isMobile) {
  const home = { href: '/', title: 'Home' }
  if (!menu?.length || !content?._id) return [home]
  const flat = flatten(menu)
  const self = flat.find((x) => x.id === content._id)
  if (isMobile) {
    const parent = flat.find((x) => x.children.some((c) => c === self))
    if (!parent) return [home]
    return [parent]
  }
  if (!self) return [home]
  return [home, ...getList(flat, self), {
    title: self.title,
  }]
}

export default {
  setup() {
    const menu = inject('menu')
    const content = inject('content')
    const isMobile = useMediaQuery('(max-width: 40rem)')
    const isEnabled = computed(() => content.value?._level > 1)
    const items = computed(() => getItems(menu.value, content.value, isMobile.value))
    return { items, isMobile, isEnabled }
  },
}
</script>

<style lang="scss" scoped>
ol {
  display: flex;
  width: 100%;
  margin: 0;
  padding: var(--space-smaller) var(--dynamic-spacing-large);
  gap: var(--space-smaller);
  font-size: .875rem;
}

li {
  display: block;

  &.gt-after::after,
  &.gt-before::before {
    content: ">";
  }

  &.gt-before::before {
    margin-inline-end: var(--space-smaller);
  }

  &.gt-after::after {
    margin-inline-start: var(--space-smaller);
  }
}

.link {
  color: inherit;
}
</style>
