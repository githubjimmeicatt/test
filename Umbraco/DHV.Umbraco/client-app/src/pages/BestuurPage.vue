<template>

  <section class="container">
    <h1>
      {{ content.name }}
    </h1>

    <RichText :body="content.tekstblok.textEditor" />
  </section>

  <EmployeeList
    v-for="(employee, index) in content.employeeList"
    :key="index"
    v-bind="employee" />

</template>

<script>
import { inject } from 'vue'
import EmployeeList from '@/components/EmployeeList.vue'
import RichText from '@/components/RichText.vue'

export default {
  components: {
    EmployeeList,
    RichText,
  },
  setup() {
    const content = inject('content')
    return {
      content,
    }
  },

}
</script>
