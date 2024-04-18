<template>
  <nav
    v-if="urls && urls['nl']">
    <SearchIcon />
    <template v-if="isEnglishPage">
      <a href="#" @click="toggleLanguage()" class="nl"><img src="../assets/nederlands.png" alt="nederlands"></a>
    </template>
    <template v-else>
      <a href="#" @click="toggleLanguage()" class="en"><img src="../assets/engels.png" alt="engels"></a>
    </template>
  </nav>
</template>

<script>

import { useRouter, useRoute } from 'vue-router'

export default {
  components: {

  },
  props: {
    urls: {
      type: Object,
      default: () => ({}),
    },

  },

  setup() {
    const router = useRouter()
    const route = useRoute()

    return {
      router,
      route,
    }
  },
  methods: {
    async toggleLanguage() {
      if (this.isEnglishPage) {
        this.router.push(this.route.path.substring(3))
      } else {
        this.router.push(`/en${this.route.path}`)
      }
    },
  },
  computed: {
    isEnglishPage() { return this.route.path.startsWith('/en') },
  },

}
</script>
