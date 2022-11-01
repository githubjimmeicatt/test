<template>
  <section class="container">
    <h1 v-if="title">
      {{ title }}
    </h1>
    <article
      v-if="intro"
      class="richtext"
    >
      <rich-text :body="intro" />
    </article>
    <umbraco-icatt-form v-bind="$props">
      <template #submit="{onSubmit}">
        <button
          class="form-button is-submit"
          data-gtm-button-type="form"
          type="button"
          @click="onSubmit"
        >
          Verzenden
        </button>
      </template>
    </umbraco-icatt-form>
  </section>
</template>

<script>
import UmbracoIcattForm from './UmbracoIcattForm.vue'
import RichText from './RichText.vue'

export default {
  components: {
    UmbracoIcattForm,
    RichText,
  },
  props: {
    title: {
      type: String,
      default: null,
    },
    intro: {
      type: String,
      default: null,
    },
    confirmation: {
      type: String,
      default: null,
    },
    form: {
      type: Object,
      default: () => ({}),
    },
  },
}
</script>

<style lang="scss" scoped>
    @import "../assets/scss/_mixins.scss";
main > section {
  &:nth-of-type(2) {
    background-color: #fff4ec;
  }
}

    button {
        @include button-default;
    }
</style>
