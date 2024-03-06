<template>
  <div
    :class="{
      'Spinner': true,
      'Spinner--active': $store.state.loadingStatus > 0
    }"
    id="app">
    <Masthead/>
    <router-view/>
    <Footer/>
  </div>
</template>

<script>
import Masthead from '@/components/Masthead.vue'
import Footer from '@/components/Footer.vue'

export default {
  components: { Masthead, Footer }
}
</script>

<style lang="scss">
  @import '@/styles/main.scss';
</style>
