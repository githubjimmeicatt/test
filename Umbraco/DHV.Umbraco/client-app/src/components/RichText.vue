<template>
  <span
    :id="id"
    ref="bodyEl"
    class="richtext"
  />
</template>

<script>
import { onBeforeUnmount, ref, watch } from 'vue'
import DOMPurify from 'dompurify'

// wrap tables
DOMPurify.addHook('afterSanitizeElements', (node) => {
  if (!(node instanceof HTMLTableElement) || !node.parentElement || node.parentElement.classList.contains('table-wrapper')) return
  const wrapper = document.createElement('div')
  wrapper.classList.add('table-wrapper')
  node.parentNode?.insertBefore(wrapper, node)
  wrapper.appendChild(node)
})

let idCounter = 0

const getClassName = (id) => `${id}_inserted`
const parser = new DOMParser()

function clean(el, id) {
  if (!el) return
  const existing = el.parentElement.getElementsByClassName(getClassName(id))
  while (existing.length > 0) {
    el.parentElement.removeChild(existing[0])
  }
}

/**
 * @param {HTMLElement} el
 * @param {String} bodyStr
 */
function replaceWithString(el, bodyStr, id) {
  if (!el) return null
  clean(el)
  const nodesFragment = document.createDocumentFragment()
  const attributes = Array.from(el.attributes)
  const unsanitized = bodyStr || '<p/>'
  const sanitized = DOMPurify.sanitize(unsanitized, { ADD_TAGS: ['iframe'], ADD_ATTR: ['target'], FORBID_ATTR: ['style'] })
  const { body } = parser.parseFromString(sanitized, 'text/html')
  const className = getClassName(id)
  Array.from(body.children).forEach((newEl) => {
    attributes.forEach((attr) => {
      if (attr.name === 'id') return
      if (attr.name === 'class') {
        newEl.classList.add(...attr.value.split(' '))
      } else {
        newEl.setAttribute(attr.name, attr.value)
      }
    })
    newEl.classList.add(className)
    nodesFragment.appendChild(newEl)
  })
  return el.parentElement.insertBefore(nodesFragment, el)
}

export default {
  props: {
    body: {
      type: String,
      default: '',
    },
  },
  setup(props) {
    // eslint-disable-next-line no-multi-assign
    const id = `richtext_${idCounter += 1}`
    const bodyEl = ref(null)
    watch([bodyEl, () => props.body], ([e, b]) => {
      replaceWithString(e, b, id)
    })
    onBeforeUnmount(() => {
      clean(bodyEl.value, id)
    })
    return {
      bodyEl,
      id,
    }
  },
}
</script>

<style lang="scss">
[data-embed-url], .embed, .Embed {
  position: relative;
  padding-bottom: 56.25%;
  margin-top: auto;
  margin-bottom: var(--space-medium);
  max-width: unset !important;

  > iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    margin: var(--space-small) 0;
  }
}
</style>
