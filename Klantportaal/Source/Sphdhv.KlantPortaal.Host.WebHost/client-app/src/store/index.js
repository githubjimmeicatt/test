import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: null,
    pension: null,
    documents: null,
    loadingStatus: 0,
    aanvullingVragen: null,
    aanvullingenGecontroleerd: false
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
    setAanvullingVragen: (state, aanvullen) => {
      state.aanvullingVragen = aanvullen
    },
    setAanvullingenGecontroleerd: (state) => {
      state.aanvullingenGecontroleerd = true
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
        }
      });
    },
    fetchAanvullingVragen: async ({ commit }) => {
      const csrfToken = Vue.$cookies.get('KP_CSRF_CLIENT');
      if (!csrfToken)
        return false;

      commit('incrementLoading', 1);
      const url = `/api/Deelnemer/VraagAanvulling?csrf=${csrfToken}`;
      return axios.get(url).then((resp) => {
        commit('incrementLoading', -1);
        const { data } = resp;
        switch (data.StatusCode) {
          case 401:
            commit('setUnauthorized');
            return false;
          case 200:
            commit('setAanvullingVragen', data.Response);
            commit('setAanvullingenGecontroleerd');
            return data.Response;
        }
      });
    },
    OpslaanAanvulling: async ({ commit }, email) => {

      const csrfToken = Vue.$cookies.get('KP_CSRF_CLIENT');
      if (!csrfToken)
        return false;

      const url = `/api/Deelnemer/OpslaanAanvulling?email=${email}&csrf=${csrfToken}`;
      return axios.get(url).then((resp) => {
        commit('incrementLoading', -1);
        const { data } = resp;
        switch (data.StatusCode) {
          case 401:
            commit('setUnauthorized');
            return false;
          case 200:
            commit('setAanvullingVragen', false);
            commit('setAanvullingenGecontroleerd');
            return data.Response;
        }
      });
    },
    VerifyEmail: async ({},id) => {
      const csrfToken = Vue.$cookies.get('KP_CSRF_CLIENT');
      if (!csrfToken)
        return false;


      const url = `/api/Deelnemer/VerifyEmail?guid=${id}&csrf=${csrfToken}`;
      return axios.get(url)
    }

  },
  modules: {
  }
})