<!-- eslint-disable vuejs-accessibility/alt-text -->
<template>
  <img
    ref="target"
    v-if="attrs.src"
    v-bind="attrs"
  >
</template>

<script>
import {
  ref, computed,
} from 'vue'
import useUmbracoImage from '../composables/useUmbracoImage'

export default {
  inheritAttrs: false,
  props: {
    src: {
      type: [String, Object],
      default: '',
    },
  },
  setup(props, context) {
    const target = ref(null)

    const src = props.src && typeof props.src === 'object'
      ? useUmbracoImage(() => props.src, target)
      : computed(() => props.src?.toString())

    const attrs = computed(() => ({
      ...context.attrs,
      src: src.value,
      loading: 'lazy',
    }))

    return {
      attrs,
      target,
    }
  },
}
</script>
