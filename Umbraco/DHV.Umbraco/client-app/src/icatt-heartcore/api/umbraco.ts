import type { Config } from '../config'

type FetchArgs = Parameters<typeof fetch>

type SearchParamsObj = Record<string, number | string | boolean>

function cleanUrls(data: any, config: Config, key = '', parentKey = ''): any {
  if (!data) return data

  if (Array.isArray(data)) { return data.map((x) => cleanUrls(x, config, key, parentKey)) }
  if (typeof data === 'object') {
    return Object.fromEntries(
      Object.entries(data).map(([childKey, val]) => [
        childKey,
        cleanUrls(val, config, childKey, key),
      ]),
    )
  }

  // replace secure media url's and portanames from url's
  if (typeof data === 'string') {
    let dataWithCustomUrls = data

    if (config.portal.isSecure && dataWithCustomUrls.includes('media.umbraco.io')) {
      const toReplace = /https:\/\/media\.umbraco\.io\/[^/]+\//g
      dataWithCustomUrls = dataWithCustomUrls.replace(
        toReplace,
        '/umbracomedia/',
      )
    }

    if (config.portal.prefix && dataWithCustomUrls.includes(config.portal.prefix)) {
      if ((['url', 'href'].some((x) => key?.toLowerCase().includes(x)) || parentKey?.toLowerCase().includes('urls')) && dataWithCustomUrls.startsWith(config.portal.prefix)) {
        dataWithCustomUrls = dataWithCustomUrls.replace(config.portal.prefix, '')
      } else {
        dataWithCustomUrls = dataWithCustomUrls.replaceAll(`href="${config.portal.prefix}/`, 'href="/')
      }
    }

    return dataWithCustomUrls
  }

  return data
}

const $fetch = (...args: FetchArgs) => fetch(...args)
  .then(async (r) => {
    const contentType = r.headers.get('content-type')

    const data = contentType?.toLowerCase()?.startsWith('application/json')
      ? await r.json()
      : null

    const result = {
      data,
      status: r.status,
      statusText: r.statusText,
    }

    if (!r.ok) {
      return Promise.reject(result)
    }

    return result
  })
  .catch((error) => {
    if (window?.location && error?.status === 401) {
      // gebruiker is uitgelogd.
      // pagina verversen, dan wordt de gebruiker naar de SSO geredirect
      window.location.reload()
    }
    throw error
  })

const getInstance = (config: Config) => ({
  get(url: string, arg?: { params?: SearchParamsObj; clean?: boolean }) {
    const entries = arg?.params
      && Object.entries(arg.params).map(([key, value]) => [key, value.toString()])

    const searchParams = entries?.length
      ? `?${new URLSearchParams(entries)}`
      : ''

    return $fetch(url + searchParams).then((x) => ({
      ...x,
      data: x.data && arg?.clean !== false ? cleanUrls(x.data, config) : x.data,
    }))
  },
  post(url: string, body?: Record<string, any> | FormData, clean = true) {
    let init: RequestInit = {}

    if (body) {
      init = body instanceof FormData
        ? { body }
        : {
          headers: {
            'content-type': 'application/json',
          },
          body: JSON.stringify(body),
        }
    }

    return $fetch(url, { ...init, method: 'POST' }).then((x) => ({
      ...x,
      data: x.data && clean ? cleanUrls(x.data, config) : x.data,
    }))
  },
})

export type UmbracoApi = ReturnType<typeof getUmbracoApi>

export const getUmbracoApi = (config: Config) => {
  const instance = getInstance(config)
  return {
    children: (id: string, params: SearchParamsObj = {}) => instance.get(`/content/${id}/children`, {
      params,
    }),
    like: (pageId: string, value: boolean) => instance.post(`/api/like/${pageId}`, {
      value,
    }),
    comment: (pageId: string, text: string) => instance.post('/api/comment', {
      pageId,
      text,
    }),
    umbracoUser: () => instance.get('/api/user'),
    root: () => instance.get('/content'),
    type: (type: string, params: SearchParamsObj = {}) => instance.get('/content/type', {
      params: {
        contentType: type,
        ...params,
      },
    }),
    url: (url: string) => instance.get('/content/url', {
      params: {
        url,
      },
    }),
    id: (id: string) => instance.get(id),
    search: (term: string, hyperlinks = false, page = 1, pageSize = 10) => instance.get('/content/search', {
      params: {
        term,
        hyperlinks,
        page,
        pageSize,
      },
    }),
    submitForm: async (formId: string, data: Record<string, any>) => instance.post(`/forms/${formId}/entries`, data),
    cleanUrls: (obj: any) => cleanUrls(obj, config),
    async formDefinition(id: string) {
      const { data } = await instance.get(`/forms/${id}`)
      return data
    },
    postGraphQlQuery: (query: string, removePortalPrefix = true) => instance
      .post(
        '/graphql',
        {
          query,
        },
        removePortalPrefix,
      )
      .then(({ data }) => data),
  }
}
