<template>
  <div
    v-if="attrs?.src"
    :class="aspectRatio"
  >
    <iframe
      v-bind="attrs"
    />
  </div>
</template>

<script>

function getEmbedUrl(attrs) {
  const urlParts = attrs?.src?.split('/')
  if (!urlParts?.length) return null
  const id = urlParts[urlParts.length - 1]
  return `https://www.youtube.com/embed/${id}`
}

export default {
  inheritAttrs: false,
  props: {
    aspectRatio: {
      type: String,
      default: '16:9',
    },
  },
  setup(_, { attrs }) {
    return {
      attrs: {
        ...attrs,
        src: getEmbedUrl(attrs),
      },
    }
  },
}
</script>

<style lang="scss" scoped>
div {
  position: relative;
  padding-bottom: 56.25%;

  &.\4\:3 {
    padding-bottom: 75%;
  }
}

iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
</style>
