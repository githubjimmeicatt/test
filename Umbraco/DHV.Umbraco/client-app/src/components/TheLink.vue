<template>
  <component
    v-bind="props"
    :is="comp"
  >
    <slot />
  </component>
</template>

<script>
function isExternalURL(url) {
  return url && !url.startsWith('#') && (!url.startsWith('/'))
}

function isUmbracoSecureFile(url) {
  return url && url.toLowerCase().startsWith('/umbracomedia')
}

export default {
  inheritAttrs: false,
  setup(_, context) {
    const { attrs } = context
    let href = attrs.href || '#'
    const isLocal = !isExternalURL(href)
    if (!isLocal) {
      if (href.includes('@') && href.includes('.') && !href.includes('mailto:')) {
        href = `mailto:${href}`
      } if (!href.includes(':') && href.includes('.')) {
        href = `https://${href}`
      }
    }

    const comp = isLocal && !isUmbracoSecureFile(href)
      ? 'router-link'
      : 'a'

    const additionalProps = comp === 'a'
      ? { href, rel: 'noopener noreferrer', target: context.attrs.target || '_blank' }
      : { to: href }

    const props = {
      ...attrs,
      ...additionalProps,
    }

    return { comp, props }
  },
}
</script>
