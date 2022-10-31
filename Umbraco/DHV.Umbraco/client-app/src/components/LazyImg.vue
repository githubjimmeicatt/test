<template>
  <img
    ref="target"
    :class="{loading}"
    v-bind="attrs"
    @load="loading = false"
  >
</template>

<script>
import {
  ref, watch, computed,
} from 'vue'
import { useIntersectionObserver } from '@vueuse/core'
import useUmbracoImage from '../composables/useUmbracoImage'

export default {
  inheritAttrs: false,
  props: {
    src: {
      type: [String, Object],
      default: '',
    },
  },
  setup(props, { attrs }) {
    const target = ref(null)
    const isVisible = ref(false)
    const loading = ref(true)
    useIntersectionObserver(
      target,
      ([{ isIntersecting }]) => {
        isVisible.value = isIntersecting
      },
    )
    const imageUrl = props.src && typeof props.src === 'object'
      ? useUmbracoImage(() => props.src, target)
      : computed(() => props.src)

    watch([isVisible, imageUrl], ([isVisibleVal, imageUrlVal]) => {
      const { value } = target
      if (!value || !isVisibleVal || !imageUrlVal) return
      value.src = imageUrlVal
    }, { immediate: true })

    if ('src' in attrs) {
      // eslint-disable-next-line no-param-reassign
      delete attrs.src
    }

    return {
      attrs,
      target,
      loading,
    }
  },
}
</script>

<style lang="scss" scoped>
img {
  opacity: 100%;
  transition: opacity 0.25s ease-in;

  &.loading {
    opacity: 0;
  }
}
</style>
