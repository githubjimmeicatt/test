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
      <template #loading>
        <div class="overlay">
          <Spinner />
        </div>
      </template>
    </umbraco-icatt-form>
  </section>
</template>

<script>
import UmbracoIcattForm from '../icatt-heartcore/components/UmbracoIcattForm.vue'
import RichText from './RichText.vue'
import Spinner from '../assets/spinner.svg'

export default {
  components: {
    UmbracoIcattForm,
    RichText,
    Spinner,
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

// section {
//   background-color: var(--color-sph-accent-2) !important;
// }

:deep(button) {
  @include button-default;

  float: right;
  margin-inline-start: var(--space-small);
  border-radius: 0.75rem;
}

:deep(fieldset){
  border:none;
  padding:0px;
  margin:0px;
}

 ::v-deep(.is-stacked)  {
  display: flex;
  flex-direction: column;
}

::v-deep(textarea) {
  display: block;
}

::v-deep(.form-options-group), ::v-deep(.form-group){
  margin-bottom: var(--space-small);
}

::v-deep(legend), ::v-deep(.form-label) {
  font-weight: bold;
  display: inline-block;
  margin-bottom: var(--space-smaller);
  // position: absolute !important;
  // width: 1px !important;
  // height: 1px !important;
  // padding: 0 !important;
  // margin: -1px !important;
  // overflow: hidden !important;
  // clip: rect(0, 0, 0, 0) !important;
  // white-space: nowrap !important;
  // border: 0 !important;
}

::v-deep(.form-error){
  color: var(--color-error)
}

:deep(input[type=text]), :deep(textarea),:deep(input[type=email]), :deep(select), :deep(option) {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid var(--color-sph-accent-1);
  border-radius: 0.75rem;
}

::v-deep(input[type=date])  {
  display: block;
}

@include screen-fits-two-cards {
  :deep(h1),
  :deep(article),
  :deep(form) {
    width: 36rem;
    margin-inline: auto;
  }
}

.overlay {
  height: 100%;
  width: 100%;
}
</style>
