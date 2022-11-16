import axios from 'axios'

const instance = axios.create()

function cleanUrls(data, key = '', parentKey = '', portalPrefix = window.UMBRACO_PORTAL?.prefix) {
  if (!data) return data
  if (Array.isArray(data)) return data.map((x) => cleanUrls(x, key, parentKey))
  if (typeof data === 'object') {
    return Object.fromEntries(Object.entries(data).map(([childKey, val]) => [childKey, cleanUrls(val, childKey, key)]))
  }

  // replace secure media url's and portanames from url's
  if (typeof data === 'string') {
    let dataWithCustomUrls = data

    if (window.UMBRACO_PORTAL?.isSecure) {
      dataWithCustomUrls = dataWithCustomUrls.replace(/https:\/\/media\.umbraco\.io.*william-schrikker\//g, '/umbracomedia/')
    }

    if (portalPrefix && dataWithCustomUrls.includes(portalPrefix)) {
      if ((['url', 'href'].some((x) => key?.toLowerCase().includes(x)) || parentKey?.toLowerCase().includes('urls'))) {
        dataWithCustomUrls = dataWithCustomUrls.replace(portalPrefix, '')
      } else {
        dataWithCustomUrls = dataWithCustomUrls.replaceAll(`href="${portalPrefix}/`, 'href="/')
      }
    }

    return dataWithCustomUrls
  }

  return data
}

instance.interceptors.response.use((res) => {
  // eslint-disable-next-line no-param-reassign
  res.data = cleanUrls(res.data)
  return res
}, (error) => {
  if (window?.location && error && error.response === undefined) {
    // gebruiker is uitgelogd.
    // pagina verversen, dan wordt de gebruiker naar de SSO geredirect
    window.location.reload()
  }
  throw error
})

export const api = {
  children: (id, params = {}) => instance.get(`/content/${id}/children`, {
    params,
  }),
  like: (pageId, value) => instance.post(`/api/like/${pageId}`, {
    value,
  }),
  comment: (pageId, text) => instance.post('/api/comment', {
    pageId, text,
  }),
  umbracoUser: () => instance.get('/api/user'),
  root: () => instance.get('/content'),
  type: (type, params = {}) => instance.get('/content/type', {
    params: {
      contentType: type,
      ...params,
    },
  }),
  url: (url) => instance.get('/content/url', {
    params: {
      url,
    },
  }),
  id: (id) => instance.get(id),
  search: (term, hyperlinks = false, page = 1, pageSize = 10) => instance.get('/content/search', {
    params: {
      term,
      hyperlinks,
      page,
      pageSize,
    },
  }),
  submitForm: async (formId, data) => instance.post(`/forms/${formId}/entries`, data),
  cleanUrls,
  /**
   *
   * @param {string} id
   * @returns {Promise<import('@umbraco/headless-forms-react/types').Form>}
   */
  async formDefinition(id) {
    const { data } = await instance.get(`/forms/${id}`)
    return data
  },
  postGraphQlQuery: (query, removePortalPrefix = true) => {
    const axiosOrInstance = removePortalPrefix ? instance : axios
    return axiosOrInstance.post('/graphql', {
      query,
    }).then(({ data }) => data)
  },
}

export class Portal {
  constructor(id) {
    this.instance = instance
    this.api = api
    this.id = id
    this.prefix = window.UMBRACO_PORTAL?.prefix || `/${window.location.pathname.split('/')[1]}`
  }

  async fetchChildren(id, params) {
    const resp = await this.api.children(id, params)
    return resp.data._embedded?.content.map((x) => ({
      ...x,
      id: x._id,
    })) ?? []
  }

  async postLike(id, value) {
    const data = await this.api.like(id, value)
    return data
  }

  async postComment(id, text) {
    const data = await this.api.comment(id, text)
    return data
  }

  async GetUmbracoUser() {
    const { data } = await this.api.umbracoUser()
    return data
  }

  async fetchPage(path) {
    try {
      const { data } = await this.api.url(path)
      return data
    } catch (error) {
      throw new Error(error?.response?.status || 500)
    }
  }

  static async search(query) {
    const { data } = await api.search(query)
    return data
  }

  async fetchUrl(item, linkpath) {
    if (!item?._links || !item?._id || !linkpath) return null
    if (item[linkpath]?._url) return item[linkpath]._url
    const cacheKey = `${item._id}${linkpath}`
    if ([undefined, null].includes(this.cache[cacheKey])) {
      const href = item._links[linkpath.toLowerCase()]?.href
      if (!href) return null
      const response = await this.instance.get(href)
      this.cache[cacheKey] = response?.data?._url
    }

    return this.cache[cacheKey]
  }

  fetchById(id) {
    return this.api.id(id).then((r) => r?.data)
  }

  isHome(id) {
    return id === this.id
  }

  async submitForm(formId, data) {
    const response = await this.api.submitForm(formId, data)
    return response
  }
}

export default api
