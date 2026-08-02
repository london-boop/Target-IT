# AI Workflow Rules

## Approach

Build Target-IT incrementally using a spec-driven workflow. The context files define what to build, how to build it, and what is currently known about the product. Implement against these docs instead of inventing behavior from scratch.

**Critical project truth:** this is a **local-first MVP** with **no external APIs**.

## Scoping Rules

- Work on one feature unit at a time
- Prefer small, verifiable increments over broad speculative rewrites
- Keep product planning, simulator stabilization, data modeling, and feature implementation separated into understandable phases
- Treat the interactive tour as a real product unit, not leftover polish
- Keep accessibility work integrated into the feature being built rather than postponed to the very end
- Preserve the team's own visual identity instead of defaulting to patterns from the other cohort apps

## Recommended Phase Order

### Phase 1 — Planning & Documentation
- Create `AGENTS.md`
- Replace placeholder context docs with Target-IT-specific guidance
- Capture current risks and product direction

### Phase 2 — App Stabilization
- Fix malformed SwiftUI files
- Resolve simulator/runtime/build issues
- Preserve `LoadingView.swift` as the team-specific splash/loading entry point
- Implement the splash indicator with native `ProgressView()` and `CircularProgressViewStyle(tint: .brown)`
- Establish a reliable app entry point

### Phase 3 — App Shell & Seed Data
- Create navigation shell
- Define seeded local models / demo data
- Establish Home / Subs / Savings / Alerts structure

### Phase 4 — Interactive Tour
- Build or refine the guided pitch walkthrough
- Ensure restartability and accessibility support

### Phase 5 — Core Product Flows
- Subscription tracking
- Reminder and notification views
- Savings goal flows
- Simulated cancellation + reroute behavior

### Phase 6 — Accessibility Refinement & Polish
- VoiceOver-first money/status summaries
- Dynamic Type validation
- Reduce Motion handling
- Non-color-only status communication

## When to Split Work

Split an implementation step if it combines:

- simulator/build fixes and product feature work,
- data model design and unrelated UI redesign,
- multiple major app sections at once,
- behavior that is not clearly defined in the context files.

If it cannot be verified quickly in simulator, the scope is probably too broad.

## Handling Missing Requirements

- Do not invent new product behavior without grounding it in the pitch docs or Tone’s direction
- If a requirement is ambiguous, resolve it in the relevant context file first
- If the requirement is missing, add it to `progress-tracker.md` as an open question before continuing
- Prefer believable simulation over fake “live” capabilities

## Protected Files

Do not modify the following unless explicitly needed for the current phase:

- Xcode project internals unless build/project structure requires it
- App icons and logo assets unless Tone requests brand changes
- PDF reference files in `target-it/`
- Test targets unless writing or repairing tests is part of the phase

## Keeping Docs in Sync

Update the relevant context file whenever implementation changes:

- Product scope or success criteria → `project-overview.md`
- Architecture or storage decisions → `architecture.md`
- Coding conventions or implementation lessons → `code-standards.md`
- UI direction or design tokens → `ui-context.md`
- Current status, blockers, and next unit → `progress-tracker.md`

## Before Moving to the Next Unit

1. The current unit works within its defined scope
2. No invariant in `architecture.md` has been violated
3. `progress-tracker.md` reflects the current truth
4. Simulator build or preview evidence exists for the completed unit
5. Accessibility implications for the unit were considered, not deferred blindly

## Verification Strategy

### For Planning Phases
- Ensure docs are internally consistent
- Ensure scope matches Tone’s instructions
- Ensure local-only MVP constraints are preserved

### For Implementation Phases
- Build in simulator
- Verify the app does not crash on launch
- Test interactive tour flow end to end
- Check large Dynamic Type layouts
- Review VoiceOver labels and announcement logic where relevant
- Verify Reduce Motion behavior for onboarding/tour animation
- If Xcode-generated starter tests are blocking the cohort build, it is acceptable to park them temporarily with placeholder files and restore real tests after the MVP foundation is stable

## Teaching Context

This is a cohort teaching project. When implementing:

- prefer readable architecture,
- comment important patterns,
- keep the code approachable for students,
- and document decisions clearly enough that the team can learn from them.

## Critical Reminders

1. **No external APIs** for this MVP
2. **Interactive tour is required** for pitching
3. **Accessibility is a product feature**, not just technical compliance
4. **Simulator stability matters more than fake complexity**
5. **Document phase progress as you go**

## Communication Style for Future Phases

- Be direct about what phase is being worked on
- Call out blockers quickly
- Keep Tone informed when a phase is done and ready for review
- Do not silently continue into a new major scope area without checking in