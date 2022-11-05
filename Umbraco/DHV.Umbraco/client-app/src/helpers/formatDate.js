import parseDate from '@/icatt-heartcore/api/parse-date'

export function formatDate(date) {
  return parseDate(date)?.toLocaleDateString('nl-NL', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric',
  })
}

export default formatDate
