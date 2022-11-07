import {
  reactive, toRefs, ref, inject,
} from 'vue'
import {
  formModel as FormModel, formItemModel as FormItem, validation as FormValidators, formValidator, formParser as FormParser,
} from 'icatt-vue-forms'

import { useRouter } from 'vue-router'
/**
 *
 * @param {import('@umbraco/headless-forms-react/types').FormConditionRuleOperatorType} ruleOperator
 * @returns {(a: string, b: string) => boolean}
 */
function getEvaluator(ruleOperator) {
  switch (ruleOperator) {
    case 'IS':
      return (a, b) => a === b
    case 'IS_NOT':
      return (a, b) => a !== b
    case 'GREATER_THEN':
      return (a, b) => a > b
    case 'LESS_THEN':
      return (a, b) => a < b
    case 'CONTAINS':
      return (a, b) => typeof a?.some === 'function' && a.some(b)
    case 'STARTS_WITH':
      return (a, b) => typeof a?.startsWith === 'function' && a.startsWith(b)
    case 'ENDS_WITH':
      return (a, b) => typeof a?.endsWith === 'function' && a.endsWith(b)
    default:
      throw new Error(`could not parse operator ${ruleOperator}`)
  }
}

function setValidators(required, settings) {
  const validators = []
  if (required) validators.push(FormValidators.required)
  if (settings.pattern) validators.push((value) => FormValidators.regex(value, settings.pattern, settings.patternInvalidErrorMessage))
  if (settings.fieldType === 'email') validators.push(FormValidators.email)
  if (settings.maximumLength) {
    validators.push(FormValidators.maxLength(+settings.maximumLength))
  }
  return validators
}

function getAttributes(settings) {
  const entries = []
  if (settings.fieldType) {
    entries.push(['type', settings.fieldType])
  }
  if (settings.autocompleteAttribute) {
    entries.push(['autocomplete', settings.autocompleteAttribute])
  }
  if (settings.placeholder) {
    entries.push(['placeholder', settings.placeholder])
  }
  return Object.fromEntries(entries)
}

/**
 *
 * @param {string} id
 * @returns {import('vue').Ref<import('@umbraco/headless-forms-react/types').Form>}
 */
export default function useUmbracoForm(form, confirmation) {
  const icattVueForm = reactive(new FormModel({
    items: {},
  }))

  const loading = ref(true)
  const error = ref(false)
  const success = ref(false)
  const errorMessage = 'Er is iets mis gegaan. Probeer het opnieuw.'
  const successMessage = ref('')
  const gotoAfterSubmit = ref('')
  const x = toRefs(form)
  const portal = inject('portal')
  const router = useRouter()
  // assure minimal model structure
  if (!x || !Array.isArray(x.pages.value) || !Array.isArray(x.pages.value[0].fieldsets) || !x.pages.value[0].fieldsets[0] || !Array.isArray(x.pages.value[0].fieldsets[0].columns[0].fields)) {
    x.pages.value = [{ fieldsets: [{ columns: [{ fields: [] }] }] }]
  }

  // zelf maak formuliertjes zijn altijd eenvoudig met maar 1 pagina/stap
  // daar gaan we nu gemakshalve vanuit. complexere structuren ondersteunen kan altijd nog
  // als daar behoefte aan ontstaat
  const formFields = x.pages.value[0].fieldsets[0].columns[0].fields
  if (formFields) {
    // bouw icatt-vue-forms model op.
    formFields.forEach((field) => {
      if (field.type === 'titleAndDescription' || field.type === 'recaptcha2') {
        // eslint-disable-next-line no-alert
        alert('title+description en recaptcha worden nog niet ondersteund')
      }

      let opties

      const prevalueSplitChar = '~|~'

      if (Array.isArray(field.preValues)) {
        opties = field.preValues.map((pv) => {
          const [left, right] = pv.split(prevalueSplitChar)
          return {
            value: left || right,
            label: right || left,
          }
        })
      } else if (field.preValues && typeof field.preValues === 'object') {
        opties = Object.entries(field.preValues).map(([value, label]) => ({ label, value }))
      }

      icattVueForm.items[field.alias] = new FormItem({
        label: field.caption,
        type: field.type ?? 'text',
        opties,
        validators: setValidators(field.required, field.settings),
        attributes: getAttributes(field.settings),
      })

      // niet alle vraagtypes van umbraco en icatt-vue-forms matchen
      // dataConsent is een single checkbox. icatt-vue-forms kent wel
      // een checkboxlijst die daarvoor gebruikt kan worden. moet wel even gemapt worden
      // geldt misschien voor meer types. todo: nalopen
      if (field.type === 'dataConsent' || field.type === 'checkbox') {
        icattVueForm.items[field.alias].label = null
        icattVueForm.items[field.alias].opties = [{ label: field.caption, value: field.alias }]
      }

      // voor elke rule vind het formitem met als propertynaam gelijk aan de field property van de rule
      if (field?.condition?.rules) {
        // bouw een functie op waarmee een rule geevalueerd kan worden
        const ruleEvaluator = (rule) => {
          // zoek het formItem op waar dit item van afhankelijk is
          // selecteer het juiste type evaluatiefunctie (gelijkaan,groter dan etc)
          // voer de dependency evaluatie uit tov de grenswaarde van de rule
          const ruleHeeftbetrekkingOp = icattVueForm.items[rule.field]
          const evaluator = getEvaluator(rule.operator)
          return evaluator(ruleHeeftbetrekkingOp.antwoord, rule.value)
        }

        const allOrAny = field.condition.logicType === 'ALL'
          ? () => field.condition.rules.every(ruleEvaluator)
          : () => field.condition.rules.some(ruleEvaluator)

        const showOrHide = field.condition.actionType === 'SHOW'
          ? allOrAny
          : () => !allOrAny()

        // stel de daadwerkelijke evaluate functie in van het formItem
        // hier in wordt  .isaCtief gezet waarbij obv allorAny van de ruleEvaluators de vraag getoond of verborgen wordt
        icattVueForm.items[field.alias].evaluate = (context) => {
          // eslint-disable-next-line no-param-reassign
          context.self.isActief = showOrHide()
        }
      }
    })

    // initial dependency check. zou eigenlijk door de vueform componetn gedaan moeten woden
    // maar dat gebeurd nu niet. waarschijnlijk vue3 upgrade dingetje
    formValidator(icattVueForm)
  }

  successMessage.value = confirmation || x.messageOnSubmit || 'Uw gegevens zijn verzonden'
  gotoAfterSubmit.value = x.gotoPageOnSubmit?.value || null
  loading.value = false

  const submitHandler = () => {
    FormParser.submit(icattVueForm, async (postData) => {
      loading.value = true
      error.value = false
      success.value = false
      try {
        /** @type {import('axios').AxiosResponse} */
        const response = await portal.submitForm(form._id, postData)
        if (response.status >= 400) {
          throw new Error(response.statusText)
        }
        success.value = true
        if (!confirmation && gotoAfterSubmit.value) {
          const redirectUrl = await portal.fetchById(gotoAfterSubmit.value)
          router.push(redirectUrl._url)
        } else {
          window.scrollTo(0, 0)
        }
      } catch (e) {
        error.value = true
      } finally {
        loading.value = false
      }
    }, FormParser.formats.json)
  }

  return {
    icattVueForm, submitHandler, gotoAfterSubmit, loading, error, success, errorMessage, successMessage,
  }
}
