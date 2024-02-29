<template>
    <span class="SvgIcon" v-html="svg">
    </span>
</template>

<script>
const glob = import.meta.glob('../../assets/icons/*.svg', {
    query: '?url',
    eager: true,
    import: 'default'
})
const entries = Object.entries(glob).map(([key,value]) => [key.split('/').at(-1)?.split('.')[0],fetch(value).then(r => r.text())])
const icons = new Map(entries)
export default {
    props: {
        icon: {
            required: true,
            type: String
        }
    },
    data: () => {
        return {
            svg: ''
        }
    },
    computed: {
        src() {
            const { icon } = this;
            return icons.get(icon)
        }
    },
    async mounted() {
        const { src } = this;
        if(src) {
            this.svg = await src;
        }
    }
}
</script>