<template>
  <section
    :class="{transparent, narrow, hasImage, hasVideo}"
  >
    <img
      v-if="hasImage"
      ref="imageEl"
      :class="{background: true, hide: !backgroundUrl}"
      :src="backgroundUrl"
      alt="Hero"
      @load="setLoaded"
    >
    <video
      v-if="hasVideo"
      :class="{background: true, hide: !backgroundUrl}"
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
      <!-- <p class="prefix">
        {{ subtitle }}
      </p> -->

      <ul>
        <li>
          <span class="title">{{ title }}</span>

          <the-link
            v-if="target?.url"
            :href="target.url"
            :target="target.target"
            class="aa"
            data-gtm-button-type="cta"
          >
            <!-- {{ target.name || target.url }} -->
            Lees meer
          </the-link>
        </li>
      </ul>

      <!-- <rich-text
        v-if="body"
        :body="body"
      /> -->

      <slot name="bottom" />
    </header>
  </section>
</template>

<script>
import { ref, computed, watch } from 'vue'
import useUmbracoImage from '../composables/useUmbracoImage'
import TheLink from './TheLink.vue'
import RichText from './RichText.vue'

export default {
  components: {
    TheLink, RichText,
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
  // color: white;
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
    // @include screen-fits-two-cards {
    //   height: 100%;
    //   position: absolute;
    // }

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

    margin-top: 136px;
    @include screen-fits-two-cards {
      // max-width: calc(50vw - 1.75rem);
      // margin-top: 136px;
      // padding-right: var(--space-larger);
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
        border-radius: 12px;
        background-color: rgba(229, 243, 246, 0.9);

        .title {
          display: block;
        }

        &::before {
          content: "";
          mask: url(../assets/info-circle-solid.svg);
          -webkit-mask: url(../assets/info-circle-solid.svg);
          mask-size: cover;
          -webkit-mask-size: cover;
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

    // ::v-deep(a, h1, h2, h3), h1,h2,h3 {
    //   color: white;
    // }
  }

  .prefix {
   // color: var(--color-accent-1);
    font-weight: 500;

    + h1
    {
      margin-top: -0.5em;
    }
  }

  //narrow variant

  // &.narrow {
  //   @include screen-fits-two-cards {
  //     --distance-from-middle: calc(var(--card-width) / 2 + var(--card-gap) / 2);
  //     header {
  //       margin-top: 0;
  //       padding-top: var(--space-large);
  //       padding-bottom: 4rem;
  //       max-width: calc(50vw + var(--distance-from-middle));
  //     }

  //     .beeldmerk {
  //       width: 37%;
  //     }

  //     .background {
  //       position: absolute;
  //       right: 0;
  //       top: 0;
  //       height: 100%;
  //       max-width: calc(50vw - var(--distance-from-middle));
  //     }
  //   }
  // }
}
</style>
