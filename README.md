# Founder Signal

A calm, mobile-only companion for protecting attention and improving judgment.

## Phase 0 foundation

This branch establishes the Flutter app shell, Riverpod root scope, local Drift database schema, and feature-oriented navigation structure.

### Requirements

- Flutter SDK (3.22 or newer)
- Dart SDK (3.4 or newer)
- Xcode for iOS builds
- Android Studio / Android SDK for Android builds

### Run locally

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Run checks with:

```sh
flutter analyze
flutter test
```

The Drift database is stored in the app's local documents directory. The schema includes Reflections, AttentionLogs, DeepWorkSessions, Signals, Lessons, and WeeklyReviews.

## Architecture guardrails

- No backend, accounts, Firebase, cloud database, analytics SDK, or AI provider SDK.
- User-created data remains on-device in SQLite through Drift.
- Any future content delivery is limited to anonymous, read-only static content requests.
- Feature modules stay isolated under `lib/features/`.
- Platform-specific attention capabilities must be implemented honestly; iOS does not expose raw per-app usage totals to the main app.

See [Project Brief.md](Project%20Brief.md) for the product requirements and phased roadmap.
