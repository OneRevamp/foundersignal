# Founder Signal — Project Brief
## v3.0 — Local-First Progressive Web App

This document is the single source of truth for the project. Read it before starting any implementation task.

---

# 1. Vision

Founder Signal helps founders, creators, and professionals build better businesses by improving the quality of their decisions and their relationship with technology.

It is **not** a productivity app. **Not** a habit tracker. **Not** a screen-time shame machine.

> **Protect attention. Improve judgment. Build meaningful work.**

Technology is not the enemy. Unconscious use is. The app never shames — it asks: *Is this still helping you?*

## Brand personality
Calm. Thoughtful. Optimistic. Intelligent. Trustworthy. Timeless.
Never: addictive, loud, gamified, childish, stressful, manipulative.

Opening the app should feel like opening a beautiful notebook every morning.

## Design principles
Large whitespace. Comfortable typography. Minimal colors. Warm neutral backgrounds. No flashing numbers, no badges, no engagement-maximizing tricks.

---

# 2. Core Architecture: Zero-Server, Local-First PWA

**There is no backend.** No accounts, no login, no cloud database. All user data — Reflections, Attention logs, Deep Work sessions, Archive — lives exclusively in the user's browser on that device.

### Why
- The product's promise that we have no access to user data is an architectural fact, not merely a policy statement.
- The app does not want to own the user's attention or their data.
- There are no backend hosting, authentication, database, or compliance costs for storing personal reflections.

### What this means concretely
- **Application:** React + TypeScript + Vite, responsive desktop-first PWA.
- **Local storage:** IndexedDB through Dexie. All personal records and cached editorial content remain in the browser profile on the device.
- **Accounts:** none. No account or cross-device identity system.
- **Sync:** none for MVP. Data is browser-profile and device specific.
- **Backup:** user-initiated export/import is planned for a later phase. Browser storage can be cleared by the user or browser; the app must explain this limitation before backup is introduced.
- **Content delivery:** Daily Signal and Learning Library may use anonymous, read-only fetches of published static JSON. No user data, identifiers, or personal content may be sent.
- **Offline:** a service worker caches the app shell and static assets. Previously fetched editorial content is stored locally in IndexedDB. Core features must remain useful without a network connection.
- **No AI features:** insights are rules-based and computed locally. No LLM-generated narratives or AI provider calls.

### Browser privacy and storage boundaries

Local browser storage is private to the browser profile on the device, but it is not equivalent to an encrypted native database. Other browser-profile users, device administrators, extensions with sufficient permissions, or someone with access to an unlocked device may have ways to access it. Do not promise encryption at rest unless it is implemented and reviewed. Browser data may be removed when site data is cleared; storage persistence is best-effort and browser-dependent.

---

# 3. Product Pillars

## Daily Signal
Short daily article (2–5 min read), one practical action at the end. Delivered via anonymous static content fetch. Also published publicly as marketing content.

## Reflection
Guided prompts (What mattered today? What decision did I avoid? etc.). Saved locally. Feeds the Archive.

## Attention
A reflective view of intentional time spent within Founder Signal, plus user-entered context and budgets. A PWA cannot read system-wide app usage, inspect other apps, or access native Android UsageStatsManager / iOS Screen Time data. Never present browser activity as a complete picture of device attention. Calm prompts, never shame.

## Deep Work
Distraction-free in-app timer. The timer can track elapsed time while the app is open; background/suspended-tab behavior varies by browser. Do not rely on guaranteed background execution or notifications.

## Learning Library
Five-minute lessons across leadership, marketing, decision-making, negotiation, finance, brand strategy, psychology, communication, and systems thinking. Delivered via the same static content fetch as Daily Signal.

## Weekly Review
Rules-based narrative summary built entirely from local Reflection, Attention, and Deep Work data. Nothing is transmitted.

## Founder Journey
Meaningful stages (Explorer → Builder → Operator → Leader → Strategist → Mentor) based on real actions completed, not streaks or XP. Understated UI treatment.

## The Archive
Unified, searchable local view of Signals read, Reflections written, Lessons completed, and Weekly Reviews generated.

---

# 4. Technology

| Layer | Choice | Notes |
|---|---|---|
| Application | React + TypeScript + Vite | Responsive desktop-first web app |
| PWA | Web App Manifest + Service Worker / Workbox | Installable where supported; offline app shell |
| Local database | IndexedDB via Dexie | Browser-local records and editorial cache |
| Content delivery | Anonymous static JSON fetch | Read-only; no user data sent |
| Testing | TypeScript checks + focused browser tests | Add automation as features mature |
| Hosting | Static hosting | No application server or API required |

**Explicitly not used:** Firebase, backend servers, cloud databases, authentication providers, analytics SDKs that phone home, AI provider SDKs, or user-data sync.

---

# 5. Phased Build Plan

## Phase 0 — PWA Foundation
- React + TypeScript + Vite scaffold
- Responsive desktop-first application shell and feature navigation
- Dexie / IndexedDB schema for Reflections, AttentionLogs, DeepWorkSessions, Signals, Lessons, WeeklyReviews
- Web app manifest, service worker, app icons, offline app-shell support
- Feature-oriented modules and shared styling
- No auth, backend, analytics, or personal-data network calls

**Definition of done:** production build and type checks pass; PWA manifest and service worker are generated; shell adapts to desktop and mobile; local database opens successfully.

## Phase 1 — Daily Signal (content pipeline)
- Static JSON content file format defined (id, title, body, category, action item, publish date)
- Anonymous read-only fetch + local IndexedDB cache (works offline after first fetch)
- Home screen renders today's Signal
- Archive list of past Signals

## Phase 2 — Reflection
- 3–4 guided prompts, saved to local IndexedDB
- Entry list view

## Phase 3 — Attention (browser-appropriate scope)
- In-app focus/attention sessions and user-entered context
- Category budgets and calm reflection prompts
- Clear explanation that the PWA cannot measure whole-device or other-app usage
- No native usage-statistics or Screen Time integration in the web app

## Phase 4 — Deep Work
- Distraction-free timer and daily objective field
- Elapsed-time handling that remains honest when tabs are suspended or closed
- Optional ambient sound only from royalty-free / CC0 sources

## Phase 5 — Weekly Review
- Rules-based template engine pulling from local Reflection + Attention + Deep Work data
- No AI/LLM calls

## Phase 6 — Learning Library + Archive Search
- Static content fetch using the same pipeline as Signal
- Local search across all content types

## Phase 7 — Founder Journey
- Stage progression logic based on completed actions
- Understated UI treatment

## Phase 8 — Polish, Export/Backup, and Release Prep
- User-initiated local export/import with clear security and browser-storage caveats
- Optional browser notifications only where supported and only as a nonessential enhancement
- Responsive, accessibility, privacy, offline, and cross-browser review
- Static hosting and PWA installation guidance

**MVP ends here. No further phases planned until post-beta feedback.**

---

# 6. Explicitly Deferred / Cut

- Multi-device sync — cut for MVP
- Native iOS / Android applications — not part of this PWA build
- System-wide app usage monitoring — unavailable to ordinary PWAs
- Browser extension — cut
- AI-generated narratives / any AI provider integration — cut permanently
- Payments — only revisit if/when there is something worth charging for
- True per-user self-hosting — not required for MVP

---

# 7. Budget

| Item | Cost |
|---|---|
| React, TypeScript, Vite, Dexie | Free, open source |
| Static hosting | Free tiers available |
| Static editorial content | Can be hosted with the app or on a static public source |
| Backend / database / auth | None |

---

# 8. Promotion

1. Publish Daily Signal articles publicly before launch to build a content backlog.
2. Invite a small beta group of founders and creators from the existing network.
3. Position the product around the promise: "we don't want your attention or your data."
4. Keep the product experience calm, useful, and free of engagement-maximizing mechanics.

---

# 9. Working With AI Coding Assistants

- Read this brief and `Agents` before each task.
- Work on one phase per task; do not queue multiple phases in parallel.
- Review every pull request before merging.
- Browser limitations are product constraints, not implementation bugs to work around.
- Resolve architectural or UX ambiguity in conversation before implementation.
