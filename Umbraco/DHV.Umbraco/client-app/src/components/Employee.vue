<template>
  <card>
    <figure>
      <img
        v-if="photo"
        class="profielfoto"
        :src="photo.src"
        alt="profielfoto"
      />

      <figcaption v-if="fullName">
        {{ fullName }}
      </figcaption>
    </figure>

    <p v-if="role" class="toptitle">
      {{ role }}
    </p>

    <ul>
      <li
        v-if="telefoonnummer"
        class="contact-icon phone"
      >
        {{ telefoonnummer }}
      </li>
      <li
        v-if="linkedIn?.url"
        class="contact-icon linkedin"
      >
        <the-link
          :href="linkedIn.url"
          :target="linkedIn.target"
        >
          {{ linkedIn.name || 'LinkedIn' }}
        </the-link>
      </li>
    </ul>
  </card>
</template>

<script>
import Card from './Card.vue'
import LazyImg from './LazyImg.vue'
import TheLink from './TheLink.vue'

export default {
  components: {
    Card,
    LazyImg,
    TheLink,
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
    telefoonnummer: {
      type: String,
      default: '',
    },
    linkedIn: {
      type: Object,
      default: () => {},
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

figure {
  margin: 0;

   figcaption {
    font-weight: 600;
    padding-block: var(--space-smallest);
   }
   img{
    width: 100%;
    max-height: 150px;

   }
}
.profielfoto {
  //width: min(100%, 25rem);
}

ul {
  @include reset-list;
  margin-block-end: var(--space-smallest);

  .contact-icon {
    font-size:  0.875rem;
    padding-block: var(--space-smallest);
    @include contact-icons(#000, 0.1rem);
  }
}
</style>
