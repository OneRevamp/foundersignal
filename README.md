# Founder Signal

A calm, responsive, local-first Progressive Web App for protecting attention and improving judgment. Designed desktop-first, with layouts that adapt to tablets and phones. It can be installed from supported browsers and continues to serve its app shell offline after the first successful load.

## Development

Requirements: Node.js 20.19+ or 22.12+ and npm.

```sh
npm install
npm run dev
```

Create a production build and run the local checks:

```sh
npm run typecheck
npm run build
npm run preview
```

## Architecture

- React + TypeScript + Vite for the application.
- Dexie / IndexedDB for all user-created and cached content on this device.
- A service worker and web app manifest provide offline app-shell support and installation where supported.
- No backend, accounts, authentication, cloud database, analytics SDK, or AI provider SDK.
- The only permitted application network request is an anonymous, read-only fetch of published static Daily Signal / Learning Library content. Never send reflections, attention logs, sessions, or other personal data over the network.

## Browser capability boundaries

A PWA cannot read system-wide app usage or obtain the native Android `UsageStatsManager` / iOS Screen Time data. Attention features must therefore be based on deliberate in-app/browser interactions and user-entered context, and must not imply whole-device monitoring. Background execution and notifications vary by browser and operating system; core workflows must not depend on them.

See [Project Brief.md](Project%20Brief.md) for the product requirements and revised phased roadmap.
