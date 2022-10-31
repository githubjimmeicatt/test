<template>
  <section class="container">
    <h1 v-if="content.title">
      {{ content.title }}
    </h1>
    <article
      v-if="content.intro"
      class="richtext"
    >
      <rich-text :body="content.intro" />
    </article>
    <umbraco-icatt-form v-bind="content">
        <template v-slot:submit="{onSubmit}">
            <button class="form-button is-submit"
                    data-gtm-button-type="form"
                    type="button"
                    @click="onSubmit">
                Verzenden
            </button>
        </template>
        </umbraco-icatt-form>
  </section>
</template>

<script>
import { inject } from 'vue'
import UmbracoIcattForm from '../components/UmbracoIcattForm.vue'
import RichText from '../components/RichText.vue'

export default {
  components: {
    UmbracoIcattForm,
    RichText,
  },
  setup() {
    return {

      content: inject('content'),
    }
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
