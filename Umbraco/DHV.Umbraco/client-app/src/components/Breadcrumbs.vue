<template>
  <ol
    v-show="isEnabled"
    :class="{isMobile}"
  >
    <li
      v-for="({href, title},i) in items"
      :key="i"
      :class="{ 'arrow-after': href && !isMobile, 'arrow-before': href && isMobile }"
    >
      <router-link
        v-if="href"
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
  return [...getList(parent), parent]
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
    const isMobile = useMediaQuery('(max-width: 500px)')
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
  padding-block-end: 0;
  gap: var(--space-smaller);
  font-size: .875rem;
}

li {
  display: block;

  &.arrow-after::after,
  &.arrow-before::before {
    background-color: var(--color-base);
  }
}

.link {
  color: inherit;
}
</style>
