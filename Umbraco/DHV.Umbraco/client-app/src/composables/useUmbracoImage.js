import {
  ref, computed, watch,
} from 'vue'
import { useResizeObserver, debouncedWatch } from '@vueuse/core'

const crop = true

export default function useUmbracoImage(umbracoImageFunc, el) {
  const rect = ref(null)
  const umbracoImage = computed(typeof umbracoImageFunc === 'function'
    ? umbracoImageFunc
    : () => umbracoImageFunc)

  useResizeObserver(el, ([{ contentRect }]) => {
    rect.value = contentRect
  })

  let initialized = false
  let clearedInitialWatch = false

  const imageUrl = ref('')

  if (!crop) {
    // crop is disabled manually, probably because the Umbraco CDN is broken again
    watch(umbracoImage, (val) => {
      imageUrl.value = val?._url
    }, { immediate: true })
    return imageUrl
  }

  const getUrl = (rectangle) => {
    // backwards compatible
    const file = umbracoImage.value?.umbracoFile ? umbracoImage.value.umbracoFile : umbracoImage.value
    const urlTemplate = file?.focalPointUrlTemplate
    if (!rectangle || !urlTemplate) return null
    const { width, height } = rectangle
    if (!width || !height) return null
    // if (!crop) return urlTemplate.replace('{width}', width).replace('&height={height}', '').replace('&mode=crop', '')
    return urlTemplate.replace('{width}', width).replace('{height}', height)
  }

  // make sure we don't debounce the initial url
  const unwatch = watch(rect, (rectangle) => {
    if (!initialized && rectangle) {
      const url = getUrl(rectangle)
      if (url) {
        initialized = true
        imageUrl.value = url
      }
    }
  })

  // after that, debounce on resize so we don't make too many requests
  debouncedWatch(rect, (rectangle) => {
    if (!initialized) return
    // we're initialized, so we can stop the initial watch we setup
    if (!clearedInitialWatch) {
      clearedInitialWatch = true
      unwatch()
    }
    const url = getUrl(rectangle)
    if (url) {
      imageUrl.value = url
    }
  }, { debounce: 1000 })

  return imageUrl
}
