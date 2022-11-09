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
        <li v-if="$slots.above">
          <slot name="above" />
        </li>
        <li>
          <span class="title">{{ title }}</span>

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
import useUmbracoImage from '../composables/useUmbracoImage'
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

      watch(backgroundUrl, () => {
        loading.value = true
      })
    } else if (hasVideo.value) {
      backgroundUrl = ref(props.backgroundImage._url)
      loading.value = false
    }

    const transparent = computed(() => backgroundUrl.value && !loading.value)

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
  background-color: var(--color-base);
  position: relative;
  transition: background-color 0ms;

  .beeldmerk {
    position: absolute;
    transition: all 250ms ease-in;
    width: 28rem;
    transform: translate(-66.6%, -50%);
    display: block;
    opacity: 0;

    @include screen-fits-three-cards {
      opacity: 100%;
      width: min(28rem, 28vw);
    }
  }

  &.transparent {
    background-color: transparent;
    transition: background-color 250ms ease-in;
  }

  &.hasImage, &.hasVideo {
    .beeldmerk {
      opacity: 100%;
    }
  }

  .background {
    display: block;
    max-width: unset;
    margin: unset;
    z-index: -1;
    width: 100%;
    height: 16rem;
    object-fit: cover;
    object-position: center;

    height: 100%;
    position: absolute;

    &.hide {
      opacity: 0;
    }
  }

  header {
    > * {
      position: relative;
      margin: 0;
    }

    font-size: 0.875rem;

    padding-block: var(--space-medium);
    padding-inline: var(--dynamic-spacing-medium);
    margin-block-start: var(--space-medium);

    @include screen-fits-two-cards {
      padding-left: calc(50vw - 1.75rem);
      padding-right: var(--dynamic-spacing-large);
    }

    ul {
      list-style: none;
      padding: 0;
      margin: 0;

      display: flex;
      flex-direction: column;
      gap: 1rem;

      li {
        position: relative;
        padding-block: var(--space-smaller);
        padding-inline: var(--space-medium);
        border-radius: 0.75rem;
        background-color: rgba(229, 243, 246, 0.9);

        .title {
          display: block;
        }

        &::before {
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
      border-left: solid var(--dynamic-spacing-large) white;
      border-right: solid var(--dynamic-spacing-large) white;

      header {
        padding-inline-end: var(--space-medium);
      }
    }
  }
}
</style>
