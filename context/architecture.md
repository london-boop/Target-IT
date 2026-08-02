# Architecture Context

## Stack

| Layer | Technology | Role |
|-------|------------|------|
| Framework | SwiftUI | Declarative UI for the full iOS MVP |
| Language | Swift 5.9+ | Modern iOS implementation language |
| Persistence | SwiftData | Local-first storage for MVP entities |
| Lightweight Preferences | UserDefaults / @AppStorage | Small flags like first-launch or tour completion |
| Platform | iOS 17+ | Target OS for the cohort build |
| IDE | Xcode 15+ / current cohort toolchain | Build, preview, and simulator workflow |

## System Boundaries

- `TargetIT/TargetIT/Onboarding/` — Splash, intro, interactive tour, and entry flow
- `TargetIT/TargetIT/Views/` — Main SwiftUI screens until the folder structure is expanded
- `TargetIT/TargetIT/Models/` — SwiftData entities for subscriptions, savings goals, reminders, and notifications
- `TargetIT/TargetIT/ViewModels/` — ObservableObject or @Observable types when shared state complexity warrants them
- `TargetIT/TargetIT/Services/` — Local seeders, demo-data orchestration, formatters, and tour state helpers
- `TargetIT/TargetIT/Utilities/` — Reusable helpers, constants, accessibility helpers, extensions
- `TargetIT/TargetIT/Assets.xcassets/` — App branding, logo, and named color assets
- `target-it/` — Pitch PDFs and source product reference material only, not runtime app assets

## Storage Model

**All MVP data is local. No external APIs.**

### SwiftData (Primary Local Storage)

Planned MVP entities:

- `SubscriptionRecord`
  - name
  - monthlyCost
  - billingCadence
  - nextBillingDate
  - status (`active`, `trialEnding`, `canceled`)
  - category / provider label
  - isRecommendedForCancellation flag (optional)
- `SavingsGoal`
  - title
  - targetAmount
  - currentAmount
  - targetDate
  - depositCadence
  - linkedSavedAmount summary
- `BillingReminder`
  - title
  - dueDate
  - amount
  - reminderType (`renewal`, `trialExpiration`, `weeklyDigest`, `monthlySummary`)
  - isRead / isEnabled
- `NotificationItem`
  - title
  - message
  - createdAt
  - category (`warning`, `success`, `digest`, `milestone`)
  - relatedSubscriptionName (optional)
- `TourProgress` (optional model or lightweight preference)
  - lastSeenStep
  - hasCompletedTour

### UserDefaults / @AppStorage

Use only for lightweight app state such as:

- hasSeenInteractiveTour
- preferred demo entry state
- last-selected tab if helpful

## Auth and Access Model

- **No external auth for MVP**
- Single local user perspective is acceptable for this phase
- The app behaves like a personal finance assistant on one device
- If profile state is needed, keep it local and lightweight

## Navigation Structure

### Planned Flow

```text
App Launch
  ↓
Splash / Branded Intro
  ↓
Welcome / Entry Decision
  ├── Take Interactive Tour
  │     ↓
  │   Main Dashboard
  └── Skip Tour
        ↓
      Main Dashboard
```

### Main App Shell

Preferred shell based on the prototype:

```text
Main App Shell
├── Home / Dashboard
├── Subs / Subscriptions
├── Savings
└── Alerts / Notifications
```

Use `TabView` if it best matches the prototype and keeps the demo simple.

## Data Flow

### MVP Principle

Use the simplest architecture that keeps the app teachable and stable.

Recommended flow:

```text
SwiftData / Seed Data
    ↓
Light service or view model layer (only when helpful)
    ↓
SwiftUI views
```

### Guidance

- Views may read local data directly using `@Query` when simple
- Introduce view models only when multiple views need shared orchestration
- Keep business rules small and explicit so students can follow them
- Use seeded local data to simulate real subscription behavior

## Invariants

1. **No external network calls in the MVP** — all app behavior must work offline with local data.
2. **Core flows must remain demoable in simulator** — avoid dependencies on unavailable services.
3. **All important money/status information must be accessible to VoiceOver**.
4. **Do not rely on color alone to communicate subscription state**.
5. **Animations must respect Reduce Motion**.
6. **SwiftData operations must remain on the main actor / UI-safe path**.
7. **Interactive tour is part of the product, not disposable marketing-only UI**.
8. **Context docs must stay synchronized with implementation decisions**.

## Proposed Screen Structure

```text
TargetITApp
└── ContentView   # Current temporary root container in Phase 2
    ├── LoadingView   # Team-named splash/loading entry screen
    └── WelcomeView   # Temporary branded landing state before tour/app shell

Future direction:
└── AppRootView
    ├── LoadingView
    ├── WelcomeView
    ├── InteractiveTourView
    └── MainTabView
        ├── DashboardView
        ├── SubscriptionListView
        ├── SavingsHubView
        └── AlertsView / NotificationCenterView
```

## Accessibility Architecture Direction

The featured Apple accessibility direction for this project is:

### VoiceOver-first Billing Awareness

This means:
- subscription cards need concise spoken summaries,
- reminder content needs human-readable urgency language,
- savings progress must be understandable without charts alone,
- and the interactive tour should announce each step clearly.

Supporting architecture expectations:
- Reusable accessibility labels for money/status cards
- Reduce Motion checks for splash/tour transitions
- Dynamic Type-safe layout choices from the start
- Status badges that combine text + icon + color

## Known Technical Findings

- `LoadingView.swift` was malformed and likely contributed to simulator/build issues.
- The team wants `LoadingView.swift` to remain their splash/loading screen identity, using native SwiftUI `ProgressView()` with `CircularProgressViewStyle(tint: .brown)`.
- `ContentView.swift` is now acting as a temporary root flow, but it does not yet reflect the final prototype architecture.
- There appear to be duplicate project artifacts (`TargetIT.xcodeproj` at root and nested path), though the project file contents currently match.
- Color assets exist, but dark-mode behavior should be verified during implementation because named colors like `Gold`, `Brown`, and `Sage` currently flip to white in dark appearance definitions.
- Build verification is blocked on this host because Xcode tooling is unavailable in the Linux environment.

## Architecture Decisions

| Decision | Status | Reason |
|----------|--------|--------|
| Local-only MVP | Decided | Tone confirmed no external APIs are needed |
| SwiftData for main persistence | Planned | Best fit for local seeded finance demo |
| Interactive tour as core feature | Decided | Required for pitch/demo use |
| Tab-based main shell | Planned | Matches the prototype navigation language |
| VoiceOver-first billing awareness | Decided | Best Apple accessibility fit for the product |
| Simulated cancellation and savings routing | Decided | Keeps claims believable without backend integrations |

## Implementation Notes

During early build stabilization, it is acceptable to work with simpler in-memory or static seeded data before wiring full SwiftData persistence, as long as the docs and progress tracker are updated to reflect that temporary step.

**Phase 2 implementation note:** the current entry flow is `ContentView` → `LoadingView` → `WelcomeView`, which gives the team a stable splash identity before the interactive tour and full app shell are introduced.