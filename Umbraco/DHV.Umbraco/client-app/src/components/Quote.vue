<template>
  <section

    class="container"
  >
    <article class="richtext">

      <img
        v-if="afbeelding && afbeelding.src"
        :src="afbeelding.src"
        alt="quote afbeelding" />
      <div>
        <svg viewBox="0 0 40 31" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M23.1579 30.8772C19.883 30.8772 18.2456 28.9279 18.2456 25.0292C18.2456 21.7544 21.0526 16.8421 26.6667 10.2924C32.2807 3.43079 36.4912 0 39.2982 0C39.7661 0 40 0.23391 40 0.701745C40 1.16958 39.3762 2.02727 38.1287 3.27484C37.5049 4.05457 36.2573 5.76997 34.386 8.42104C32.5146 11.0721 30.0195 14.6589 26.9006 19.1813C29.7076 19.1813 31.1111 20.9746 31.1111 24.5614C31.1111 28.7719 28.46 30.8772 23.1579 30.8772ZM5.1462 30.8772C1.7154 30.8772 0 28.9279 0 25.0292C0 21.7544 2.80702 16.8421 8.42105 10.2924C14.0351 3.43079 18.3236 0 21.2866 0C21.5984 0 21.7544 0.23391 21.7544 0.701745C21.7544 1.01364 21.2086 1.87133 20.117 3.27484C19.3372 4.05457 18.0117 5.76997 16.1404 8.42104C14.269 11.0721 11.7739 14.6589 8.65497 19.1813C11.462 19.1813 12.8655 20.9746 12.8655 24.5614C12.8655 28.7719 10.2924 30.8772 5.1462 30.8772Z" fill="#AA8787" />
        </svg>
        <p>{{quote}}
        </p>
        <div>
          <span v-if="auteur">- {{ auteur }}</span>
          <a v-if="link && link.url" :href="linkWithHttpFix" :target="linkTarget">{{link.name ? link.name : "lees meer" }} ></a>
        </div>
      </div>

    </article>
  </section>
</template>

<script>

export default {

  props: {
    contentTypeAlias: {
      type: String,
      default: '',
    },
    quote: {
      type: String,
      default: '',
    },
    auteur: {
      type: String,
      default: '',
    },
    afbeelding: {
      type: Object,
      default: null,
    },
    link: {
      type: Object,
      default: null,
    },

  },
  computed: {
    linkWithHttpFix() {
      if (!this.link || !this.link.url) {
        return ''
      }
      if (this.link.url.startsWith('https://') || this.link.url.startsWith('http://')) {
        return this.link.url
      }

      if (this.link.type === 'EXTERNAL') {
        return `https://${this.link.url}`
      }

      return 'mmmm'
    },
    linkTarget() {
      return this.link.type === 'EXTERNAL' ? '_blank' : '_self'
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

article {
    display: flex;
    width: 100%;
    gap: var(--space-medium);
        @include mobile {
gap: var(--space-small);
     }

    margin-block: var(--space-smaller);

}

svg{
    height: 60px;
    width:60px;;
    position: absolute;
    top:-20px;
    left:40px;

        @include mobile {

           height: 30px;
    width:30px;;

    top:-10px;
    left:20px;

        }
}

article>div {
    position: relative;
    border-bottom: 3px solid #dcd7d7;
    box-shadow: 0 2px 0.3rem rgb(0 0 0 / 9%);

    background-color: var(--color-background-standout);
    border-radius: var(--border-radius-medium);
    ;
    padding: var(--space-medium);
    padding-inline-start: 7rem;
        @include mobile {
padding-inline-start: 2rem;
     }

    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: var(--space-medium);

    p {
        padding: 0px;
        margin: 0px;
        font-style: italic;
    }

    div {
        display: flex;
        justify-content: space-between;
        flex-direction: row;
   @include mobile {
 flex-direction: column;
 gap:var(--space-smaller);
     }

        padding: 0px;

    }

}

img {
    width: 100%;
    border-radius: 50%;
    border: 1px solid transparent;
    width: 140px;
    height: 140px;
    margin-block-start: var(--space-smaller);
    object-position: center;
    object-fit: cover;
    flex: 0 0 144px;

      @include mobile {

          width: 80px;
          height: 80px;
          flex: 0 0 80px;

      }

}

::v-deep(h1) {
    font-size: 1.25rem;
    margin: 0;
}

::v-deep(.subtitle) {
    text-transform: capitalize;
    margin-block: var(--space-smaller);
}

.article-inner {
    padding: 1.5rem;
}
</style>
