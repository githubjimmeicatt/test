<template>
  <menu>
    <li>
      <button
        type="button"
        class="button"
        :aria-label="iconLabel"
        :title="iconLabel"
        :class="{loading}"
        @click="toggleLike"
      >
        <component
          :is="iconComponent"
          class="icon"
        />
        <span>{{ likes.length }}</span>
      </button>
    </li>
    <li>
      <the-link
        class="button"
        :href="linkToComments"
        :aria-label="commentsLinkLabel"
        :title="commentsLinkLabel"
      >
        <comment-solid class="icon" />
        <span>{{ commentsArray.length }}</span>
      </the-link>
    </li>
  </menu>
</template>

<script>
import {
  ref, computed, inject,
} from 'vue'
import HeartRegular from '../assets/LikesComments/heart-regular.svg'
import HeartSolid from '../assets/LikesComments/heart-solid.svg'
import CommentSolid from '../assets/LikesComments/comment-solid.svg'
import TheLink from './TheLink.vue'

export default {
  components: {
    HeartRegular,
    HeartSolid,
    TheLink,
    CommentSolid,
  },
  props: {
    likesArray: {
      type: Array,
      default: () => [],
    },
    pageId: {
      type: String,
      default: '',
    },
    linkToComments: {
      type: String,
      default: '',
    },
    commentsArray: {
      type: Array,
      default: () => [],
    },
    user: {
      type: Object,
      default: () => ({}),
    },
  },
  setup(props) {
    const portal = inject('portal')
    const likes = ref(props.likesArray?.map((x) => x.UserId) || [])
    const hasLiked = computed(() => likes.value?.includes(props.user.userId) || false)
    const iconComponent = computed(() => (hasLiked.value ? 'HeartSolid' : 'HeartRegular'))
    const iconLabel = computed(() => (hasLiked.value ? 'Unlike' : 'Like'))
    const loading = ref(false)

    async function toggleLike() {
      if (loading.value) return
      loading.value = true
      try {
        await portal.postLike(props.pageId, !hasLiked.value)
        if (hasLiked.value) {
          likes.value.pop()
        } else {
          likes.value.push(props.user.userId)
        }
      } finally {
        loading.value = false
      }
    }

    return {
      likes,
      toggleLike,
      hasLiked,
      iconComponent,
      iconLabel,
      loading,
      commentsLinkLabel: 'Naar reacties',
    }
  },
}
</script>

<style lang="scss" scoped>
menu
{
  display: flex;
  align-items: center;
  gap: 2rem;
  padding: 0;
  margin: 0;
  line-height: 2rem;

  svg{
    color: var(--color-accent-1);
  }
}

.icon {
  height: 2rem;
  display: block;
}
li {
  display: block;
}
.button {
  all: unset;
  padding: 0.25rem;
  display: flex;
  align-items: center;
  cursor: pointer;
  gap: 0.5rem;

  &:focus {
    outline: 0.125rem solid;
  }

  &.loading {
    cursor: wait;
  }
}
</style>
