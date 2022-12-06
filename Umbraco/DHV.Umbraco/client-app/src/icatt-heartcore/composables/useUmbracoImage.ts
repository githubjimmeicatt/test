import {
  ref, computed, watch,
} from 'vue'
import { useResizeObserver, debouncedWatch, type MaybeComputedElementRef } from '@vueuse/core'

const crop = true

type HasUrl = { url: string } | { src: string } | { _url: string }

type UmbracoFile = {
  focalPointUrlTemplate: string;
}

// backwards compatible
type UmbracoImage = (HasUrl & UmbracoFile) | (HasUrl & {
  umbracoFile: UmbracoFile
})

type MaybeFunc<T> = T | (() => T)

function resolveUrl(val?: UmbracoImage): string {
  if (!val) return ''
  if ('url' in val) return val.url
  if ('_url' in val) return val._url
  return val.src
}

// eslint-disable-next-line import/prefer-default-export
export function useUmbracoImage(
  umbracoImageFunc: MaybeFunc<UmbracoImage>,
  el: MaybeComputedElementRef,
) {
  const rect = ref<DOMRectReadOnly>()
  const umbracoImage = computed(typeof umbracoImageFunc === 'function'
    ? umbracoImageFunc
    : () => umbracoImageFunc)

  useResizeObserver(el, ([{ contentRect }]) => {
    rect.value = contentRect
  })

  let initialized = false
  let clearedInitialWatch = false

  const originalUrl = computed(() => resolveUrl(umbracoImage.value))

  if (!crop) {
    // crop is disabled manually, probably because the Umbraco CDN is broken again
    return originalUrl
  }

  const imageUrl = ref('')

  const getUrl = (rectangle: DOMRectReadOnly | undefined) => {
    if (!originalUrl.value) return null
    if (!originalUrl.value.includes('media.umbraco.io') || originalUrl.value.endsWith('.svg')) return originalUrl.value
    const { width, height } = rectangle ?? {}
    if (!width || !height) return null

    const { value } = umbracoImage
    const file = value && 'umbracoFile' in value ? value.umbracoFile : value
    const urlTemplate = file?.focalPointUrlTemplate
    if (!urlTemplate) return null

    // if (!crop) return urlTemplate.replace('{width}', width).replace('&height={height}', '').replace('&mode=crop', '')
    return urlTemplate.replace('{width}', width.toString()).replace('{height}', height.toString())
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
