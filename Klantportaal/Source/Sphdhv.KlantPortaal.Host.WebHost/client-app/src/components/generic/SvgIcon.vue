<template>
    <span class="SvgIcon">
    </span>
</template>

<script>
let cache = new Map();

export default {
    props: {
        icon: {
            required: true,
            type: String
        }
    },
    computed: {
        src() {
            const { icon } = this;
            return require(`@/assets/icons/${icon}.svg`);
        }
    },
    async mounted() {
        const { src } = this;

        if (!cache.has(src)) {
            try {
                cache.set(src, fetch(src).then(r => r.text()));
            } catch (e) {
                cache.delete(src);
            }
        }
        if (cache.has(src)) {
            this.$el.innerHTML = await cache.get(src);
        }
    }
}
</script>