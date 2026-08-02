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

- `TargetIT/TargetIT/Onboarding/` — Splash, welcome, interactive tour, and auth entry flow
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
- Sign Up is the primary new-user entry path after the interactive tour
- Login must be available from the Sign Up experience for returning users
- The app behaves like a personal finance assistant on one device during MVP
- If profile state is needed, keep it local and lightweight

## Navigation Structure

### Planned Flow

```text
App Launch
  ↓
LoadingView
  ↓
WelcomeView
  ↓
Get Started
  ↓
InteractiveTourView
  ↓
SignUpView
   └── LoginView (for returning users)
  ↓
Main Shell
  ├── Home / Dashboard
  ├── Subs / Subscriptions
  ├── Savings
  └── Alerts / Notifications
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
Seeded local demo data
    ↓
Light service or view model layer (only when helpful)
    ↓
SwiftUI views
```

### Guidance

- Views may read local data directly when simple
- Introduce view models only when multiple views need shared orchestration
- Keep business rules small and explicit so students can follow them
- Use seeded local data to simulate real subscription behavior before full SwiftData persistence lands

## Invariants

1. **No external network calls in the MVP** — all app behavior must work offline with local data.
2. **Core flows must remain demoable in simulator** — avoid dependencies on unavailable services.
3. **All important money/status information must be accessible to VoiceOver**.
4. **Do not rely on color alone to communicate subscription state**.
5. **Animations must respect Reduce Motion**.
6. **SwiftData operations must remain on the main actor / UI-safe path**.
7. **Interactive tour is part of the product, not disposable marketing-only UI**.
8. **WelcomeView is the post-loading entry point before the main shell**.
9. **Context docs must stay synchronized with implementation decisions**.

## Proposed Screen Structure

```text
TargetITApp
└── ContentView   # Root container
    ├── LoadingView
    ├── WelcomeView
    ├── InteractiveTourView
    ├── SignUpView
    ├── LoginView
    └── MainTabView
        ├── DashboardView
        ├── SubscriptionsView
        ├── SavingsView
        └── AlertsView
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
- A first-pass `MainTabView` shell spike exists behind onboarding, and the current implemented root flow now follows Tone's corrected path: `LoadingView` → `WelcomeView` → `InteractiveTourView` → `SignUpView`, with `LoginView` available for existing users.
- There appear to be duplicate project artifacts (`TargetIT.xcodeproj` at root and nested path), though the project file contents currently match.
- Color assets exist, but dark-mode behavior should be verified during implementation because named colors like `Gold` and `Sage` were originally flipping to white in dark appearance definitions.
- Conflicting asset names `Black`, `Brown`, and `White` were renamed to `TargetBlack`, `TargetBrown`, and `TargetWhite` to avoid generated symbol conflicts in Xcode.
- Build verification is blocked on this host because Xcode tooling is unavailable in the Linux environment.

## Architecture Decisions

| Decision | Status | Reason |
|----------|--------|--------|
| Local-only MVP | Decided | Tone confirmed no external APIs are needed |
| SwiftData for main persistence | Planned | Best fit for local seeded finance demo |
| Seed data before persistence | Active | Fastest way to make the MVP shell demoable in simulator |
| Interactive tour as core feature | Decided | Required for pitch/demo use |
| Welcome before tour | Decided | Tone clarified WelcomeView is the real app entry after loading |
| Sign Up with Login path | Decided | Returning users need a direct auth route |
| Tab-based main shell | Active | Matches the prototype navigation language |
| VoiceOver-first billing awareness | Decided | Best Apple accessibility fit for the product |
| Simulated cancellation and savings routing | Decided | Keeps claims believable without backend integrations |

## Implementation Notes

During early build stabilization, it is acceptable to work with simpler in-memory or static seeded data before wiring full SwiftData persistence, as long as the docs and progress tracker are updated to reflect that temporary step.

**Current implementation note:** a first-pass shell spike still exists behind onboarding, but the implemented root flow now follows Tone's corrected path: `LoadingView` → `WelcomeView` → `InteractiveTourView` → `SignUpView`, with `LoginView` available for existing users. Remaining work is visual polish and deeper behavior, not restoring the flow itself.
