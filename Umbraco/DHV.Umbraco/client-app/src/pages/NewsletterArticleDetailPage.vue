<template>
    <section class="container topimage">
        <lazy-img v-if="content.afbeelding"
                  :src="content.afbeelding.src" />
    </section>
    <breadcrumbs class="breadcrumbs" />

    <section class="intro-container container">
        <article class="article-name">
            <h1>{{ content.name }}</h1>

            <p v-if="date" class="article-date">
                {{ date }}
            </p>

            <rich-text :body="content.body" />
        </article>
    </section>

    <section class="articletext">

        <div v-html="content.artikel" />

    </section>
</template>

<script lang="ts">
    import { inject, computed } from 'vue'
    import RichText from '@/components/RichText.vue'
    import LazyImg from '@/components/LazyImg.vue'
    import { formatDate } from '@/helpers/formatDate'
    import Breadcrumbs from '@/components/Breadcrumbs.vue'

    export default {
        components: {
            RichText, LazyImg, Breadcrumbs,
        },

        setup() {
            const content = inject < any > ('content')

            return {
                content,
                date: computed(() => {
                    const { publishDate, _createDate } = content.value ?? {}
                    return formatDate(publishDate) || formatDate(_createDate)
                }),
            }
        },
    }

</script>

<style scoped lang="scss">

    .articletext {
        padding: var(--space-medium) var(--dynamic-spacing-large);
    }

    ::v-deep.articletext > div p > img {
        max-width: 50em;
        width: 100%;
        object-fit: cover;
        object-position: center;
    }

    ::v-deep > p {
        max-width: 50em;
        line-height: 1.5em;
    }

    .topimage {
        padding-block: 0;

        img {
            width: 100%;
            height: 20rem;
            object-fit: cover;
            object-position: center;
        }
    }

    .article-name h1 {
        margin-bottom: 4px;
    }

    .article-date {
        margin-top: 0;
    }

    .intro-container {
        padding-bottom: 0;
    }
</style>
