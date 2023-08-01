import { parseUmbracoDate } from 'icatt-heartcore'

export function formatDate(date) {
  return parseUmbracoDate(date)?.toLocaleDateString('nl-NL', {
    weekday: 'long', day: 'numeric', month: 'long', year: 'numeric',
  })
}

export function formatMonthYear(date) {
  return parseUmbracoDate(date)?.toLocaleDateString('nl-NL', {
    month: 'long', year: 'numeric',
  })
}

export function shortDate(date) {
  return parseUmbracoDate(date)?.toLocaleDateString('nl-NL', {
    day: '2-digit', month: '2-digit', year: 'numeric',
  })
}

export function isoDate(date) {
  return parseUmbracoDate(date)?.toLocaleDateString('en-CA', {
    day: '2-digit', month: '2-digit', year: 'numeric',
  })
}

export default formatDate
