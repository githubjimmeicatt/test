<template>
    <article class="newslettercards" v-for="item in items" :key="item.id">
        <div>
            <h2>{{ item.name }} </h2>
            <p class="date">{{ shortDate(item.publishDate) }}</p>
        </div>
        <p v-html="item.body" />
        <a :href="item.url"> Lees Meer ></a>
    </article>
</template>

<script lang="ts">

    import { shortDate } from '@/helpers/formatDate'

    export default {
        props: {
            items: {
                type: Array,
                default: () => [],
            },
        },
        setup() {
            return {
                shortDate,
            }
        },
    }
</script>

<style lang="scss" scoped>
    .newslettercards {
        background-color: var(--card-background-color, white);
        padding: 1.5rem;
        min-width: 200px;
        max-width: var(--max-text-width);
        margin-bottom: var(--space-small);
        margin-bottom: var(--space-small);
        border-radius: 0px 0px 12px 12px;
    }

    .newslettercards div {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
    }
</style>
