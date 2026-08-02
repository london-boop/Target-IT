# UI Context

## Theme

Target-IT should feel like a polished finance product: confident, premium, and easy to scan. The **Prototype PDF is the primary UI guideline for the MVP**, so implemented screens should stay visually consistent with that reference. The prototype points toward a **dark dashboard interface** with bright savings totals, high-contrast cards, and warm gold highlights that communicate value. Even though this is an MVP, the app should feel deliberate and investor-demo ready.

### Experience Goals

- Make recurring charges feel visible and understandable
- Make cancellation benefits feel immediate and rewarding
- Make savings progress feel motivating
- Make reminder urgency easy to scan without becoming visually noisy
- Keep the interactive tour visually aligned with the product, not like a detached slide deck
- Preserve a team-specific identity so Target-IT does not look cloned from the other cohort apps
- Keep the MVP UI consistent with the Prototype PDF in hierarchy, tone, and visual direction

## Colors

The project already includes named color assets that should anchor the design.

| Role | Asset Name | Approx. Value | Usage |
|------|------------|---------------|-------|
| Base background | `TargetBlack` | deep charcoal | App background, dark shell, premium contrast foundation |
| Primary text / inverted surfaces | `TargetWhite` | soft white | Text on dark surfaces, high-contrast labels |
| Warm accent | `Gold` | golden highlight | Totals, highlights, key money moments, progress emphasis |
| Secondary accent | `TargetBrown` | muted warm brown | Supporting financial accents, chart details, buttons, badges |
| Success / savings accent | `Sage` | soft green | Savings growth, successful cancellation outcomes, positive states |

### Important Note

These colors were corrected so their dark appearance variants no longer flip key interface colors to pure white unexpectedly.

## Color Usage Rules

- Use `Gold` for high-value information such as savings totals, feature emphasis, or selected states
- Use `Sage` for positive outcomes like “saved”, “goal progress”, and successful reroutes
- Use `TargetBrown` for softer supporting emphasis and secondary finance accents
- Use `TargetWhite` for primary text on dark surfaces
- Use `TargetBlack` as the anchor surface behind all major finance content
- Never rely on color alone to indicate subscription status

## Typography

Use San Francisco system typography with strong hierarchy.

| Role | Font Style | Weight | Usage |
|------|------------|--------|-------|
| Hero value | `.largeTitle` / custom large scale if needed | Bold | Key totals, major dashboard numbers |
| Screen title | `.title` / `.title2` | Semibold/Bold | Major screen headers |
| Section title | `.headline` / `.title3` | Semibold | Group labels and card headings |
| Body | `.body` | Regular | Supporting descriptions |
| Detail | `.subheadline` | Regular | Metadata, billing dates, helper copy |
| Fine print | `.footnote` / `.caption` | Regular | Secondary hints, timestamp detail |

### Typography Rules

- Important money figures must stand out clearly from descriptive text
- Use readable text styles that scale with Dynamic Type
- Avoid tiny finance labels that become unreadable in demos
- Keep tour headlines short and punchy

## Border Radius

| Context | Radius |
|---------|--------|
| Buttons | 12-16pt |
| Cards | 16-22pt |
| Pills / status chips | Capsule or 999pt |
| Modal / featured panels | 20-24pt |

Target-IT should feel smooth and modern, not sharp or boxy.

## Component Library Direction

### Core Components

- `SubscriptionCardView`
- `SavingsGoalCardView`
- `ReminderCardView`
- `NotificationRowView`
- `StatusBadgeView`
- `TourStepCardView`
- `PrimaryActionButton`
- `ProgressRingView` or `GoalProgressBarView`

### Button Styles

**Primary CTA**
- High-contrast filled button
- Use `Gold` or `Sage` depending on context
- Strong but clean label text

**Secondary CTA**
- Outlined or softer filled style
- Use `TargetBrown` or translucent white-on-dark treatment

**Tertiary / Text CTA**
- For “Skip”, “Restart Tour”, “View All”, etc.

## Layout Patterns

### Splash / Intro

- Use the team's existing `LoadingView.swift` naming rather than forcing another splash-screen pattern
- Native SwiftUI `ProgressView()`
- `CircularProgressViewStyle(tint: .brown)` as the loading indicator treatment
- Centered brand mark / logo
- Short reinforcing value statement
- Keep the screen visually distinct from the other cohort apps even if the implementation stays simple

### Welcome + Interactive Tour Entry

- `WelcomeView` is the true post-loading entry point
- Primary CTA: `Get Started`
- `Get Started` routes into the interactive tour
- Welcome screen should feel like the start of the app, not a disposable placeholder

### Interactive Tour

Preferred format:
- multi-step pager or card-based walkthrough
- progress indicator
- next / back / skip controls
- clear pitch-oriented copy
- optional highlight panels showing sample subscriptions, reminders, and savings outcomes
- tour should lead naturally into Sign Up

### Dashboard

- Top summary area with totals / monthly overview
- Quick-glance cards for subscriptions, reminders, and savings
- Visual priority on what is due soon and how much has been saved

### Subscription Screens

- Card list for active subscriptions
- Each row/card should show:
  - provider name
  - amount
  - cadence
  - next due date or status
  - action affordance where appropriate

### Savings Screens

- Goal cards with target, current amount, and progress
- Positive visual language using `Sage`
- Simple progress visuals with clear text equivalents

### Alerts / Notifications

- Time-ordered list
- Distinct status badges for warning, info, and success
- Clear action affordances for simulated follow-up actions

## Icons

Use SF Symbols consistently.

| Purpose | Suggested Symbol |
|---------|------------------|
| Subscription | `creditcard` / `rectangle.stack.badge.person.crop` |
| Renewal warning | `exclamationmark.triangle.fill` |
| Savings | `dollarsign.circle.fill` / `banknote.fill` |
| Goal progress | `target` / `chart.line.uptrend.xyaxis` |
| Notification | `bell.badge.fill` |
| Success / reroute | `arrow.triangle.branch` / `checkmark.circle.fill` |
| Tour / guide | `sparkles` / `play.rectangle.on.rectangle` |

## Spacing

| Token | Value |
|-------|-------|
| XS | 4pt |
| S | 8pt |
| M | 16pt |
| L | 24pt |
| XL | 32pt |
| XXL | 40-48pt |

Keep the layout breathable. Finance UIs feel stronger when spacing is disciplined.

## Animation Guidelines

- Keep motion subtle and purposeful
- Use quick transitions for tab/content changes
- Use soft emphasis for totals and successful savings reroutes
- The interactive tour can use stronger motion than the main app, but it must respect Reduce Motion
- Avoid flashy animation that makes the app feel less trustworthy

## Accessibility in the UI

### Required Behavior

- All important numbers must be readable and spoken clearly
- Every icon-only control needs a text label for VoiceOver
- Progress bars and rings need accessible value descriptions
- Reminder urgency must use text and icon support, not only color
- Large Dynamic Type must not break primary card layouts

### Featured Accessibility Story

The app’s featured Apple accessibility implementation should be visible in the UI through:
- VoiceOver-friendly subscription summaries
- spoken reminder clarity
- large-type-safe money cards
- reduce-motion-safe onboarding/tour behavior

## Prototype Interpretation Rule

When using the prototype PDF as a guide:

- the **app prototype screens are the phone/app visuals shown on the left**
- the **black-background sections on the right are descriptive presentation panels**, not the literal screen background for the app UI
- if there is a conflict, follow the left-side app mockup for actual in-app styling unless Tone explicitly says otherwise

## Prototype-Informed Content Patterns

The PDFs point to these feature moments that the UI should visually support:

- **Manage & Cancel Instantly**
- **Automated Savings Goals**
- **Proactive Billing Alerts**
- **Real-Time Notification Feed**

These should appear as recognizable pillars in the product layout and tour copy.

## Current UI State

The codebase is still early, and the Phase 3 flow has been corrected.

**UI rule:** when implementation decisions are made, the Prototype PDF should win over ad hoc styling choices unless Tone explicitly changes direction.

- `LoadingView.swift` has been repaired into a valid branded splash screen
- the loading screen uses native `ProgressView()` with `.brown` circular tint, as requested by the team
- a first-pass tab shell spike exists for local seeded content behind onboarding
- `WelcomeView` is now the real post-loading entry point
- placeholder `InteractiveTourView`, `SignUpView`, and `LoginView` screens are already in place to preserve the correct flow
- the remaining work is to make those placeholder onboarding screens richer and more PDF-consistent while keeping the simple teaching style

This file defines the intended direction for the next implementation phases.