# UI Context

## Theme

Target-IT should feel like a polished finance product: confident, premium, and easy to scan. The prototype points toward a **dark dashboard interface** with bright savings totals, high-contrast cards, and warm gold highlights that communicate value. Even though this is an MVP, the app should feel deliberate and investor-demo ready.

### Experience Goals

- Make recurring charges feel visible and understandable
- Make cancellation benefits feel immediate and rewarding
- Make savings progress feel motivating
- Make reminder urgency easy to scan without becoming visually noisy
- Keep the interactive tour visually aligned with the product, not like a detached slide deck
- Preserve a team-specific identity so Target-IT does not look cloned from the other cohort apps

## Colors

The project already includes named color assets that should anchor the design.

| Role | Asset Name | Approx. Value | Usage |
|------|------------|---------------|-------|
| Base background | `Black` | `#000000` (light appearance) | App background, dark shell, premium contrast foundation |
| Primary text / inverted surfaces | `White` | `#FFFFFF` | Text on dark surfaces, high-contrast labels |
| Warm accent | `Gold` | approx `#CCA817` | Totals, highlights, key money moments, progress emphasis |
| Secondary accent | `Brown` | approx `#614913` | Supporting financial accents, chart details, buttons, badges |
| Success / savings accent | `Sage` | approx `#85CF A2` | Savings growth, successful cancellation outcomes, positive states |

### Important Note

Several current color assets use white in dark appearance variants. During implementation, verify actual runtime usage and correct asset definitions if the dark theme becomes visually inconsistent.

## Color Usage Rules

- Use `Gold` for high-value information such as savings totals, feature emphasis, or selected states
- Use `Sage` for positive outcomes like “saved”, “goal progress”, and successful reroutes
- Use `Brown` for softer supporting emphasis and secondary finance accents
- Use `White` for primary text on dark surfaces
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
- Use `Brown` or translucent white-on-dark treatment

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

### Interactive Tour

Preferred format:
- multi-step pager or card-based walkthrough
- progress indicator
- next / back / skip controls
- clear pitch-oriented copy
- optional highlight panels showing sample subscriptions, reminders, and savings outcomes

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

## Prototype-Informed Content Patterns

The PDFs point to these feature moments that the UI should visually support:

- **Manage & Cancel Instantly**
- **Automated Savings Goals**
- **Proactive Billing Alerts**
- **Real-Time Notification Feed**

These should appear as recognizable pillars in the product layout and tour copy.

## Current UI State

At the moment, the codebase does **not** match this product direction yet:

- `ContentView.swift` is still a simple placeholder welcome screen
- `LoadingView.swift` is incomplete / malformed, but it should remain the team's chosen splash/loading screen concept
- the loading screen should use native `ProgressView()` with `.brown` circular tint
- visual hierarchy and navigation shell still need implementation

This file defines the intended direction for the next implementation phases.