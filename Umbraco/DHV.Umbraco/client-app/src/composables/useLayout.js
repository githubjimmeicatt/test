import cleanGlobImport from '../helpers/cleanGlobImport'

const layouts = cleanGlobImport(import.meta.globEager('../layout/*.vue'))
const theme = window.UMBRACO_PORTAL?.theme
const layout = layouts[`layout${window.UMBRACO_PORTAL?.layout || ''}`.toLowerCase()]

export default function useLayout() {
  return {
    theme,
    layout,
  }
}
