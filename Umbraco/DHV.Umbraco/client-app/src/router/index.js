import { createRouter, createWebHistory } from 'vue-router'
import Umbraco from '../components/UmbracoProvider.vue'
import Search from '../CustomPages/Search.vue'

export default createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/zoeken',
      name: 'Search',
      component: Search,
      props: (route) => ({ searchQuery: route.query.s }),
    },
    {
      path: '/:pathMatch(.*)',
      name: 'Umbraco',
      component: Umbraco,
    },
  ],
  scrollBehavior(to, _from, savedPosition) {
    // always scroll to top
    if (to.hash) return { el: to.hash }
    return { top: savedPosition?.top || 0 }
  },
})
