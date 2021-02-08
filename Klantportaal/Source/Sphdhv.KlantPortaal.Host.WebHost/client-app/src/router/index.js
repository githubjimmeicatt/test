import Vue from 'vue'
import VueRouter from 'vue-router'
import $store from '../store/index';

import Profiel from '../views/Profiel.vue';
import Pensioen from '../views/Pensioen.vue';
import Documenten from '../views/Documenten.vue';
import Login from '../views/Login.vue';

Vue.use(VueRouter)

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
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach(async (to, from, next) => {
  let isLoggedIn = !!$store.state.user;
  isLoggedIn = isLoggedIn || await $store.dispatch('fetchUser');

  const { requiresAuth } = to?.meta || {};
  if (requiresAuth === false && isLoggedIn) {
    next({path: '/'})
  } else if (requiresAuth === true && !isLoggedIn) {
    next({name: 'Login'})
  } else {
    next();
  }
});

export default router
