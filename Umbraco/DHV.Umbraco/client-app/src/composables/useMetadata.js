/* eslint-disable no-underscore-dangle */
import { useHead } from '@vueuse/head'
import {
  isRef, computed,
} from 'vue'

export default function useMetaData(content) {
  if (!content || !isRef(content)) throw new Error('Only use this with a reference to the page content')
  const result = computed(() => {
    const { value } = content
    const title = value?.title || value?.header?.title || value?.name || window.UMBRACO_PORTAL?.footerName || ''

    /** @type {import('@vueuse/head').HeadObject} */
    const head = {
      title,
    }

    return head
  })

  useHead(result)
}
