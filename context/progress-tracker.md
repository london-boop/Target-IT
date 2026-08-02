# Progress Tracker

Update this file after every meaningful implementation change.

---

## Current Phase

**Phase 2: App Stabilization**

**Status:** 🔄 IN PROGRESS
**Date:** 2026-08-02
**Branch:** `ab/target-it-phase-2-stabilization`

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

### Phase 2: App Stabilization 🔄

**Status:** IN PROGRESS  
**Date:** 2026-08-02  
**Branch:** `ab/target-it-phase-2-stabilization`

**Current Focus:**
- Repair `LoadingView.swift`
- Preserve the team's own splash/loading identity
- Establish a cleaner app entry flow before feature implementation
- Log progress after each meaningful step per Tone's instruction

**Completed So Far In Phase 2:**
- Rebuilt `LoadingView.swift` into a valid SwiftUI splash screen
- Preserved the team's preferred native `ProgressView()` with `CircularProgressViewStyle(tint: .brown)`
- Added a short branded loading experience with Reduce Motion-aware behavior
- Updated `ContentView.swift` to transition from `LoadingView` into a branded welcome placeholder instead of the broken initial layout

---

## Next Up

### Phase 2: App Stabilization

**Goal:** Repair the current SwiftUI foundation so the app launches and runs reliably in simulator.

**Priority Tasks:**
- Inspect and fix malformed `LoadingView.swift` while preserving it as the team's splash/loading screen
- Implement the team's preferred loading indicator: native `ProgressView()` with `CircularProgressViewStyle(tint: .brown)`
- Review `ContentView.swift` and replace placeholder assumptions with a real entry flow direction
- Verify which project path is the true working target and avoid confusion from duplicate artifacts
- Run simulator/build verification
- Document any structural fixes before building feature flows

---

## Open Questions

1. Should the MVP use a lightweight welcome screen before the interactive tour, or should the tour be the primary first-run experience?
2. Do we want a single local user perspective only, or a simple local profile state for demo personalization?
3. Should the main app shell use `TabView` exactly as implied by the prototype (`Home`, `Subs`, `Savings`, `Alerts`), or adapt it slightly for cleaner demo flow?
4. Should the interactive tour auto-advance, manual-advance, or support both?
5. Do we want seeded subscriptions to mirror the PDF examples directly (Netflix, Spotify, YouTube, Gym Pass) for pitch familiarity?

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

- `ContentView.swift` now acts as a temporary root flow: `LoadingView` → branded welcome placeholder.
- `LoadingView.swift` has been repaired and now uses the team's preferred native brown circular `ProgressView()`.
- The project includes matching root and nested `.xcodeproj` files, which may confuse future edits even though the contents currently match.
- Existing color assets are present (`Black`, `Brown`, `Gold`, `Sage`, `White`) and should be used before adding new palette values.
- Build verification is currently blocked in this workspace because `xcodebuild` and `swift` are not available on the Linux host.

### Product Findings from PDFs

- Subscription tracking is the product anchor.
- Reminder timing and notification feed are key pitch points.
- Savings redirection from canceled subscriptions is a major differentiator.
- The design language suggests premium finance UI rather than a generic utility app.

---

## Session Notes

- Tone approved moving from plan mode into context setup.
- Tone then approved Phase 2 work on branch `ab/target-it-phase-2-stabilization`.
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
- ⏳ Verify app builds and launches in a macOS/Xcode environment

### Phase 3 — App Shell & Local Data Foundation
- Create main shell/navigation
- Seed local subscription, savings, and reminder data
- Establish core screen structure

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