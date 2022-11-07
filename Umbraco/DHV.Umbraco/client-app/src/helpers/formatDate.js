import parseDate from '@/icatt-heartcore/api/parse-date'

export function formatDate(date) {
  return parseDate(date)?.toLocaleDateString('nl-NL', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric',
  })
}

export function shortDate(date) {
  return parseDate(date)?.toLocaleDateString('nl-NL', {
    day: '2-digit', month: '2-digit', year: 'numeric',
  })
}

export default formatDate
