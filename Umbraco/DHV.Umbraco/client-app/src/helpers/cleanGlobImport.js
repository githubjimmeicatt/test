import { defineAsyncComponent } from 'vue'

function cleanKey(key) {
  return key && key.split('/').pop().split('.')[0].toLowerCase()
}

function cleanValue(value, isComponent) {
  if (typeof value !== 'function') return value?.default
  return isComponent
    ? defineAsyncComponent(value)
    : () => value().then((x) => x.default)
}

export default function cleanGlobImport(glob, isComponent = true) {
  const entries = Object.entries(glob)
  const mapped = entries.map(([key, value]) => [cleanKey(key), cleanValue(value, isComponent)])
  return Object.fromEntries(mapped)
}
