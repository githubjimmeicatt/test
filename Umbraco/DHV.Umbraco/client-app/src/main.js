import IcattVueForms from 'icatt-vue-forms'
import { createApp } from 'vue'
import { createHead } from '@vueuse/head'
import App from './App.vue'
import router from './router'

// polyfill voor ResizeObserver indien nodig. Vereist voor TheHeader en useImbracoImage
if (window && !('ResizeObserver' in window)) {
  import('resize-observer-polyfill').then((x) => {
    window.ResizeObserver = x.default
  })
}

createApp(App)
  .use(IcattVueForms)
  .use(createHead())
  .use(router)
  .mount('#app')
