import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: null,
    pension: null,
    documents: null,
    loadingStatus: 0 
  },
  getters: {
    isLoading: (state) => {
      return state.loadingStatus > 0;
    },
    isAuthenticated: (state) => {
      return !!state.user;
    }
  },
  mutations: {
    setUnauthorized: (state, user) => {
      state.user = null;
      state.pension = null;
      Vue.$cookies.set('KP_CSRF_CLIENT', '');
    },
    setUser: (state, user) => {
      state.user = user;
    },
    setPension: (state, pension) => {
      state.pension = pension;
    },
    setDocuments: (state, documents) => {
      state.documents = documents;
    },
    incrementLoading: (state, change) => {
      state.loadingStatus += change;
    },

  },
  actions: {
    fetchPension: async ({ commit }) => {
      const csrfToken = Vue.$cookies.get('KP_CSRF_CLIENT');
      if (!csrfToken)
        return false;

      commit('incrementLoading', 1);
      const url = `/api/MijnPensioen/ActueelPensioen?csrf=${csrfToken}`;
      return axios.get(url).then((resp) => {
        commit('incrementLoading', -1);
        const { data } = resp;
        switch (data.StatusCode) {
          case 401:
            commit('setUnauthorized');
            return false;
          case 200:
            commit('setPension', data.Response);
            return data.Response;
          default:
            window.location.href = "/500.html";
            return false;
        }
      });
    },
    fetchUser: async ({ commit }) => {
      const csrfToken = Vue.$cookies.get('KP_CSRF_CLIENT');
      if (!csrfToken)
        return false;

      commit('incrementLoading', 1);
      const url = `/api/MijnPensioen/Profiel?csrf=${csrfToken}`;
      return axios.get(url).then((resp) => {
        commit('incrementLoading', -1);
        const { data } = resp;
        switch (data.StatusCode) {
          case 401:
            commit('setUnauthorized');
            return false;
          case 200:
            commit('setUser', data.Response);
            return data.Response;
          default:
            window.location.href = "/500.html";
            return false;
        }
      });
    },
    fetchDocuments: async ({ commit }) => {
      const csrfToken = Vue.$cookies.get('KP_CSRF_CLIENT');
      if (!csrfToken)
        return false;

      commit('incrementLoading', 1);
      const url = `/api/Correspondentie/CorrespondentieOverzicht?csrf=${csrfToken}`;
      return axios.get(url).then((resp) => {
        commit('incrementLoading', -1);
        const { data } = resp;
        switch (data.StatusCode) {
          case 401:
            commit('setUnauthorized');
            return false;
          case 200:
            commit('setDocuments', data.Response);
            return data.Response;
          default:
            window.location.href = "/500.html";
            return false;
        }
      });
    },
  

  },
  modules: {
  }
})