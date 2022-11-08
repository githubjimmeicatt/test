<template>

  <page-header
    v-bind="content.pageHeader" />

  <!-- Wordt niet getoond op pagina, alleen in DOM -->
  <RichTextVue v-bind="content.tekstblok" />

  <EmployeeList
    v-bind="content.employeeList1" />
  <EmployeeList
    v-bind="content.employeeList2" />
  <EmployeeList
    v-bind="content.employeeList3" />
</template>

<script>
import { inject } from 'vue'
import RichTextVue from '@/components/RichText.vue'
import EmployeeList from '@/components/EmployeeList.vue'
import PageHeader from '../components/PageHeader.vue'

export default {
  components: {
    PageHeader,
    RichTextVue,
    EmployeeList,
  },
  setup() {
    const content = inject('content')
    return {
      content,
    }
  },

}
</script>
