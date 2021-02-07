import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: undefined
  },
  getters: {
    isLoggedIn: (state, getters) => {
      const { user } = state;
      return user ? true : false;
    }
  },
  mutations: {
    fetchAccount: (state) => {
      const { user } = state;
      if (user) return false;

      // const csrfToken = Vue.$cookies.get('CSRF_COOKIE');
      // if (!csrfToken) return false;

      const url = `/api/MijnPensioen/Profiel`;
      axios.get(url).then((resp) => {
        console.log(resp);
      });

      return true;
    }
  },
  actions: {
    authorize ({commit}) {
      commit('fetchAccount');
    }
  },
  modules: {
  }
})