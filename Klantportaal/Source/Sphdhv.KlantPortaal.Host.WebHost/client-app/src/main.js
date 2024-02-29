import {createApp} from 'vue'
import App from './App.vue'
import createRouter from './router'
import createStore from './store'
import cookies from 'vue-cookies'

const app = createApp(App)
const store = createStore(cookies)
const router = createRouter(store)

app.use(cookies)
app.use(store)
app.use(router)

app.mount('#app')