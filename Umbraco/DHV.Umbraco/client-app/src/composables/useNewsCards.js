import {
  inject, ref, watch, isReactive,
} from 'vue'
import formatDate, { parseDate } from '../helpers/formatDate'

export default function useNewsCards(parentId, params = {
  pageNumber: '1',
  pageSize: '100', // voor nu hoog zetten, paginering gebeurd nu nog volledig op de client, geen nieuwe server callbacks
}) {
  const portal = inject('portal')
  const items = ref([])
  const parentIdRef = isReactive(parentId)
    ? parentId
    : ref(parentId)
  watch([parentIdRef], async (i) => {
    if (!i) return

    const articles = await portal.fetchChildren(i, params)
    items.value = articles.map(({
      summary, name, _url, image, publishDate, _createDate,
    }) => {
      const date = parseDate(publishDate) || parseDate(_createDate)
      return {
        body: summary,
        title: name,
        date,
        subtitle: formatDate(date),
        target: { url: _url, name: 'Lees meer' },
        image,
      }
    })
      .sort((a, b) => b.date - a.date)
  }, { immediate: true })
  return items
}
