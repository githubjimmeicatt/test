import Vue from 'vue'
import VueRouter from 'vue-router'
import $store from '../store/index';

import Profiel from '../views/Profiel.vue';
import Pensioen from '../views/Pensioen.vue';
import Documenten from '../views/Documenten.vue';
import Login from '../views/Login.vue';
import Email from '../views/Email.vue';
import Emailverificatie from '../views/Emailverificatie.vue'
import PageNotFound from '../views/PageNotFound.vue';

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
  {
    path: '/email',
    name: 'Email',
    component: Email,
    meta: {
      requiresAuth: true
    }
  },
  {
    path: '/emailverificatie/:id',
    name: 'Emailverificatie',
    component: Emailverificatie,
    meta: {
      requiresAuth: true
    }
  },
  {
    path: '*',
    name: 'PageNotFound',
    component: PageNotFound,
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

  if (isLoggedIn && !$store.state.aanvullingenGecontroleerd) {
    await $store.dispatch('fetchAanvullingVragen')
  }

  if (isLoggedIn && requiresAuth && $store.state.aanvullingenGecontroleerd && $store.state.aanvullingVragen && to.name !== "Email") {
    next({ name: 'Email' })
  } else if (requiresAuth === true && !isLoggedIn) {
    next({ name: 'Login' })
  } else {
    next();
  }

});

export default router
