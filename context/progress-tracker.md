# Progress Tracker

Update this file after every meaningful implementation change.

---

## Current Phase

**Phase 5: Core MVP Features**

**Status:** 🔄 IN PROGRESS
**Date:** 2026-08-02
**Branch:** `ab/target-it-phase-5-core-features`  
**Review branch note:** if OpenClaw exports changes through a different review branch name (for example `vscode-changes`), keep this value as the historical implementation branch and note the exported branch separately.

---

## Completed

### Phase 1: Planning & Context Setup ✅

**Status:** COMPLETE  
**Date:** 2026-08-02  
**Branch:** `ab/target-it-planning-context`

**Completed Work:**
- Reviewed Target-IT workspace structure
- Inspected current SwiftUI entry files and identified placeholder app state
- Reviewed the pitch/prototype PDFs in `target-it/`
- Extracted the core feature pillars from the prototype:
  - Manage & Cancel Instantly
  - Automated Savings Goals
  - Proactive Billing Alerts
  - Real-Time Notification Feed
- Confirmed with Tone that this is a **local-only MVP** with **no external APIs**
- Confirmed that the app requires an **interactive tour** for presentations
- Confirmed the app needs stronger team individuality so it does not look like the other cohort projects
- Selected the accessibility direction: **VoiceOver-first billing awareness** with Dynamic Type, Reduce Motion, and non-color-only status support
- Captured the team's loading-screen preference: native SwiftUI `ProgressView()` with `CircularProgressViewStyle(tint: .brown)`
- Created project-specific `AGENTS.md`
- Replaced placeholder `/context/` templates with Target-IT-specific implementation guidance

### Phase 4: Interactive Tour ✅

**Status:** VERIFIED / POLISHED  
**Date:** 2026-08-02  
**Branch:** `ab/target-it-phase-4-tour-check`

**Completed Work:**
- Verified `InteractiveTourView` exists and is wired into onboarding
- Added a direct path from the tour back to `WelcomeView`
- Added replay support from inside the app shell
- Added demo-user presentation support using `kaylaJones`
- Logged that the guided flow, onboarding connection, restart support, and basic accessibility are in place

---

## In Progress

### Phase 5: Core MVP Features 🔄

**Status:** IN PROGRESS  
**Date:** 2026-08-02  
**Branch:** `ab/target-it-phase-5-core-features`

**Current Focus:**
- Implement real core feature behavior behind the current shell
- Start with the subscription-management path
- Keep the implementation simple and aligned with how Tone taught the interns
- Log progress after each meaningful step per Tone's instruction

**Completed So Far In Phase 5:**
- Phase 5 branch created and approved
- Phase 5 implementation pass started
- Added `AppDataStore` as a simple local feature store for shell data
- Added a working `SubscriptionDetailView`
- Added a simulated cancel flow that updates subscriptions, savings, reminders, and alerts together
- Wired the shell to use shared local feature state instead of fixed read-only demo arrays
- Turned `AlertsView` into a simple combined reminder center with upcoming reminders and notification feed sections
- Added singular/plural summary text and explicit empty states to the reminder center so the screen still reads clearly when one or both lists are empty
- Fixed the replay-tour build error by giving `InteractiveTourView` an initializer that accepts `isReplayMode`
- Fixed student-Mac build errors in `AppDataStore` by importing `Combine` so `ObservableObject` and `@Published` resolve correctly in Xcode

**Phase 5 Checklist:**
- ✅ Add a simple local app data store for subscriptions, savings, reminders, and notifications
- ✅ Build a working subscription detail screen
- ✅ Let users simulate canceling a subscription
- ✅ Reflect canceled-subscription savings inside the savings and alerts surfaces
- ✅ Add reminder center behavior
- ✅ Keep the implementation readable and intern-friendly
- ⏳ Run simulator/build verification in the student Xcode environment

---

## Next Up

### Phase 5: Core MVP Features

**Goal:** Turn the current shell into a working MVP experience with real local feature behavior.

**Remaining Priority Tasks:**
- Verify the new subscription detail, cancel flow, and reminder center on the student MacBook in Xcode
- Keep logging each meaningful Phase 5 feature pass

---

## Open Questions

1. Should the interactive tour auto-advance, manual-advance, or support both?
2. Do we want a single local user perspective only, or a simple local profile state for demo personalization?
3. Do we want seeded subscriptions to mirror the PDF examples directly (Netflix, Spotify, YouTube, Gym Pass) for pitch familiarity?
4. After onboarding, should the user land on Home/Dashboard first or another section?

---

## Architecture Decisions

- **Local-only MVP** — no external APIs or live integrations.
- **SwiftUI + SwiftData direction** — local storage is the preferred persistence approach for later phases.
- **Interactive tour is a core product feature** — required for demos and pitching.
- **Accessibility direction chosen** — VoiceOver-first billing awareness, supported by Dynamic Type, Reduce Motion, and text+icon status communication.
- **Prototype-informed shell** — likely Home / Subs / Savings / Alerts navigation.

---

## Technical Findings

### Current Codebase State

- `ContentView.swift` follows an onboarding-first root flow: `LoadingView` → `WelcomeView` → `InteractiveTourView` / auth entry → `MainTabView`.
- Local SwiftData auth entry is now present through `SignUpView`, `LoginView`, `User.swift`, and `AuthSession.swift`.
- `LoadingView` and `WelcomeView` share the light onboarding background, while the rest of the app is white.
- Primary buttons are standardized to brown background with semibold white text.
- The shell and onboarding code have been split into simpler files that better match the teaching pattern.

### Product Findings from PDFs

- Subscription tracking is the product anchor.
- Reminder timing and notification feed are key pitch points.
- Savings redirection from canceled subscriptions is a major differentiator.
- The design language suggests premium finance UI rather than a generic utility app.

---

## Session Notes

- Tone approved moving from Phase 4 verification into Phase 5.
- Tone wants the implementation to stay simple enough for teenage first-time coders to follow.
- **Tone instruction:** always log progress in `/context/progress-tracker.md`.

---

## Phase Roadmap (Working Draft)

### Phase 2 — App Stabilization
- ✅ Fix malformed SwiftUI files
- ✅ Establish a clean entry flow
- ✅ Fix Xcode test import issue and asset symbol conflicts
- ⏳ Verify app builds and launches in a macOS/Xcode environment

### Phase 3 — App Shell & Local Data Foundation
- ✅ Rework shell implementation around the corrected onboarding flow
- ✅ Seed local subscription, savings, and reminder data
- ✅ Implement local SwiftData sign-up and login flow
- ✅ Establish core screen structure after Welcome / Tour / Auth entry is in place

### Phase 4 — Interactive Tour
- ✅ Build guided demo flow
- ✅ Connect it into the onboarding/auth flow
- ✅ Add restart support from inside the app shell
- ✅ Add a route back to `WelcomeView`
- ✅ Deepen the tour so it matches the final pitch expectations more completely
- ✅ Basic accessibility support is present (page progress, reduce-motion-aware paging, readable controls)
- ✅ Verification and polish pass complete

### Phase 5 — Core MVP Features
- ✅ Implement the working subscriptions flow
- ✅ Add reminder center behavior
- ✅ Add notification feed behavior
- ✅ Connect canceled subscriptions to savings progress
- ✅ Add simulated cancel/reroute flow end to end

### Phase 6 — Accessibility & Polish
- VoiceOver summary refinement
- Dynamic Type validation
- Reduce Motion support
- Status/icon accessibility cleanup

---

*Last Updated: 2026-08-02*