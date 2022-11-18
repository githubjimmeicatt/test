import type { App } from 'vue'
import { inject, type InjectionKey } from 'vue'
import type { Config } from './config'
import { getUmbracoApi, type UmbracoApi } from './api/umbraco'

const injectionKey: InjectionKey<UmbracoApi> = Symbol('injection key for umbraco api')

export function useUmbracoApi() {
  return inject(injectionKey)
}

export const IcattHeartcore = {
  install(app: App, config: Config) {
    app.provide(injectionKey, getUmbracoApi(config))
  },
}
