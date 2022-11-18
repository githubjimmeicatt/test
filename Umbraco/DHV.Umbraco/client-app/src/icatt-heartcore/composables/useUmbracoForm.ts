import { reactive, toRefs, ref } from 'vue'
import {
  formModel,
  formItemModel,
  validation,
  formValidator,
  formParser,
} from 'icatt-vue-forms'

import type {
  FormConditionRuleOperatorType,
  Form,
  FormConditionRule,
} from '@umbraco/headless-forms-react/types'

import { useRouter } from 'vue-router'
import { useUmbracoApi } from '../plugin'

function getEvaluator(
  ruleOperator: FormConditionRuleOperatorType,
): (a: string | any[], b: string | number) => boolean {
  switch (ruleOperator) {
    case 'IS':
      return (a, b) => a === b
    case 'IS_NOT':
      return (a, b) => a !== b
    case 'GREATER_THEN':
      return (a, b) => (Array.isArray(a) ? a.length > b : a > b)
    case 'LESS_THEN':
      return (a, b) => a < b
    case 'CONTAINS':
      return (a, b) => a?.includes(b?.toString()) ?? false
    case 'STARTS_WITH':
      return (a, b) => (Array.isArray(a) ? a[0] === b : a?.startsWith?.(b?.toString()) ?? false)
    case 'ENDS_WITH':
      return (a, b) => (Array.isArray(a)
        ? a[a.length - 1] === b
        : a?.endsWith?.(b?.toString()) ?? false)
    default:
      throw new Error(`could not parse operator ${ruleOperator}`)
  }
}

function setValidators(required: boolean, settings: any) {
  const validators = []
  if (required) validators.push(validation.required)
  if (settings.pattern) {
    validators.push((value: string) => validation.regex(
      value,
      settings.pattern,
      settings.patternInvalidErrorMessage,
    ))
  }
  if (settings.fieldType === 'email') validators.push(validation.email)
  if (settings.maximumLength) {
    validators.push(validation.maxLength(+settings.maximumLength))
  }
  return validators
}

function getAttributes(settings: any) {
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

// eslint-disable-next-line import/prefer-default-export
export function useUmbracoForm(form: Form, confirmation?: string) {
  const icattVueForm = reactive(
    formModel({
      items: {},
    }),
  )

  const loading = ref(true)
  const error = ref(false)
  const success = ref(false)
  const errorMessage = 'Er is iets mis gegaan. Probeer het opnieuw.'
  const successMessage = ref('')
  const gotoAfterSubmit = ref('')
  const x = toRefs(form)
  const api = useUmbracoApi()
  const router = useRouter()
  // assure minimal model structure
  if (!Array.isArray(x?.pages?.value?.[0]?.fieldsets?.[0]?.columns?.[0]?.fields)) {
    x.pages = x.pages ?? {}
    x.pages.value = [{ fieldsets: [{ columns: [{ fields: [], width: 0 }] }] }]
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
        opties = field.preValues.map((pv?: string) => {
          const [left, right] = pv?.split(prevalueSplitChar) ?? []
          return {
            value: left || right,
            label: right || left,
          }
        })
      } else if (field.preValues && typeof field.preValues === 'object') {
        opties = Object.entries(field.preValues).map(([value, label]) => ({
          label,
          value,
        }))
      }

      const items = icattVueForm.items as any

      items[field.alias] = formItemModel({
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
        items[field.alias].label = null
        items[field.alias].opties = [
          { label: field.caption, value: field.alias },
        ]
      }

      // voor elke rule vind het formitem met als propertynaam gelijk aan de field property van de rule
      if (field?.condition?.rules) {
        // bouw een functie op waarmee een rule geevalueerd kan worden
        const ruleEvaluator = (rule: FormConditionRule) => {
          // zoek het formItem op waar dit item van afhankelijk is
          // selecteer het juiste type evaluatiefunctie (gelijkaan,groter dan etc)
          // voer de dependency evaluatie uit tov de grenswaarde van de rule
          const ruleHeeftbetrekkingOp = items[rule.field]
          const evaluator = getEvaluator(rule.operator)
          return evaluator(ruleHeeftbetrekkingOp.antwoord, rule.value)
        }

        const allOrAny = field.condition.logicType === 'ALL'
          ? () => field.condition?.rules.every(ruleEvaluator) || false
          : () => field.condition?.rules.some(ruleEvaluator) || false

        const showOrHide = field.condition.actionType === 'SHOW' ? allOrAny : () => !allOrAny()

        // stel de daadwerkelijke evaluate functie in van het formItem
        // hier in wordt  .isaCtief gezet waarbij obv allorAny van de ruleEvaluators de vraag getoond of verborgen wordt
        items[field.alias].evaluate = (context: any) => {
          // eslint-disable-next-line no-param-reassign
          context.self.isActief = showOrHide()
        }
      }
    })

    // initial dependency check. zou eigenlijk door de vueform componetn gedaan moeten woden
    // maar dat gebeurd nu niet. waarschijnlijk vue3 upgrade dingetje
    formValidator(icattVueForm, undefined)
  }

  successMessage.value = confirmation || x.messageOnSubmit?.value || 'Uw gegevens zijn verzonden'
  gotoAfterSubmit.value = (x as any).gotoPageOnSubmit?.value || null
  loading.value = false

  const submitHandler = () => {
    formParser.submit(
      icattVueForm,
      async (postData: Record<string, any>) => {
        if (!api) return
        loading.value = true
        error.value = false
        success.value = false
        try {
          const response = await api.submitForm(form._id, postData)
          if (response.status >= 400) {
            throw new Error(response.statusText)
          }
          success.value = true
          if (!confirmation && gotoAfterSubmit.value) {
            const redirectUrl = await api.id(gotoAfterSubmit.value)
            router.push(redirectUrl.data._url)
          } else {
            window.scrollTo(0, 0)
          }
        } catch (e) {
          error.value = true
        } finally {
          loading.value = false
        }
      },
      formParser.formats.json,
    )
  }

  return {
    icattVueForm,
    submitHandler,
    gotoAfterSubmit,
    loading,
    error,
    success,
    errorMessage,
    successMessage,
  }
}
