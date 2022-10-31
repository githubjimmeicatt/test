<template>
  <nav v-if="parent?.children?.length">
    <h2 v-if="parent?.title">
      {{ parent.title }}
    </h2>
    <ul>
      <li
        v-for="(child, key) in parent.children"
        :key="key"
      >
        <router-link
          :to="child.href"
          class="arrow-before sibling-link"
        >
          {{ child.title }}
        </router-link>
      </li>
    </ul>
  </nav>
</template>

<script>
import { computed, inject } from 'vue'

function flatten(menu) {
  if (!menu?.length) return []
  return menu.flatMap((x) => [x, ...flatten(x?.children)])
}

function getParent(parentId, menu) {
  if (!parentId || !menu) return undefined
  const flatMap = flatten(menu)
  return flatMap.find((x) => x.id === parentId) || []
}

export default {
  props: {
    parentId: {
      type: String,
      default: '',
    },
  },
  setup(props) {
    const menu = inject('menu')
    const content = inject('content')
    const parent = computed(() => getParent(props.parentId || content.value?.parentId, menu.value))
    return {
      parent,
    }
  },
}
</script>

<style lang="scss" scoped>
nav ul {
  gap: 0;
}
.sibling-link {
  text-decoration: none;
  font-weight: 600;
  margin-top: auto;
  background: none;
  color: var(--color-base);
  padding: .5rem .75rem;
  display: inline-block;
}

.sibling-link::before {
  background-color: var(--color-accent-1);
}
</style>
