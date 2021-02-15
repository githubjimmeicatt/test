<template>
  <div class="container">
    <div class="content-section">
      <h2>E-mailadres</h2>
      <p>Bedankt voor het bevestigen van je e-mailadres.</p>
      <div class="button-group">
        <a class="button button--primary" id="emailCollectDismiss" href="/">
          Naar Mijn pensioenomgeving
        </a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
    async mounted(){
        await this.$store.dispatch('VerifyEmail', this.$route.params.id); 
    }
}
</script>