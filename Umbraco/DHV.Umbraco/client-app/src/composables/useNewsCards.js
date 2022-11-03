import {
  ref, watch, isReactive,
} from 'vue'
import { api } from '../api/umbraco'
import { parseDate, formatDate } from '../helpers/formatDate'

const getChildrenTypeQuery = (id) => `{
  content(id: "${id}") {
    children(first: 1) {
      items {
        contentTypeAlias
      }
    }
  }
}`

const getChildrenType = (id) => {
  const query = getChildrenTypeQuery(id)
  return api.postGraphQlQuery(query).then((json) => json.data.content.children.items[0].contentTypeAlias)
}

const getQueryName = (componentName) => `all${componentName[0]?.toUpperCase()}${componentName.substring(1)}`

const getNewsQuery = (params = {}) => {
  /**
   * @type {{queryName: string;cursor: string; pageSize:number; now: Date}}
   */
  const {
    queryName, cursor, pageSize, now,
  } = params
  if (!queryName) return ''
  const cursorPart = cursor ? `, after: "${cursor}"` : ''

  return `{
  ${queryName}(
    orderBy: [publishDate_DESC,updateDate_DESC], 
    first:${pageSize || 15}${cursorPart},
    where: {
      publishDate_lt: "${now.toISOString()}"
    }
    ) {
    items {
      name
      summary
      url
      createDate
      updateDate
      publishDate
      image {
        url
        ... on MediaWithCrops {
          focalPoint {
            left
            top
          }
          focalPointUrlTemplate
        }
      }
    }
    pageInfo {
      startCursor
      endCursor
      hasPreviousPage
      hasNextPage
    }
  }
}`
}

async function getNewsCards(params) {
  const {
    queryName,
    pageSize,
    cursor,
    now,
  } = params

  const json = await api.postGraphQlQuery(getNewsQuery({
    queryName,
    now,
    pageSize,
    cursor,
  }))

  const result = json.data?.[queryName] ?? {}

  const { pageInfo } = result

  const items = (result.items ?? []).map(({
    summary, name, url, image, publishDate,
  }) => {
    const date = parseDate(publishDate)
    return {
      body: summary,
      title: name,
      date,
      subtitle: formatDate(date),
      target: { url, name: 'Lees meer' },
      image: {
        ...image,
        // for backwards compatibility
        umbracoFile: {
          ...image,
        },
      },
    }
  })

  return {
    items,
    ...(pageInfo ?? {}),
  }
}

export default function useNewsCards(id, params) {
  const pageSize = params?.pageSize || 15

  const idRef = isReactive(id) ? id : ref(id)

  const now = new Date()
  const queryNameRef = ref()
  const cursorRef = ref()
  const nextCursorRef = ref()
  const itemsRef = ref([])
  const hasNextPageRef = ref(false)
  const isLoadingRef = ref(false)
  const errorRef = ref()

  watch(idRef, (i) => {
    queryNameRef.value = ''
    itemsRef.value = []
    isLoadingRef.value = true
    cursorRef.value = ''
    if (i) {
      getChildrenType(i).then((componentName) => {
        queryNameRef.value = getQueryName(componentName)
      }).catch((e) => {
        errorRef.value = e
      }).finally(() => {
        isLoadingRef.value = false
      })
    }
  }, { immediate: true })

  watch([cursorRef, queryNameRef], ([cursor, queryName]) => {
    isLoadingRef.value = true
    getNewsCards({
      queryName,
      now,
      cursor,
      pageSize,
    }).then(({ items, endCursor, hasNextPage }) => {
      itemsRef.value = [...itemsRef.value, ...items]
      hasNextPageRef.value = hasNextPage
      nextCursorRef.value = endCursor
    }).catch((e) => {
      errorRef.value = e
    }).finally(() => {
      isLoadingRef.value = false
    })
  })

  return {
    currentPage: itemsRef,
    hasNextPage: hasNextPageRef,
    getNextPage() {
      if (hasNextPageRef.value) {
        cursorRef.value = nextCursorRef.value
      }
    },
    isLoading: isLoadingRef,
    error: errorRef,
  }
}
