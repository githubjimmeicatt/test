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
  />

  <vue-form
    v-else-if="icattVueForm"
    :form="icattVueForm"
    @submit="onSubmit"
  >
    <component
      :is="getInputTemplateType(item.type)"
      v-for="item in displayableFormItems"
      :key="item.alias"
      v-bind="item.attributes"
      :form-element="item"
    />
    <slot
      name="submit"
      :onSubmit="onSubmit"
    >
      <button
        class="form-button is-submit"
      >
        Verzenden
      </button>
    </slot>
  </vue-form>
</template>

<script>

import { computed } from 'vue'
import useUmbracoForm from '../composables/useUmbracoForm'
import RichText from '../../components/RichText.vue'

export default {
  components: { RichText },
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
