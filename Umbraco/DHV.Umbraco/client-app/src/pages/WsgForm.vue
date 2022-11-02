<template>
  <form-element v-bind="content" />
</template>

<script>
import { inject } from 'vue'
import FormElement from '../components/FormElement.vue'

export default {
  components: {
    FormElement,
  },
  setup() {
    return {
      content: inject('content'),
    }
  },
}
</script>
