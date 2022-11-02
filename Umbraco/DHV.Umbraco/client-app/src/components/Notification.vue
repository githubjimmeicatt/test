<template>
  <div
    class="message"
  >
    <component :is="icon" />
    <span>{{ message }}</span>
  </div>
</template>

<script>

import CheckSquareSolid from '../assets/check-square-solid.svg'
import ExclamationTriangleSolid from '../assets/exclamation-triangle-solid.svg'
import InfoCircleSolid from '../assets/info-circle-solid.svg'

export default {
  components: { CheckSquareSolid, ExclamationTriangleSolid, InfoCircleSolid },
  props: {
    message: {
      type: String,
      required: true,
    },
    type: {
      default: 'info',
      required: false,
      validator(value) {
        return ['info', 'error', 'confirm'].includes(value)
      },
    },
  },
  computed: {
    icon() {
      if (this.type === 'error') {
        return 'ExclamationTriangleSolid'
      } if (this.type === 'confirm') {
        return 'CheckSquareSolid'
      }
      return 'InfoCircleSolid'
    },
  },
}
</script>

<style lang="scss" scoped>

.message {
    display: flex;
    align-items: center;
    border: 1px solid var(--color-base);
    background-color: var(--color-background-default);
    padding: var(--space-small);
    margin: var(--space-small) auto;
    color: var(--color-base);
    font-size: 1rem;
    font-weight:600;
}
.message span{
    display: inline-block;
    margin-left: var(--space-small)
}

</style>
