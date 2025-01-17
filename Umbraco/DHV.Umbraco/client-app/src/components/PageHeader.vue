<template>
  <section
    :class="{
      transparent, narrow, hasImage, hasVideo,
    }"
  >
    <img
      v-if="hasImage"
      ref="imageEl"
      :class="{ background: true, hide: !backgroundUrl }"
      :src="backgroundUrl"
      alt="Hero"
      @load="setLoaded"
    >
    <video
      v-if="hasVideo"
      :class="{ background: true, hide: !backgroundUrl }"
      autoplay
      muted
      loop
    >
      <source
        :src="backgroundUrl"
        type="video/mp4"
      >
    </video>

    <header>
      <ul>
        <li v-if="$slots.above" class="header-highlight">
          <slot name="above" />
        </li>

        <li class="header-info" v-if="title || target?.url">
          <span class="title" v-if="title">{{ title }}</span>

          <the-link
            v-if="target?.url"
            :href="target.url"
            :target="target.target"
            class="aa"
            data-gtm-button-type="cta"
          >
            Lees meer
          </the-link>
        </li>
      </ul>

      <slot name="bottom" />
    </header>
  </section>
</template>

<script>
import { ref, computed, watch } from 'vue'
import { useUmbracoImage } from 'icatt-heartcore'
import TheLink from './TheLink.vue'

export default {
  components: {
    TheLink,
  },
  props: {
    narrow: {
      type: Boolean,
      default: false,
    },
    backgroundImage: {
      type: Object,
      default: () => ({}),
    },
    body: {
      type: String,
      default: '',
    },
    title: {
      type: String,
      default: '',
    },
    subtitle: {
      type: String,
      default: '',
    },
    target: {
      type: Object,
      default: () => ({}),
    },
  },
  setup(props) {
    const imageEl = ref(null)
    const loading = ref(true)
    const setLoaded = () => {
      loading.value = false
    }

    let backgroundUrl = ref('')

    const hasImage = computed(() => !!props.backgroundImage && props.backgroundImage.mediaTypeAlias === 'Image')
    const hasVideo = computed(() => !!props.backgroundImage && props.backgroundImage.mediaTypeAlias === 'File' && props.backgroundImage.umbracoExtension === 'mp4')

    if (hasImage.value) {
      backgroundUrl = useUmbracoImage(() => props.backgroundImage, imageEl)

      watch(() => backgroundUrl.value?.split('?')?.[0], () => {
        loading.value = true
      })
    } else if (hasVideo.value) {
      backgroundUrl = ref(props.backgroundImage._url)
      loading.value = false
    }

    const transparent = computed(() => backgroundUrl.value && loading.value)

    return {
      transparent,
      setLoaded,
      imageEl,
      backgroundUrl,
      loading,
      hasImage,
      hasVideo,
    }
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

section {
  position: relative;
  aspect-ratio: 3/1;
  display: flex;
  justify-content: flex-end;
  padding-block: var(--space-medium);
  padding-inline: var(--dynamic-spacing-large);

  .background {
    opacity: 100;
    transition: opacity 250ms ease-in;
    position: absolute;
    inset: 0;
    inline-size: 100%;
    block-size: 100%;
    object-fit: cover;
    object-position: center;

    &.hide {
      opacity: 0;
    }
  }

  &.transparent .background {
      opacity: 0;
    }

  header {
    > * {
      position: relative;
      margin: 0;
    }

    font-size: 0.875rem;
    display: grid;

    ul {
      list-style: none;
      padding: 0;
      margin: 0;

      display: flex;
      flex-direction: column;
      justify-content: flex-end;
      gap: 1rem;

      li {
        position: relative;
        max-width: 22rem;
        padding-block: var(--space-smaller);
        padding-inline: var(--space-medium);
        border-radius: 0.75rem;
        background-color: rgba(229, 243, 246, 0.9);
        box-shadow: 0 0 0.5rem rgba(0, 0, 0, 0.2);

        .title {
          display: block;
        }

        &.header-highlight {
          padding-block: var(--space-small);
          background-color: rgba(255, 255, 255, 0.9);
          margin-block-end: 0;
        }

        &.header-info::before {
          content: "";
          mask: url(../assets/info-circle-solid.svg) center / cover;
          -webkit-mask: url(../assets/info-circle-solid.svg) center / cover;
          position: absolute;
          left: calc(var(--space-medium) / 2);
          top: calc(var(--space-smaller) + 0.1rem);
          transform: translateX(-50%);
          width: 1rem;
          height: 1rem;
          background-color: var(--color-base);
        }
      }
    }

    h1 {
      font-size: 2.25em;
      margin-bottom:  var(--space-smaller);
      color: white;
    }

    p {
      line-height: 1.75em;
    }
  }

  .prefix {
    font-weight: 600;

    + h1
    {
      margin-top: -0.5em;
    }
  }

  //narrow variant

  &.narrow {
    @include screen-fits-two-cards {
      margin-inline: var(--dynamic-spacing-large);
      padding-inline: var(--space-small);
    }
  }
}
</style>
