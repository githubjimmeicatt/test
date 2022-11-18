/* eslint-disable import/no-extraneous-dependencies */
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import svgLoader from 'vite-svg-loader'
import { fileURLToPath, URL } from 'node:url'

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
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      'icatt-heartcore': fileURLToPath(new URL('./src/icatt-heartcore/entry.ts', import.meta.url)),
    },
  },
})
