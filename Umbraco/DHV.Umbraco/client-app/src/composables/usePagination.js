import { computed } from 'vue'
import { useRoute } from 'vue-router'

const chunk = (array, chunkSize) => Array(Math.ceil(array.length / chunkSize))
  .fill()
  .map((_, index) => index * chunkSize)
  .map((begin) => array.slice(begin, begin + chunkSize))

export default function usePagination(items, pageSize = 12) {
  const route = useRoute()
  const currentPageIndex = computed(() => {
    const { page } = route.query
    const pageNo = Number.parseInt(page, 10)
    return Number.isNaN(pageNo)
      ? 0
      : Math.max(0, pageNo - 1)
  })
  const pages = computed(() => chunk(items.value, pageSize))
  const currentPage = computed(() => pages.value[currentPageIndex.value] || [])
  const pagination = computed(() => {
    const path = route.path.replace(/\/$/, '')
    const currentIndex = currentPageIndex.value
    return pages.value.map((_, i) => ({
      pageNumber: i + 1,
      isCurrent: i === currentIndex,
      to: `${path}?page=${i + 1}`,
    }))
  })
  return {
    currentPage,
    pagination,
  }
}
