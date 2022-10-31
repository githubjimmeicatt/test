/* eslint-disable import/no-extraneous-dependencies */
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import svgLoader from 'vite-svg-loader'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(), svgLoader()],
  build: {
    outDir: '../wwwroot',
    emptyOutDir: true,
    manifest: true,
    rollupOptions: {
      input: './src/main.js',
    },
  },
  server: {
    port: 33446,
    hmr: {
      protocol: 'ws',
    },
  },
})
