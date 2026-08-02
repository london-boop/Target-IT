# Code Standards

## General

- Keep modules small and single-purpose
- Fix root causes instead of layering temporary workarounds
- Do not mix unrelated concerns in one file
- Prefer clarity and teachability over cleverness
- Every meaningful implementation block should be understandable by the cohort team
- Add comments for architecture or UI logic that students may need help following

## Swift

- Use modern Swift 5.9+ patterns
- Prefer `let` unless mutation is required
- Use `guard` for early exits
- Avoid force unwraps in production code
- Prefer small enums for state like subscription status, reminder type, and tour step
- Use descriptive names such as `upcomingRenewalDate` instead of vague names like `date1`
- Keep logic for formatting money, dates, and statuses centralized where possible

## SwiftUI

- Use `@State` for local view state
- Use `@Binding` for parent-child state propagation
- Use `@StateObject` for view-owned observable state
- Use `@ObservedObject` or environment-injected state for shared orchestration
- Prefer `NavigationStack` over deprecated navigation APIs
- Use `TabView` only when it supports the product shell cleanly
- Extract reusable card components for subscriptions, reminders, savings goals, and tour steps
- Keep large `body` implementations split into subviews or helper properties
- Keep previews updated as views evolve

## SwiftData

- Use `@Model` for persistent MVP entities
- Keep schema simple and pitch-focused
- Prefer straightforward properties over premature complex relationships
- Use `@Query` for read-heavy list views when appropriate
- Keep model writes predictable and UI-safe
- Seed local data in a way that is easy for students to understand and reset

## Accessibility

### Required Standards

- Every interactive element must have an appropriate `accessibilityLabel`
- Use `accessibilityHint` when the action is not obvious
- Mark decorative-only images as hidden from accessibility
- Use text styles (`.body`, `.headline`, `.title2`, etc.) instead of fixed font sizes where possible
- Maintain minimum 44x44 touch targets
- Check `@Environment(\.accessibilityReduceMotion)` before running motion-heavy animations
- Never rely on color alone to communicate urgency, cancellation, or savings status

### Target-IT Specific Accessibility Expectations

- Subscription cards should be readable as concise spoken summaries
- Reminder timing should be phrased clearly for VoiceOver (for example: “Spotify Family renews in 3 days for 16 dollars and 99 cents”)
- Savings progress should combine amount text and progress visuals
- Tour screens should announce where the user is in the walkthrough
- Charts or progress bars must have text alternatives

## Naming Conventions

- Views: `*View`
- Reusable UI pieces: names like `SubscriptionCardView`, `SavingsGoalCardView`, `ReminderRowView`
- View models: `*ViewModel`
- Models: descriptive nouns like `SubscriptionRecord`, `NotificationItem`, `SavingsGoal`
- Services: `*Service`
- Files should match their primary type name
- Use PascalCase file names consistently

## Styling

- Use named asset colors before adding new custom values
- Prefer semantic styling helpers over repeating long modifier chains
- Preserve the premium finance feel from the PDFs: dark surfaces, warm highlight tones, clean spacing, strong totals
- Use typography to create hierarchy between totals, labels, urgency messages, and explanations
- Keep shadows, animation, and gradients subtle — demo polish, not visual noise

### Current Asset Palette

Use existing named colors first:
- `Black`
- `Brown`
- `Gold`
- `Sage`
- `White`

If new colors are needed, document them in `ui-context.md` first.

## File Organization

Preferred structure as the app grows:

- `TargetIT/TargetIT/Models/` — SwiftData models and related enums
- `TargetIT/TargetIT/Views/Onboarding/` — splash, welcome, tour
- `TargetIT/TargetIT/Views/Dashboard/` — home overview
- `TargetIT/TargetIT/Views/Subscriptions/` — subscription flows
- `TargetIT/TargetIT/Views/Savings/` — savings views
- `TargetIT/TargetIT/Views/Alerts/` — reminders and notification center
- `TargetIT/TargetIT/Views/Components/` — shared cards, buttons, pills, progress views
- `TargetIT/TargetIT/Services/` — local data seeding, demo orchestration, formatting helpers
- `TargetIT/TargetIT/Utilities/` — extensions, constants, helper functions

## Preview Providers

- Every major screen should have a working `#Preview`
- Use seeded local preview data
- If a view expects model-backed data, provide an in-memory container or mock source
- Add accessibility preview cases when the view is sensitive to Dynamic Type or layout density

## Testing Expectations

- Simulator build must pass before calling a phase complete
- Test both normal and large accessibility text sizes
- Test VoiceOver-relevant flows by reviewing labels/hints intentionally
- Verify Reduce Motion behavior on animated screens
- Verify the interactive tour can be started, navigated, skipped, and restarted

## Teaching-Specific Guidance

- Explain the “why” in comments when the pattern may be new to students
- Keep components and naming approachable
- Use the app as an example of clean local-first architecture
- Avoid overengineering the MVP just to look advanced

### Good Example

```swift
// This badge uses icon + text + color so renewal urgency is clear
// even when a user cannot rely on color perception alone.
StatusBadgeView(status: .trialEnding)
```

### Bad Example

```swift
// red badge
StatusBadgeView(status: .trialEnding)
```

The good example teaches intent. The bad one only describes appearance.