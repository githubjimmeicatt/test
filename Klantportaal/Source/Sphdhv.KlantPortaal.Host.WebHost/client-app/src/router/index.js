import {createRouter, createWebHistory} from 'vue-router'

import Profiel from '../views/Profiel.vue';
import Pensioen from '../views/Pensioen.vue';
import Documenten from '../views/Documenten.vue';
import Login from '../views/Login.vue';
import PageNotFound from '../views/PageNotFound.vue';

const _createRouter = (store) => {
  const routes = [
    {
      path: '/',
      name: 'Profiel',
      component: Profiel,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/documenten',
      name: 'Documenten',
      component: Documenten,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/pensioen',
      name: 'Pensioen',
      component: Pensioen,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
   
    {
      path: '/:pathMatch(.*)*',
      name: 'PageNotFound',
      component: PageNotFound,
      meta: {
        requiresAuth: false
      }
    },
  ]
  
  const router = createRouter({
    history: createWebHistory(),
    routes
  })
  
  router.beforeEach(async (to, from, next) => {
  
    let isLoggedIn = !!store.state.user;
    isLoggedIn = isLoggedIn || await store.dispatch('fetchUser');
  
    const { requiresAuth } = to?.meta || {};
  
    if (requiresAuth === true && !isLoggedIn) {
      next({ name: 'Login' })
    } else {
      next();
    }
  
  });

  return router
}



export default _createRouter
