<template>
  <section class="container" v-if="form">
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
import { UmbracoIcattForm } from 'icatt-heartcore'
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
      default: null,
    },
  },
}
</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

:deep(*:not(h1)) {
  font-family: 'Open Sans', sans-serif;
  font-size: 1rem;
}

:deep(button) {
  @include button-default;

  float: right;
  margin-inline-start: var(--space-small);
}

:deep(fieldset) {
  border: none;
  padding: 0;
  margin: 0;
}

 :deep(.is-stacked) {
  display: flex;
  flex-direction: column;
}

:deep(textarea) {
  display: block;
}

:deep(.form-options-group), :deep(.form-group) {
  margin-bottom: var(--space-small);
}

:deep(legend), :deep(.form-label) {
  font-weight: 600;
  display: inline-block;
  margin-bottom: var(--space-smaller);
}

:deep(.form-error) {
  color: var(--color-error);
  padding-block-start: var(--space-smallest);
}

:deep(input[type=text]), :deep(textarea), :deep(input[type=email]), :deep(select) {
  width: 100%;
  padding: var(--space-smaller);
  border: 1px solid var(--color-sph-accent-1);
  border-radius: 0.75rem;
}

:deep(input[type=date]) {
  display: block;
}

:deep(h1),
:deep(article),
:deep(form) {
  width: min(100%, 40rem);
  margin-inline: auto;
}

.overlay {
  height: 100%;
  width: 100%;
}
</style>
