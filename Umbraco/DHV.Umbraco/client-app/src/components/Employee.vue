<template>
  <card>
    <figure>
      <lazy-img
        v-if="photo"
        class="profielfoto"
        :src="photo"
      />

      <!-- <img
        src="https://media.umbraco.io/dev-pensioenfonds-haskoningdhv/foudex5c/image-42.png"
        alt=""
      > -->

      <figcaption v-if="fullName">
        {{ fullName }}
      </figcaption>
    </figure>

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
figure {
  margin: 0;

   figcaption {
    font-weight: 600;
    padding-block: var(--space-smaller);
   }
}
.profielfoto {
  max-width: 10rem;
  margin-bottom: var(--space-small);
}
</style>
