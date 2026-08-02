# Progress Tracker

Update this file after every meaningful implementation change.

---

## Current Phase

**Phase 3: App Shell & Local Data Foundation**

**Status:** 🔄 IN PROGRESS
**Date:** 2026-08-02
**Branch:** `ab/target-it-phase-3-shell-data`  
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

---

## In Progress

### Phase 3: App Shell & Local Data Foundation 🔄

**Status:** IN PROGRESS  
**Date:** 2026-08-02  
**Branch:** `ab/target-it-phase-3-shell-data`

**Current Focus:**
- Split the implementation into separate files/folders the way Tone taught the interns
- Restore `WelcomeView` as the real post-loading entry point
- Make `WelcomeView` and `InteractiveTourView` more visually consistent with the Prototype PDF
- Keep the implementation style aligned with how Tone taught the interns
- Log progress after each meaningful step per Tone's instruction

**Completed So Far In Phase 3:**
- Updated the phase branch and tracker for Phase 3 work
- Built a first-pass tab shell spike to test local data structure and core sections
- Added local demo models and seeded data for subscriptions, savings goals, reminders, and alerts
- Added first-pass Home, Subs, Savings, and Alerts screens using the local seeded data
- Corrected asset color definitions so dark mode no longer flips core named colors to white
- Reinserted `WelcomeView` as the true post-loading entry point
- Added placeholder `InteractiveTourView`, `SignUpView`, and `LoginView` stages so the corrected onboarding-first app flow exists in code before deeper feature polish
- Simplified the root flow to match the teaching style used in the other cohort apps: `NavigationStack`, `NavigationLink`, and straightforward screen-to-screen progression
- Added explanatory comments throughout the implementation so interns can understand what each code block does
- Tone flagged that the current one-file implementation is still not aligned with how the interns were taught, so the next correction is to split it into separate files by screen/component/model
- Split the implementation into separate onboarding files, main shell files, reusable components, models, and utilities so the structure now matches the teaching pattern more closely
- Added accessibility grouping to `ReminderCard` so VoiceOver behavior matches sibling cards
- Updated `ContentView.swift` to honor Reduce Motion during the LoadingView → WelcomeView handoff by skipping the fade animation when motion reduction is enabled
- Wrapped `WelcomeView` content in a `ScrollView` so the CTA path remains reachable on smaller devices and larger Dynamic Type sizes
- Corrected onboarding contrast so the light `LoadingView`/`WelcomeView` background uses darker title, tagline, and supporting text, keeping the splash and welcome screens visually consistent
- Updated `WelcomeView` to use the same light gradient background as `LoadingView` so onboarding stays visually consistent from splash to welcome
- Screenshot review showed Xcode was paused in the debugger at `LoadingView`, so the white-screen symptom was partly caused by debug pause state rather than the view never loading

**Phase 3 Correction / Current Direction:**
- Tone clarified that the first real destination after `LoadingView` must be `WelcomeView`
- Correct onboarding flow should be: `LoadingView` → `WelcomeView` → `Interactive Tour` → `Sign Up`
- `Sign Up` must also provide a path to `Login` for returning users
- The current shell exists behind onboarding as a spike, but the onboarding-first flow is now the implemented root path
- Tone clarified that the Prototype PDF is the UI guideline for the MVP, so implementation should stay visually consistent with the PDF
- Tone clarified that the code style should stay closer to how the interns were taught in the other cohort projects and include notes explaining meaningful code blocks
- Tone emphasized that **simple is better** for this team: write for teenage interns, some coding for the first time, and avoid coding it like a senior-dev-only implementation

---

## Next Up

### Phase 3: App Shell & Local Data Foundation

**Goal:** Keep the corrected onboarding-first flow in place while improving the Welcome, Tour, and auth placeholder screens to better match the Prototype PDF.

**Priority Tasks:**
- Verify the updated loading sequence now renders visibly in the student simulator before continuing visual polish
- Refine `WelcomeView` so it stays readable across device sizes and Dynamic Type settings
- Improve `InteractiveTourView` to better match the PDF while preserving the simple teaching style
- Keep the placeholder `SignUpView` and `LoginView` consistent with the guided onboarding flow
- Continue splitting implementation into clear screen/component/model files when needed
- Run simulator/build verification in the student Xcode environment

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

- `ContentView.swift` now follows an onboarding-first root flow: `LoadingView` → `WelcomeView` → placeholder tour/auth stages → `MainTabView`.
- `LoadingView.swift` has been repaired and now uses the team's preferred native brown circular `ProgressView()`.
- Student later reported a white-screen-only simulator launch, so the loading sequence was simplified and then refactored again to match the much simpler splash pattern used in LifeStarter.
- Screenshot review showed the app paused in Xcode at `LoadingView.init(onFinished:)`, so the remaining callback-style handoff logic was removed from `LoadingView` and the splash now uses a simple `onAppear` animation pattern while `ContentView` handles the delayed transition to `WelcomeView`.
- The project includes matching root and nested `.xcodeproj` files, which may confuse future edits even though the contents currently match.
- Existing color assets are present (`TargetBlack`, `TargetBrown`, `Gold`, `Sage`, `TargetWhite`) and should be used before adding new palette values.
- Build verification is currently blocked in this workspace because `xcodebuild` and `swift` are not available on the Linux host.
- Student Xcode build report surfaced two concrete issues, both now addressed in the workspace:
  - simplified unit/UI test placeholder files so they do not import `Testing` or `XCTest` during stabilization
  - renamed conflicting asset names `Black`, `Brown`, and `White` to `TargetBlack`, `TargetBrown`, and `TargetWhite`
- Student rebuild then reported `No such module 'XCTest'`, so the placeholder test sources were simplified further to import nothing while the project remains in stabilization mode.

### Product Findings from PDFs

- Subscription tracking is the product anchor.
- Reminder timing and notification feed are key pitch points.
- Savings redirection from canceled subscriptions is a major differentiator.
- The design language suggests premium finance UI rather than a generic utility app.

---

## Session Notes

- Tone approved moving from plan mode into context setup.
- Tone then approved Phase 2 work on branch `ab/target-it-phase-2-stabilization`.
- Tone approved continuing Phase 3 and later clarified that Welcome must remain the post-loading entry point.
- This project follows the same overall support pattern used for the other Swift cohort projects.
- The implementation should stay believable for a local simulator demo rather than pretending to perform live banking or cancellation operations.
- The interactive tour should help the students explain the product clearly during the pitch, not just onboard an end user.
- The app should maintain its own individuality and not visually blend into the other cohort projects.
- **Tone instruction:** always log progress in `/context/progress-tracker.md`.

---

## Phase Roadmap (Working Draft)

### Phase 2 — App Stabilization
- ✅ Fix malformed SwiftUI files
- ✅ Establish a clean entry flow
- ✅ Fix Xcode test import issue and asset symbol conflicts
- ⏳ Verify app builds and launches in a macOS/Xcode environment

### Phase 3 — App Shell & Local Data Foundation
- 🔄 Rework shell implementation around the corrected onboarding flow
- ✅ Seed local subscription, savings, and reminder data
- 🔄 Establish core screen structure after Welcome / Tour / Auth entry is in place

### Phase 4 — Interactive Tour
- Build guided demo flow
- Connect it to the app shell
- Add restart and accessibility support

### Phase 5 — Core MVP Features
- Subscription list/detail
- Reminder center
- Notification feed
- Savings goal tracking
- Simulated cancel/reroute flow

### Phase 6 — Accessibility & Polish
- VoiceOver summary refinement
- Dynamic Type validation
- Reduce Motion support
- Status/icon accessibility cleanup

---

*Last Updated: 2026-08-02*