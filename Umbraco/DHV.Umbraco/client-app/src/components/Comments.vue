<template>
  <section class="container cards">
    <h1>Reacties</h1>
    <ul>
      <li
        v-for="({
          UserId, UserFullName, Date, Usercontent, dateString,
        }, index) in comments"
        :key="index"
      >
        <card>
          <h2 class="toptitle">
            <template v-if="UserFullName || UserId">
              {{ UserFullName || UserId }}
            </template>
            <template v-if="Date && Date !== '0001-01-01T00:00:00'">
              op <time :datetime="Date">{{ dateString }}</time>
            </template>
          </h2>
          <p class="usercontent">
            {{ Usercontent }}
          </p>
        </card>
      </li>
    </ul>

    <form @submit.prevent="comment(pageId, textComment)">
      <h2 @click="commentInput.focus()">
        Reageren
      </h2>
      <textarea
        ref="commentInput"
        v-model="textComment"
        rows="10"
        :aria-label="reactieLabel"
        :placeholder="reactieLabel"
      />
      <button
        :class="{ cta: true, loading }"
        data-gtm-button-type="cta">
        Verstuur
      </button>
    </form>
  </section>
</template>

<script>
import { useUmbracoApi } from 'icatt-heartcore'
import {
  ref, computed, defineComponent, inject,
} from 'vue'
import Card from './Card.vue'

export default defineComponent({
  components: {
    Card,
  },
  props: {
    modelValue: {
      type: Array,
      default: () => [],
    },
    pageId: {
      type: String,
      default: '',
    },
    user: {
      type: Object,
      default: () => ({}),
    },
  },
  emits: ['update:modelValue'],
  setup(props, context) {
    const textComment = ref('')
    const commentInput = ref(null)
    const umbracoApi = useUmbracoApi()
    const loading = ref(false)

    const comments = computed(() => props.modelValue
      .map((x) => ({
        ...x,
        dateString: new Date(x.Date).toLocaleDateString('nl-NL'),
      }))
      .sort((a, b) => b.Date - a.Date))

    async function comment(pageId, text) {
      if (loading.value) return
      try {
        loading.value = true
        await umbracoApi.comment(pageId, text)
        context.emit('update:modelValue', [...props.modelValue, {
          UserId: props.user.userId,
          UserFullName: props.user.userFullName,
          Usercontent: text,
          Date: new Date().toISOString(),
        }])
        textComment.value = ''
      } finally {
        loading.value = false
      }
    }

    return {
      comments,
      textComment,
      comment,
      commentInput,
      loading,
      reactieLabel: 'Uw reactie',
    }
  },
})
</script>

<style lang="scss" scoped>
section {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

h1 {
  margin: 0;
}

ul {
  all: unset;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}
li, textarea {
  display: block;
  max-width: var(--max-text-width);
}
textarea {
  width: var(--max-text-width);
  padding: 0.5rem;
}

form {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.usercontent {
  white-space: pre-wrap;
}

.cta.loading {
  cursor: wait;
}

</style>
