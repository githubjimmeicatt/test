<template>

  <page-header
    v-bind="content.pageHeader" />

  <section
    class="container"
  >
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
import PageHeader from '../components/PageHeader.vue'

export default {
  components: {
    PageHeader,
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
