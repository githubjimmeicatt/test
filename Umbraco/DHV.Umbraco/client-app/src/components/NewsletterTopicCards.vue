<template>
    <article class="newslettercard" v-for="item in items" :key="item.id">
        <div class="newslettercontent">
            <div>
                <h2>{{ item.name }}</h2>
            </div>
            <div class="image-and-paragraph">
                <div class="image">
                    <img v-if="item.afbeelding?.url" class="img" :src="item.afbeelding.url" />
                </div>
                <div class="paragraph">
                    <p v-html="item.samenvatting" />
                    <a :href="item.url"> Lees meer > </a>
                </div>
            </div>

        </div>
    </article>
</template>

<script lang="ts">
    export default {

        props: {
            items: {
                type: Array,
                default: () => [],
            },
        },
        data() {
            return {
                isMobile: false,
            }
        },

    }
</script>
<style lang="scss" scoped>
    .newslettercard {
        background-color: var(--card-background-color, white);
        padding: 1.5rem;
        min-width: 420px;
        max-width: var(--max-text-width);
        margin-bottom: var(--space-small);
        margin-bottom: var(--space-small);
        border-radius: 0px 0px 12px 12px;
        display: flex;
        border-left-style: solid;
        border-color: var(--color-sph-accent-1);
        border-left-width: 6px;
    }

    .img {
        max-width: 100%;
        max-height: 100%;
    }

    .paragraph {
        padding-left: 1.5em;
        display: table-cell;
        vertical-align: top;
        min-width: 66%;
    }

    ::v-deep p > p {
        margin-block-start: 0em;
    }

    .paragraph p {
        align-self: flex-start;
        margin-block-start: 0em;
    }

    .image {
        align-items: center;
        max-width: 18em;
        min-width: 33%;
    }

    .image-and-paragraph {
        display: flex;
        flex-direction: row;
        align-items: flex-start;
        flex-wrap: nowrap;
    }

    .newslettercontent {
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
    }

    .newslettercard img {
        display: inline;
    }

    @media screen and (max-width: 768px) {
        .newslettercard {
            min-width: unset;
            max-width: 100%;
            flex-direction: column;
        }

        .image-and-paragraph {
            flex-direction: column;
        }

        .paragraph {
            padding-bottom: 1.5em;
        }

        .paragraph,
        .image {
            min-width: unset;
            max-width: 100%;
            padding-left: 0;
        }

        .image {
            order: 2;
        }
    }
</style>
