import {
  ref, watch, type Ref, computed,
} from 'vue'

import { parseUmbracoDate } from '../api/parse-date'
import type { UmbracoApi } from '../api/umbraco'
import { useUmbracoApi } from '../plugin'

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

const getChildrenTypeAndUrl = (
  id: string,
  api: UmbracoApi,
): Promise<{
  componentName?: string;
  startsWithUrl?: string;
}> => {
  const query = getChildrenTypeQuery(id)
  return api.postGraphQlQuery(query, false).then((json: any) => {
    const { url, children } = json?.data?.content ?? {}
    const componentName: string | undefined = Array.isArray(children?.items)
      ? children.items[0]?.contentTypeAlias
      : undefined

    return {
      componentName,
      startsWithUrl: url as string | undefined,
    }
  })
}

const getQueryName = (componentName?: string) => componentName
  && `all${componentName[0]?.toUpperCase()}${componentName.substring(1)}`

const getNewsQuery = ({
  queryName,
  cursor,
  pageSize,
  now,
  startsWithUrl,
}: NewsParams) => {
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
      body
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
  queryName: string;
  pageSize?: number;
  cursor?: string;
  now: Date;
  startsWithUrl: string;
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
  items: NewsCard[];
  endCursor: string;
  hasNextPage: boolean;
}

async function getNewsCards(
  params: NewsParams,
  api: UmbracoApi,
): Promise<PaginatedNewsCards> {
  const json = await api.postGraphQlQuery(getNewsQuery(params))

  const result = json.data?.[params.queryName] ?? {}

  const { pageInfo } = result

  const items = (result.items ?? []).map((item: any) => {
    const {
      updateDate, publishDate, createDate, image,
    } = item
    return {
      ...item,
      publishDate: parseUmbracoDate(publishDate),
      updateDate: parseUmbracoDate(updateDate),
      createDate: parseUmbracoDate(createDate),
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

export function useNewsCards(
  id: Ref<string>,
  params?: {
    pageSize?: Ref<number | undefined> | number;
    maxItems?: Ref<number | undefined> | number | undefined;
  },
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

  const api = useUmbracoApi()
  if (!api) throw new Error('umbraco api not setup')

  const maxItemsRef = computed(() => {
    if (!params?.maxItems) return undefined
    if (typeof params.maxItems === 'number') return params.maxItems
    return params.maxItems.value
  })

  const pageSizeRef = computed(() => {
    if (!params?.pageSize) return undefined
    if (typeof params.pageSize === 'number') return params.pageSize
    return params.pageSize.value
  })

  const limtedPageSizeRef = computed(() => (maxItemsRef.value
    && (!pageSizeRef.value || maxItemsRef.value < pageSizeRef.value)
    ? maxItemsRef.value
    : pageSizeRef.value))

  const limitedHasNextPage = computed(
    () => hasNextPageRef.value
      && (!maxItemsRef.value || maxItemsRef.value > itemsRef.value.length),
  )

  const limitedPage = computed(() => (maxItemsRef.value && maxItemsRef.value < itemsRef.value.length
    ? itemsRef.value.slice(0, maxItemsRef.value)
    : itemsRef.value))

  watch(
    id,
    (i) => {
      queryNameRef.value = ''
      itemsRef.value = []
      isLoadingRef.value = true
      cursorRef.value = ''
      if (i) {
        getChildrenTypeAndUrl(i, api)
          .then(({ componentName, startsWithUrl }) => {
            queryNameRef.value = getQueryName(componentName)
            urlRef.value = startsWithUrl
          })
          .catch((e) => {
            errorRef.value = e
          })
          .finally(() => {
            isLoadingRef.value = false
          })
      }
    },
    { immediate: true },
  )

  watch(
    [cursorRef, queryNameRef, limtedPageSizeRef, urlRef],
    ([cursor, queryName, pageSize, startsWithUrl]) => {
      if (!queryName || !startsWithUrl) return

      isLoadingRef.value = true

      getNewsCards(
        {
          queryName,
          startsWithUrl,
          now,
          cursor,
          pageSize,
        },
        api,
      )
        .then(({ items, endCursor, hasNextPage }) => {
          itemsRef.value = [...itemsRef.value, ...items]
          hasNextPageRef.value = hasNextPage
          nextCursorRef.value = endCursor
        })
        .catch((e) => {
          errorRef.value = e
        })
        .finally(() => {
          isLoadingRef.value = false
        })
    },
  )

  return {
    currentPage: limitedPage,
    hasNextPage: limitedHasNextPage,
    getNextPage() {
      if (limitedHasNextPage.value) {
        cursorRef.value = nextCursorRef.value
      }
    },
    isLoading: isLoadingRef,
    error: errorRef,
  }
}
