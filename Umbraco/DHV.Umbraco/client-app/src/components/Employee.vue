<template>
  <card>
    <lazy-img
      v-if="photo"
      class="profielfoto"
      :src="photo"
    />
    <h1 v-if="fullName">
      {{ fullName }}
    </h1>
    <p
      v-if="role"
      class="toptitle"
    >
      {{ role }}
    </p>
  </card>
</template>

<script>
import Card from './Card.vue'
import LazyImg from './LazyImg.vue'

export default {
  components: {
    Card,
    LazyImg,
  },
  props: {
    photo: {
      type: [Object, String],
      default: null,
    },
    fullName: {
      type: String,
      default: '',
    },
    role: {
      type: String,
      default: '',
    },
  },
}
</script>

<style lang="scss" scoped>
.toptitle {
  margin-top: 0;
}

.profielfoto {
  width: 6rem;
  height: 6rem;
  margin-bottom: var(--space-small);
}
</style>
