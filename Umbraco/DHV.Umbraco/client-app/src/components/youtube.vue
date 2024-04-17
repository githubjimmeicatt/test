<template>
    <section class="container ">

        <div data-embed-constrain="true" :data-embed-url="youtubeEmbedUrl" class="embed  richtext">
            <iframe :src="youtubeEmbedUrl" />
        </div>

    </section>

</template>

<script>

    // function getEmbedUrl(attrs) {
    //   const urlParts = attrs?.src?.split('/')
    //   if (!urlParts?.length) return null
    //   const id = urlParts[urlParts.length - 1]
    //   return `https://www.youtube.com/embed/${id}&autoplay=1`
    // }

    export default {
        inheritAttrs: false,
        props: {

            youtubeUrl: {
                type: String,
                default: '',
            },

            autoplay: {
                type: Boolean,
                default: false,
            },
        },
        setup(_, { attrs }) {
            return {
                attrs: {
                    ...attrs,

                },
            }
        },

        computed: {
            youtubeEmbedUrl() {
                const youtubeCode = this.youtubeUrl?.split('/').pop()
                return `https://www.youtube.com/embed/${youtubeCode}?autoplay=1&mute=1`
            },
        },

    }
</script>

<style lang="scss" scoped>
    @import "../assets/scss/_mixins.scss";

    section {
        display: flex;
        width: 100%;
        justify-content: center;

        .embed {
            width: 100%;

            @include screen-fits-two-cards {
                height: 70%;
                width: 70%
            }
        }

        iframe {
            border: none;
            margin: auto;
        }
    }
</style>
