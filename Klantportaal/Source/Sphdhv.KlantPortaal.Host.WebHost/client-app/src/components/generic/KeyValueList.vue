<template>
    <dl class="KeyValueList">
        <template v-for="key in labelKeys">
            <dt :key="`${key}-dt`">{{labels[key]}}</dt>
            <dd :key="`${key}-dd`">{{object[key]}}</dd>
        </template>
    </dl>
</template>

<script>

export default {
    props: {
        labels: {
            type: Object,
            required: true
        },
        object: {
            type: Object,
            required: true
        }
    },
    computed: {
        labelKeys() {
            return Object.keys(this.labels || {});
        }
    }
}
</script>