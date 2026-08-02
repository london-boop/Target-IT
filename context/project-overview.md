# Target-IT

## Overview

Target-IT is a local-first iOS MVP that helps users understand, track, and manage recurring subscriptions in one place. The app is designed as a pitch-ready SwiftUI prototype that demonstrates how a user can monitor upcoming charges, simulate canceling unwanted subscriptions, and redirect recovered money into savings goals. The experience is supported by an **interactive tour** so the student team can clearly present the product story during demos.

## Problem

Many users lose money to recurring subscriptions they forget about, underuse, or never intentionally keep. Trial conversions, silent renewals, and scattered billing dates make it easy to overspend without noticing. Users need a simpler way to:

- see all recurring subscriptions in one place,
- understand what is renewing soon,
- decide what to keep or cancel,
- and turn wasted spending into purposeful savings.

## Solution

Target-IT presents a focused subscription-management experience that makes recurring charges visible and actionable. For this MVP, the app uses local seeded data to simulate:

- active subscriptions,
- renewal reminders,
- cancellation outcomes,
- savings redirection,
- and a notification feed that keeps the user informed.

The team will also use an **interactive tour** to walk judges or stakeholders through the app's value proposition without relying on live backend systems.

## Goals

1. Build a stable local-first MVP that runs reliably in the iOS simulator.
2. Demonstrate the core value proposition: track subscriptions, avoid surprise renewals, and convert waste into savings.
3. Include a polished interactive tour for pitch presentations.
4. Include a meaningful Apple accessibility feature that strengthens the product experience.
5. Keep the scope believable, focused, and teachable for the cohort team.
6. Preserve a distinct visual identity so the app does not look like the other cohort projects.

## Core User Flow

1. User launches Target-IT and sees branded onboarding / splash experience.
2. User can start an **interactive tour** that explains the problem, solution, and main app features.
3. User enters the main dashboard and sees high-level subscription totals and upcoming billing activity.
4. User opens the subscription area to review recurring services and statuses.
5. User simulates canceling an unwanted subscription.
6. App shows that the canceled amount can be rerouted into a savings goal.
7. User checks reminders / notifications for upcoming renewals, trial expirations, and savings milestones.
8. User returns to the dashboard with a clearer picture of recurring spending.

## Features

### Onboarding & Pitch Flow

- Branded splash / loading experience that feels distinct to the Target-IT team
- **Interactive tour** for demos and presentations
- Clear product education before deeper navigation
- Restartable tour from within the app

### Subscription Tracking

- Active subscription list with name, amount, cadence, and status
- Subscription detail view
- Renewal timing and billing summaries
- Simulated cancel flow for selected subscriptions

### Savings Hub

- Savings goal overview
- Progress bars / milestone indicators
- Simulated rerouting of canceled-subscription money into savings goals
- High-level money-saved summaries

### Reminders & Notifications

- Upcoming billing reminders
- Trial expiration alerts
- Weekly digest / monthly summary concepts
- In-app notification center using mock local data

### Accessibility

- VoiceOver-friendly subscription, reminder, and tour content
- Dynamic Type support across the app
- Reduce Motion-aware transitions
- Status indicators that do not rely on color alone

## Scope

### In Scope

- SwiftUI iOS MVP
- Team-specific visual identity rather than reusing another project's presentation style
- Local-only data model and seeded demo content
- Interactive tour for presenters
- Dashboard, subscriptions, savings, reminders, and notification center flows
- Simulated cancel actions and savings rerouting
- Accessibility-first implementation for the core flows
- Simulator-ready implementation and documentation

### Out of Scope

- External APIs
- Live bank or card account connections
- Real subscription cancellation integrations
- Cloud sync
- Server-side notifications
- Production-grade authentication
- Android implementation
- App Store distribution concerns for this phase

## Success Criteria

1. The app launches and runs reliably in simulator without the current runtime/layout issues.
2. A presenter can complete the interactive tour end to end.
3. A user can view seeded subscriptions and understand upcoming renewals.
4. A user can simulate canceling at least one subscription and see the savings impact.
5. A user can view a savings goal and understand rerouted funds.
6. A user can view reminder and notification states for upcoming billing events.
7. VoiceOver and Dynamic Type remain usable across the core MVP flow.
8. All core data for the MVP is local and does not depend on any external API.

## Product Constraints

- This project is an MVP for presentation and simulator demonstration.
- The app should feel polished without pretending to do live financial operations.
- Product claims in the UI must remain believable for a local prototype.
- The pitch flow should be understandable even if someone opens the app cold.

## Notes from the Prototype PDFs

Key feature themes identified from the reference materials:

- **Manage & Cancel Instantly**
- **Automated Savings Goals**
- **Proactive Billing Alerts**
- **Real-Time Notification Feed**
- Strong emphasis on recurring charge awareness, cancellation value, and savings visibility

These features should guide the MVP structure, but implementation should remain local-first and simulator-safe.