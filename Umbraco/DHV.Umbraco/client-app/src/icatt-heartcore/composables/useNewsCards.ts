import {
  ref, watch, type Ref,
} from 'vue'

import { api } from '@/icatt-heartcore/api/umbraco'
import parseDate from '@/icatt-heartcore/api/parse-date'

const getChildrenTypeQuery = (id: string) => `{
  content(id: "${id}") {
    url
    children(first: 1) {
      items {
        contentTypeAlias
      }
    }
  }
}`

const getChildrenTypeAndUrl = (id: string) => {
  const query = getChildrenTypeQuery(id)
  return api.postGraphQlQuery(query, false).then((json) => {
    const { url, children } = json?.data?.content ?? {}
    const componentName = Array.isArray(children?.items) ? children.items[0]?.contentTypeAlias : undefined

    return {
      componentName,
      startsWithUrl: url,
    }
  })
}

const getQueryName = (componentName?: string) => componentName && `all${componentName[0]?.toUpperCase()}${componentName.substring(1)}`

const getNewsQuery = ({
  queryName, cursor, pageSize, now, startsWithUrl,
} : NewsParams) => {
  if (!queryName) return ''
  const cursorPart = cursor ? `, after: "${cursor}"` : ''

  return `{
  ${queryName}(
    orderBy: [publishDate_DESC,updateDate_DESC], 
    first:${pageSize || 15}${cursorPart},
    where: {
      publishDate_lt: "${now.toISOString()}"
      url_starts_with: "${startsWithUrl}"
    }
    ) {
    items {
      id
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

type NewsParams = {
  queryName: string,
  pageSize?: number,
  cursor?: string,
  now: Date
  startsWithUrl: string
}

export interface NewsCard {
  id: string;
  summary: string;
  name: string;
  url: string;
  createDate: Date;
  updateDate: Date;
  publishDate: Date;
  image: any;
}

interface PaginatedNewsCards {
  items: NewsCard[]
  endCursor: string;
  hasNextPage: boolean;
}

async function getNewsCards(params: NewsParams): Promise<PaginatedNewsCards> {
  const json = await api.postGraphQlQuery(getNewsQuery(params))

  const result = json.data?.[params.queryName] ?? {}

  const { pageInfo } = result

  const items = (result.items ?? []).map((item: any) => {
    const {
      updateDate, publishDate, createDate, image,
    } = item
    return {
      ...item,
      publishDate: parseDate(publishDate),
      updateDate: parseDate(updateDate),
      createDate: parseDate(createDate),
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

export default function useNewsCards(
  id: Ref<string>,
  params: { pageSize: Ref<number> | number | undefined },
) {
  const now = new Date()
  const urlRef = ref<string>()
  const queryNameRef = ref<string>()
  const cursorRef = ref<string>()
  const nextCursorRef = ref<string>()
  const itemsRef = ref<NewsCard[]>([])
  const hasNextPageRef = ref(false)
  const isLoadingRef = ref(false)
  const errorRef = ref()
  const pageSizeRef = params.pageSize && typeof params.pageSize !== 'number' ? params.pageSize : ref(params.pageSize)

  watch(id, (i) => {
    queryNameRef.value = ''
    itemsRef.value = []
    isLoadingRef.value = true
    cursorRef.value = ''
    if (i) {
      getChildrenTypeAndUrl(i).then(({ componentName, startsWithUrl }) => {
        queryNameRef.value = getQueryName(componentName)
        urlRef.value = startsWithUrl
      }).catch((e) => {
        errorRef.value = e
      }).finally(() => {
        isLoadingRef.value = false
      })
    }
  }, { immediate: true })

  watch(
    [cursorRef, queryNameRef, pageSizeRef, urlRef],
    ([cursor, queryName, pageSize, startsWithUrl]) => {
      if (!queryName || !startsWithUrl) return

      isLoadingRef.value = true

      getNewsCards({
        queryName,
        startsWithUrl,
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
    },
  )

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
