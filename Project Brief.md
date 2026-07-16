# Founder Signal — Project Brief
## v2.0 — Local-First, Zero-Server, Mobile-Only

This document is the single source of truth for the project. Any AI coding assistant (Jules, Claude, etc.) working on this repo should read this file before starting any task.

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

# 2. The Core Architectural Decision: Zero-Server, Local-First

**There is no backend.** No Firebase, no accounts, no login, no cloud database. All user data — Reflections, Attention logs, Deep Work sessions, Archive — lives exclusively on the user's device.

### Why
- It's the honest, literal version of "we have no access to your data" — not a policy promise, an architectural fact.
- It mirrors the product's own philosophy: the app doesn't want to own the user's attention *or* their data.
- It's also the cheapest possible build — no backend hosting, no auth, no database costs, no compliance overhead for storing personal reflections.

### What this means concretely
- **Storage:** local SQLite via Drift (Flutter package). All app data lives in a database file on-device.
- **Accounts:** none. Optional device-level PIN/Face ID/Touch ID app lock, not an account system.
- **Sync:** none for MVP. Single device only. (Explicitly deferred — see Section 6.)
- **Backup:** user-initiated only. An "Export my data" button writes an encrypted file via the OS share sheet to wherever the user chooses (their own iCloud/Drive/Files). The app never sees or stores this file after export. Reinstall = manual re-import.
- **Content delivery (Daily Signal, Learning Library):** read-only, anonymous fetch of a static content file (e.g., hosted free on GitHub Pages). This is a one-way pull with zero user data ever transmitted — it doesn't compromise the no-data promise.
- **No AI features.** Weekly Review and all other "insight" features are rules-based templates computed entirely on-device, not LLM-generated. This is a permanent product decision, not a cost-cutting MVP shortcut — it keeps the product calm, predictable, and true to the "less intrusive, more natural" feel the founder wants.

---

# 3. Product Pillars (Updated)

## Daily Signal
Short daily article (2-5 min read), one practical action at the end. Delivered via static content fetch (Section 2). Also published publicly (LinkedIn etc.) as marketing — see Section 8.

## Reflection
Guided prompts (What mattered today? What decision did I avoid? etc.). Saved locally. Feeds the Archive.

## Attention (now automatic, not manual)
Uses native OS APIs to measure real app/category usage instead of self-reporting:

- **Android:** `UsageStatsManager` (via `PACKAGE_USAGE_STATS` permission, granted once in system settings) gives real per-app usage data directly to the app — rich, named, minute-level detail.
- **iOS:** Apple's Screen Time API (`FamilyControls` + `DeviceActivity` + `ManagedSettings`). Important platform constraint: **raw per-app usage data is never exposed to the main app's code on iOS** — it's only renderable inside a sandboxed system extension. The main app can request authorization, let the user pick categories to monitor, set enforcement (shields/limits via `ManagedSettings`), and react to threshold-crossed events — but cannot build custom analytics from raw named numbers the way Android allows.
- Practical implication: Android gets rich real-usage insight; iOS gets enforcement + threshold nudges with coarser insight. Product copy and onboarding should be honest about this platform difference rather than promising identical experiences.

User sets intentional budgets per category (AI, Social, News, etc.) — not hard limits. When exceeded: a calm nudge, never a shame UI. "Is this still helping you?"

## Deep Work
Distraction-free timer. Optional ambient sound (royalty-free/CC0 loops only). Daily objective field. No streaks, no unnecessary stats.

## Learning Library
Five-minute lessons across leadership, marketing, decision-making, negotiation, finance, brand strategy, psychology, communication, systems thinking. Delivered via the same static content fetch as Daily Signal.

## Weekly Review
Rules-based (not AI-generated) narrative summary built entirely from local on-device data. E.g.: "Your strongest deep work happened between 8-10am. Attention drifted toward Instagram most on Wednesdays." Computed and rendered on-device, nothing transmitted anywhere.

## Founder Journey
Meaningful stages (Explorer → Builder → Operator → Leader → Strategist → Mentor) based on real actions completed, not streaks or XP. Understated UI — a label change, not a celebration animation.

## The Archive
Unified, searchable (local SQLite full-text search) view of all Signals read, Reflections written, Lessons completed, Weekly Reviews generated.

---

# 4. Tech Stack

| Layer | Choice | Notes |
|---|---|---|
| Framework | Flutter | Free, open-source, no licensing cost at any scale |
| State management | Riverpod | Less boilerplate than Bloc, more testable than plain Provider |
| Local database | Drift (SQLite) | Mature, well-supported local-first Flutter package |
| Local notifications | flutter_local_notifications | Scheduled, on-device only — nothing pushed from a server |
| Android usage data | `usage_stats` plugin / native platform channel to `UsageStatsManager` | Requires `PACKAGE_USAGE_STATS` permission |
| iOS usage data | Native platform channel to `FamilyControls` / `DeviceActivity` / `ManagedSettings` | Requires Family Controls entitlement from Apple |
| Content delivery | Static JSON fetch from a free-hosted source (GitHub Pages) | Read-only, anonymous, no user data sent |
| CI/CD | Skip for MVP | Add GitHub Actions free tier later if needed |

**Explicitly not used:** Firebase, any backend server, any AI provider SDK, any analytics SDK that phones home.

---

# 5. Phased Build Plan

## Phase 0 — Foundation
- Flutter project scaffold, mobile only (iOS + Android)
- Riverpod set up
- Drift database schema: Reflections, AttentionLogs, DeepWorkSessions, Signals (cached), Lessons (cached), WeeklyReviews
- Folder structure by isolated feature module: reflection, attention, deep_work, signal, library, review, journey, settings
- App-level lock screen (optional PIN/biometric) — device-level, not account-level
- No auth, no Firebase, no network calls except the static content fetch stub

**Definition of done:** app builds on a real device, empty shell navigation exists, local DB reads/writes work.

## Phase 1 — Daily Signal (content pipeline)
- Static JSON content file format defined (title, body, category, action-item, publish date)
- Fetch + local cache logic (works offline after first fetch)
- Home screen renders today's Signal
- Archive list of past Signals

## Phase 2 — Reflection
- 3-4 guided prompts, saved to local Drift DB
- Entry list view

## Phase 3 — Attention (the hard phase — native integration)
- Android: implement `UsageStatsManager` platform channel, permission request flow, category mapping
- iOS: implement `FamilyControls` authorization flow, category picker (`FamilyActivityPicker`), threshold event handling via `DeviceActivity`
- Budget-setting UI (non-punitive copy only)
- **Flag for extra review time** — most technically complex phase, platform-specific, less AI-assistant-reliable than the rest

## Phase 4 — Deep Work
- Distraction-free timer, optional ambient sound, daily objective field

## Phase 5 — Weekly Review
- Rules-based template engine pulling from local Reflection + Attention + Deep Work data
- No AI/LLM calls anywhere in this phase

## Phase 6 — Learning Library + Archive Search
- Static content fetch (same pipeline as Signal)
- Local SQLite full-text search across all content types

## Phase 7 — Founder Journey
- Stage progression logic based on completed actions
- Understated UI treatment

## Phase 8 — Polish, Export/Backup, Store Prep
- "Export my data" encrypted-file flow via OS share sheet
- Local notification copy pass (calm, max 1-2/day)
- App Store / Play Store listings, screenshots, privacy policy (genuinely simple to write given zero data collection)
- TestFlight + Play Internal Testing with 15-30 people from founder's existing network

**MVP ends here. No further phases planned until post-beta feedback.**

---

# 6. Explicitly Deferred / Cut

- Multi-device sync — cut for MVP; if ever revisited, must preserve zero-knowledge encryption (server, if any, must never be able to read data)
- Web dashboard — mobile-only
- Browser extension — cut
- AI-generated narratives / any AI provider integration — cut permanently, not deferred
- Payments/Stripe — add only if/when there's something worth charging for
- True per-user self-hosting (user runs own server) — possible future power-user option, not required for MVP

---

# 7. Budget

| Item | Cost |
|---|---|
| Flutter, Dart, Drift, Riverpod, all packages | Free |
| Local dev tools (VS Code/Android Studio) | Free |
| GitHub (private repo) | Free |
| Static content hosting (GitHub Pages) | Free |
| Royalty-free ambient sounds | Free |
| Privacy policy generator | Free |
| Apple Developer Program | $99/year |
| Google Play Developer account | $25 one-time |
| Domain (optional, for landing page) | ~$15-20/year |
| **Total to public beta, both platforms** | **~$140 one-time, no recurring backend cost** |

No AI API costs, ever, under this architecture. No hosting costs, ever, at any user scale, since there's no backend to scale.

---

# 8. Promotion (Zero Budget)

1. **Publish Daily Signal articles publicly now**, before the app exists — LinkedIn, or folded into the existing "Human in the Room" / "The Signal" content strategy. Builds an audience and content backlog for free.
2. **Beta list from existing network** — founders, agencies, creative directors already in the founder's orbit.
3. **Self-run Product Hunt launch** — the "we don't want your attention *or* your data" narrative is strong, differentiated Product Hunt material.
4. **Manifesto landing page** — this document, cleaned into a public one-pager. Free to host.
5. **Shareable Weekly Reviews** — a "copy as text" export of the local weekly narrative, zero-cost organic loop.

No paid user acquisition until real retention data justifies it.

---

# 9. Working With AI Coding Assistants (Jules)

- Jules is async: give it one scoped phase as a task, it clones the repo, plans, implements, tests, and opens a PR. Review the PR like a teammate's before merging.
- One phase = one task. Don't queue multiple phases in parallel.
- Phase 3 (Attention/native platform integration) needs the most human review — native permission APIs are exactly the kind of "ambiguous, undocumented system coordination" work async agents handle less reliably.
- Architecture or UX judgment calls should be resolved in conversation first, then handed to Jules as a concrete, unambiguous brief.
- See `AGENTS.md` for standing rules Jules should follow on every task.
