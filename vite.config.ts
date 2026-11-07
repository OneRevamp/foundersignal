import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { VitePWA } from 'vite-plugin-pwa';

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      includeAssets: ['favicon.svg'],
      manifest: {
        name: 'Founder Signal',
        short_name: 'Founder Signal',
        description: 'Protect attention. Improve judgment. Build meaningful work.',
        theme_color: '#f5f3ee',
        background_color: '#f5f3ee',
        display: 'standalone',
        start_url: '/',
        icons: [{ src: '/app-icon.svg', sizes: 'any', type: 'image/svg+xml', purpose: 'any maskable' }],
      },
      workbox: { navigateFallback: '/index.html' },
    }),
  ],
});
