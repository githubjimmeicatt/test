/* eslint-disable no-param-reassign */
<template>
  <slot
    v-if="error"
    name="error"
    :message="errorMessage"
  >
    <div class="error">
      {{ errorMessage }}
    </div>
  </slot>

  <slot
    v-else-if="success"
    name="success"
    :message="successMessage"
  >
    <article
      class="richtext success"
    >
      <rich-text :body="successMessage?.value || successMessage" />
    </article>
  </slot>

  <slot
    v-else-if="loading"
    name="loading"
  >
    <div class="overlay">
      <Spinner />
    </div>
  </slot>

  <vue-form
    v-else-if="icattVueForm"
    :form="icattVueForm"
  >
    <component
      :is="getInputTemplateType(item.type)"
      v-for="item in displayableFormItems"
      :key="item.alias"

      :form-element="item"
    />
    <slot 
          name="submit"
          :onSubmit="onSubmit">
        <button class="form-button is-submit"
                type="button"
                @click="onSubmit">
            Verzenden
        </button>
    </slot>
  </vue-form>
</template>

<script>

import { computed } from 'vue'
import Spinner from '../assets/spinner.svg'
import useUmbracoForm from '../composables/useUmbracoForm'
import RichText from './RichText.vue'

export default {
  components: { Spinner, RichText },
  props: {
    confirmation: {
      type: String,
      default: null,
    },
    form: {
      type: Object,
      default: () => ({}),
    },
  },

  setup(props) {
    const {
      icattVueForm,
      submitHandler,
      loading,
      error,
      errorMessage,
      success,
      successMessage,
    } = useUmbracoForm(props.form, props.confirmation)

    const getInputTemplateType = (questionType) => {
      let t = ''

      switch (questionType) {
        case 'textarea':
          t = 'textareaQuestion'
          break
        case 'date':
          t = 'dateQuestion'
          break
        case 'checkbox':
          t = 'checkboxesQuestion'
          break
        case 'password':
          t = 'passwordQuestion'
          break
        case 'checkboxlist':
          t = 'checkboxesQuestion'
          break
        case 'select':
          t = 'dropdownQuestion'
          break
        case 'radio':
          t = 'radiobuttonsQuestion'
          break
        case 'checkboxList':
          t = 'checkboxesQuestion'
          break
        case 'dataConsent':
          t = 'checkboxesQuestion'
          break

          //  case  'titleAndDescription'
          // wordt momenteel nog niet ondersteund
          // is bedoeld om een stukje tekst ergen tussen te zeten (caption en bodyText).
          // icatt-vue-forms heeft daar ander oplossingen voor, maar
          // er kan indien gewenst een vraagtype voor toegevoegd worden

          // case 'recaptcha2'
          // wordt momenteel nog niet ondersteund

        default:
          t = 'text-question'
      }

      return t
    }

    const onSubmit = () => submitHandler()

    const displayableFormItems = computed(() => {
      const x = {}
      Object.entries(icattVueForm?.items).forEach((o) => {
        // als er een vraag 'website' is dan tonen we die niet op het scherm en vullen hem met de url van de website
        const k = o[0]
        const v = o[1]

        if (k === 'website') {
          v.antwoord = window.location.hostname
          return
        }

        x[k] = v
      })

      return x
    })

    return {
      icattVueForm,
      getInputTemplateType,
      onSubmit,
      loading,
      error,
      errorMessage,
      success,
      successMessage,
      displayableFormItems,
    }
  },

}

</script>

<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

fieldset{
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
  margin-bottom: var(--space-medium);
}

::v-deep(legend), ::v-deep(.form-label) {
  font-weight: bold;
  display: inline-block;
  margin-bottom: var(--space-smaller);
}

::v-deep(.form-error){
  color: var(--color-error)
}

::v-deep(input[type=text]), ::v-deep(textarea) {
  width: 100%;
}

::v-deep(input[type=date])  {
  display: block;
}

::v-deep(input)  {
  padding: 0.5rem;
}

 form {
 width:600px;
}

/* todo: media queries gelijk trekken */
@media only screen and (max-width: 600px) {
   form {
 width:100%;
}
}

 button {
  @include button-default;
}

.overlay{
 height: 100%;
  width:100%;
}
</style>
