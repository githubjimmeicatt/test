<template>
  <component
    :is="layout"
    :theme="theme"
  >
    <template #main>
      <router-view />
    </template>
  </component>
</template>

<script>
import { onMounted, provide, watch } from 'vue'
import { useNProgress } from '@vueuse/integrations/useNProgress'
import useLayout from './composables/useLayout'
import useUmbraco from './composables/useUmbraco'

export default {
  setup() {
    const { layout, theme } = useLayout()
    const {
      component, content, menu, loading,
    } = useUmbraco()
    provide('content', content)
    provide('menu', menu)
    provide('component', component)
    provide('loading', loading)

    const { isLoading } = useNProgress()

    watch(loading, (val) => {
      isLoading.value = val
    }, { immediate: true })

    onMounted(() => {
      document.getElementsByTagName('body')[0].classList.add(theme)
    })

    window.onload = function () {
      (function (window, document, dataLayerName, id) {
        (window[dataLayerName] = window[dataLayerName] || []),
        window[dataLayerName].push({
          start: new Date().getTime(),
          event: 'stg.start',
        })
        const scripts = document.getElementsByTagName('script')[0]
        const tags = document.createElement('script')
        function stgCreateCookie(a, b, c) {
          let d = ''
          let f = ''
          if (c) {
            const e = new Date()
            e.setTime(e.getTime() + 24 * c * 60 * 60 * 1e3),
            (d = `; expires=${e.toUTCString()}`)
            f = '; SameSite=Strict'
          }
          document.cookie = `${a}=${b}${d}${f}; path=/`
        }
        const isStgDebug = (window.location.href.match('stg_debug')
            || document.cookie.match('stg_debug'))
          && !window.location.href.match('stg_disable_debug')
        stgCreateCookie('stg_debug', isStgDebug ? 1 : '', isStgDebug ? 14 : -1)
        const qP = []
        dataLayerName !== 'dataLayer'
          && qP.push(`data_layer_name=${dataLayerName}`),
        isStgDebug && qP.push('stg_debug')
        const qPString = qP.length > 0 ? `?${qP.join('&')}` : '';
        (tags.async = !0),
        (tags.src = `https://pensioenfondshaskoningdhv.containers.piwik.pro/${
          id
        }.js${
          qPString}`),
        scripts.parentNode.insertBefore(tags, scripts)
        !(function (a, n, i) {
          a[n] = a[n] || {}
          for (let c = 0; c < i.length; c++) {
            !(function (i) {
              (a[n][i] = a[n][i] || {}),
              (a[n][i].api = a[n][i].api
                  || function () {
                    const a = [].slice.call(arguments, 0)
                    typeof a[0] === 'string'
                      && window[dataLayerName].push({
                        event: `${n}.${i}:${a[0]}`,
                        parameters: [].slice.call(arguments, 1),
                      })
                  })
            }(i[c]))
          }
        }(window, 'ppms', ['tm', 'cm']))
      }(window, document, 'dataLayer', '9d8aa27a-9b3d-4198-b939-c81fb2bda11d'))
    }

    return {
      layout,
      theme,
      isLoading,
    }
  },
}
</script>

<style lang="scss">
@import "nprogress/nprogress.css";

#nprogress {
  .bar {
    background: var(--color-accent-1) !important;
  }
  .peg {
    box-shadow: 0 0 10px var(--color-accent-1), 0 0 5px var(--color-accent-1);
  }
  .spinner  .spinner-icon {
    border-top-color: var(--color-accent-1);
    border-left-color: var(--color-accent-1);
  }
}
</style>
