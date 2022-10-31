export function parseDate(dateString) {
  if (!dateString || dateString === '0001-01-01T00:00:00') return null
  return dateString instanceof Date
    ? dateString
    : new Date(dateString)
}

export function formatDate(date) {
  return parseDate(date)?.toLocaleDateString('nl-NL', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric',
  })
}

export default formatDate
