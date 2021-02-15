<template>
  <div class="container">
    <div v-if="!isVerstuurd" class="content-section">
      <h2>E-mailadres</h2>
      <p>
        We houden je graag op de hoogte over je pensioen. Vul hieronder je
        e-mailadres in en klik op volgende.
      </p>
      <p class="form-group" :class="{ 'is-invalid': !emailIsValid && emailIsDirty }">
        <input type="email" name="emailCollect" v-model="email" @change="emailIsDirty = true" />
        
        <span v-if="!emailIsValid && emailIsDirty" class="form-error">
          Vul een geldig e-mailadres in
        </span>
      </p>
      <div class="button-group">
        <button
         
          class="button button--primary js-submit-email"
          @click="submit"
        >
          Volgende
        </button>
        <button class="button button--link" @click="overslaan">Overslaan</button>
      </div>
    </div>
    <div v-else class="content-section">
      <h2>Verifieer je e-mailadres</h2>
      <p>
        Om je e-mailadres te verifiëren klik je op de verificatielink in de
        zojuist verstuurde e-mail.
      </p>
      <div class="button-group">
        <a
          class="button button--primary"
          id="emailCollectDismiss"
          href="/"
        >
          Naar Mijn pensioenomgeving
        </a>
      </div>
    </div>
  </div>
</template>

<script>
import KeyValueList from "@/components/generic/KeyValueList";

export default {
  name: "Profiel",
  components: {
    KeyValueList,
  },
  data: () => {
    return {
      isVerstuurd: false,
      email: "",
      emailIsDirty: false
    };
  },
  methods: {
    async submit() { 
      if(!this.emailIsValid || !this.emailIsDirty){
        this.emailIsDirty = true
        return
      }
      await this.$store.dispatch('OpslaanAanvulling', this.email);   
      this.isVerstuurd = true;
    },
    async overslaan() {
      await this.$store.dispatch('OpslaanAanvulling', '');
      this.$router.push('/')
    },
  },
  computed: {
    emailIsValid() { 
      var emailRegex = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;
      return emailRegex.test(this.email);
    },
  },
};
</script>
