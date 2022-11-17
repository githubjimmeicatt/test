<!-- eslint-disable vuejs-accessibility/alt-text -->
<template>
  <img
    ref="target"
    v-bind="attrs"
    loading="lazy"
  >
</template>

<script>
import {
  ref, watch, computed,
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
  setup(props, { attrs }) {
    const target = ref(null)

    const imageUrl = props.src && typeof props.src === 'object'
      ? useUmbracoImage(() => props.src, target)
      : computed(() => props.src.toString())

    watch([imageUrl], ([imageUrlVal]) => {
      const { value } = target
      if (!value || !imageUrlVal) return
      value.src = imageUrlVal
    }, { immediate: true })

    return {
      attrs,
      target,
    }
  },
}
</script>
