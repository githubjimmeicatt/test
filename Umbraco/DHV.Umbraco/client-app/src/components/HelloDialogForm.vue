<template>
  <section>
    <article class="richtext">
      <h1 v-if="title">
        {{ title }}
      </h1>
      <rich-text
        v-if="htmlCode"
        :body="htmlCode"
      />
      <component
        is="script"
        :src="'https://app.hellodialog.com/js/subscribeforms/subscribeform.js.php?id='+getFormId()"
        async
      />
    </article>
  </section>
</template>

<script>
import RichText from './RichText.vue'

export default {
  components: { RichText },
  props: {
    title: {
      type: String,
      default: '',
    },
    htmlCode: {
      type: String,
      default: '',
    },
  },
  methods: {
    getFormId() {
      const doc = new DOMParser().parseFromString(this.htmlCode, 'text/html')
      const formTags = doc.getElementsByTagName('form')
      return formTags[0].id.split('_')[2]
    },
  },
}
</script>
<style lang="scss">
@import "../assets/scss/_mixins.scss";

.actual-hidden {
  display: none;
}

label {
  display: block;
}

._form-field {
  margin-bottom: var(--space-smaller);
}

._form-error {
  color: red;
}

input[type=email] {
  width: 100%;
}

//copy pasta van mixin: hoe gebruik ik die hier netjes?
input[type=submit] {
  display: inline-block;
  padding: 0.5rem 0.75rem;
  color: white;
  text-decoration: none;
  background-color: var(--color-button);
  margin-top: 1rem;
  font-weight: bold;
  border: none;
  border-radius: 1px;
  transition: 0.4s;

  &:hover {
    cursor: pointer;
    background-color: var(--color-button-hover);
  }

  &::before {
    @include arrow-inline();
    margin-right: 0.5rem;
  }
}
</style>
<style lang="scss" scoped>
@import "../assets/scss/_mixins.scss";

fieldset {
  border: none;
  padding: 0px;
  margin: 0px;
}

::v-deep(.is-stacked) {
  display: flex;
  flex-direction: column;
}

::v-deep(textarea) {
  display: block;
}

::v-deep(.form-options-group),
::v-deep(.form-group) {
  margin-bottom: var(--space-medium);
}

::v-deep(legend),
::v-deep(.form-label) {
  font-weight: bold;
  display: inline-block;
  margin-bottom: var(--space-smaller);
}

::v-deep(.form-error) {
  color: var(--color-error)
}

::v-deep(input[type=text]),
::v-deep(textarea) {
  width: 100%;
}

::v-deep(input[type=date]) {
  display: block;
}

::v-deep(input) {
  padding: 0.5rem;
}

form {
  width: 30rem;
}

aside form {
  width: 15rem;
}

/* todo: media queries gelijk trekken */
@media only screen and (max-width: 600px) {
  form {
    width: 100%;
  }
}

button {
  @include button-default;
}

.overlay {
  height: 100%;
  width: 100%;
}
</style>
