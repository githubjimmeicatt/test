import {
  ref, watch, computed,
} from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { api, Portal } from '../api/umbraco'
import cleanGlobImport from '../helpers/cleanGlobImport'
import useMetaData from './useMetadata'

const pages = cleanGlobImport(import.meta.globEager('../pages/*.vue'))
const errorPages = cleanGlobImport(import.meta.globEager('../errorpages/*.vue'))
const loading = ref(false)

const menu = ref(api.cleanUrls(window.UMBRACO_MENU || []))
const content = ref(window.UMBRACO_INITIAL_STATE || { contentTypeAlias: '' })
const umbracoId = window.UMBRACO_PORTAL?.umbracoId
const portal = new Portal(umbracoId)

const errorCode = ref(null)

const component = computed(() => {
  if (errorCode.value) {
    return errorPages[errorCode.value.message] || errorPages['500']
  }
  const type = content.value?.contentTypeAlias
  return type && pages[type.toLowerCase()]
})

export default function useUmbraco() {
  const route = useRoute()
  const router = useRouter()
  useMetaData(content)
  watch([() => route.path, () => route.name], async ([routePath, routeName]) => {
    errorCode.value = null
    // initiele state krijgen we van de backend
    if (window.UMBRACO_INITIAL_STATE) {
      content.value = api.cleanUrls(window.UMBRACO_INITIAL_STATE)
      window.UMBRACO_INITIAL_STATE = undefined
      return
    }
    if (routeName !== 'Umbraco') return
    loading.value = true
    content.value = null
    try {
      const result = await portal.fetchPage(routePath)
      if (result?.redirect?._url) {
        window.UMBRACO_INITIAL_STATE = result.redirect
        router.push(result.redirect._url)
        return
      }
      content.value = result
    } catch (error) {
      errorCode.value = error
    } finally {
      loading.value = false
    }
  })

  return {
    menu,
    content,
    portal,
    component,
    pages,
    loading,
  }
}
