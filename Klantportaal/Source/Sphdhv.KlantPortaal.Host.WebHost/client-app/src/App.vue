<template>
  <div id="app">
    <Masthead/>
    <router-view/>
    <Footer/>
  </div>
</template>

<script>
import Masthead from '@/components/Masthead'
import Footer from '@/components/Footer'

export default {
  components: { Masthead, Footer },
  mounted() {
    const { $store } = this;
    $store.dispatch('authorize');
  }
}
</script>

<style lang="scss">
  @import '@/styles/main.scss';
</style>
