<template>
  <suspense>
    <component
      :is="layout"
      :theme="theme"
    >
      <template #main>
        <router-view />
      </template>
    </component>
  </suspense>
</template>

<script>
import { onMounted, provide, watch } from 'vue'
import { useNProgress } from '@vueuse/integrations/useNProgress'
import useLayout from './composables/useLayout'
import useUmbraco from './composables/useUmbraco'

export default {
  setup() {
    const { layout, theme } = useLayout()
    const {
      component, content, menu, loading,
    } = useUmbraco()
    provide('content', content)
    provide('menu', menu)
    provide('component', component)
    provide('loading', loading)

    const { isLoading } = useNProgress()

    watch(loading, (val) => {
      isLoading.value = val
    }, { immediate: true })

    onMounted(() => {
      document.getElementsByTagName('body')[0].classList.add(theme)
    })

    return {
      layout,
      theme,
      isLoading,
    }
  },
}
</script>

<style lang="scss">
@import "nprogress/nprogress.css";

#nprogress {
  .bar {
    background: var(--color-accent-1) !important;
  }
  .peg {
    box-shadow: 0 0 10px var(--color-accent-1), 0 0 5px var(--color-accent-1);
  }
  .spinner  .spinner-icon {
    border-top-color: var(--color-accent-1);
    border-left-color: var(--color-accent-1);
  }
}
</style>
