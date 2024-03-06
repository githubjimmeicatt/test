<template>
    <dl class="KeyValueList">
        <template v-for="key in labelKeys" :key="`${key}-dt`">
            <dt>{{labels[key]}}</dt>
            <dd>{{object[key]}}</dd>
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