//
//  DemoModels.swift
//  TargetIT
//
//  Local demo models for Phase 3.
//  These keep the MVP simple before SwiftData is added.
//

import SwiftUI

// MARK: - Subscription Model
// Represents one recurring subscription in the MVP demo data.
struct SubscriptionRecord: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let monthlyCost: Double
    let nextBillingDate: Date
    let status: SubscriptionStatus
}

// MARK: - Subscription Status
// Describes the current state of a subscription.
enum SubscriptionStatus {
    case active
    case trialEnding
    case canceled

    // Text shown inside the status badge.
    var label: String {
        switch self {
        case .active:
            return "Active"
        case .trialEnding:
            return "Trial Ending"
        case .canceled:
            return "Canceled"
        }
    }

    // Symbol paired with the status label.
    var iconName: String {
        switch self {
        case .active:
            return "checkmark.circle.fill"
        case .trialEnding:
            return "exclamationmark.triangle.fill"
        case .canceled:
            return "xmark.circle.fill"
        }
    }

    // Foreground color for badge text and icon.
    var foregroundColor: Color {
        switch self {
        case .active:
            return Color("Sage")
        case .trialEnding:
            return Color("Gold")
        case .canceled:
            return Color("TargetWhite")
        }
    }

    // Background tint for the badge.
    var backgroundColor: Color {
        switch self {
        case .active:
            return Color("Sage").opacity(0.18)
        case .trialEnding:
            return Color("Gold").opacity(0.18)
        case .canceled:
            return Color("TargetWhite").opacity(0.14)
        }
    }

    // VoiceOver summary for one subscription state.
    var accessibilityText: String {
        switch self {
        case .active:
            return "active subscription"
        case .trialEnding:
            return "trial ending soon"
        case .canceled:
            return "canceled subscription"
        }
    }
}

// MARK: - Savings Goal Model
// Represents one savings goal fed by canceled subscriptions.
struct SavingsGoal: Identifiable {
    let id = UUID()
    let title: String
    let targetAmount: Double
    let currentAmount: Double
    let targetDate: Date
}

// MARK: - Billing Reminder Model
// Represents one reminder item for the demo dashboard.
struct BillingReminder: Identifiable {
    let id = UUID()
    let title: String
    let dueDate: Date
    let amount: Double
    let type: ReminderType
}

// MARK: - Reminder Type
// Helps the UI choose a symbol for each reminder style.
enum ReminderType {
    case renewal
    case trial
    case digest

    var iconName: String {
        switch self {
        case .renewal:
            return "calendar.badge.clock"
        case .trial:
            return "hourglass.circle.fill"
        case .digest:
            return "list.bullet.rectangle.portrait.fill"
        }
    }
}

// MARK: - Notification Model
// Represents one alert/notification feed item.
struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let timestampLabel: String
}

// MARK: - Tour Step Model
// Keeps interactive tour content organized in a simple structure.
struct TourStep {
    let title: String
    let subtitle: String
    let symbol: String
    let accentText: String
    let detailRows: [String]
}

// MARK: - Demo Data
// Seeded local data lets the interns build the UI before persistence is added.
enum DemoData {
    static let subscriptions: [SubscriptionRecord] = [
        SubscriptionRecord(
            name: "Netflix Premium 4K",
            category: "Streaming",
            monthlyCost: 19.99,
            nextBillingDate: .daysFromNow(2),
            status: .active
        ),
        SubscriptionRecord(
            name: "Spotify Family",
            category: "Music",
            monthlyCost: 16.99,
            nextBillingDate: .daysFromNow(3),
            status: .trialEnding
        ),
        SubscriptionRecord(
            name: "Gym Pass",
            category: "Fitness",
            monthlyCost: 14.99,
            nextBillingDate: .daysFromNow(0),
            status: .canceled
        )
    ]

    static let goals: [SavingsGoal] = [
        SavingsGoal(
            title: "Vacation Fund",
            targetAmount: 2000,
            currentAmount: 1420.50,
            targetDate: .daysFromNow(120)
        ),
        SavingsGoal(
            title: "Emergency Fund",
            targetAmount: 5000,
            currentAmount: 2000,
            targetDate: .daysFromNow(220)
        )
    ]

    static let reminders: [BillingReminder] = [
        BillingReminder(
            title: "Spotify Family renews soon",
            dueDate: .daysFromNow(3),
            amount: 16.99,
            type: .renewal
        ),
        BillingReminder(
            title: "Netflix Premium renewal warning",
            dueDate: .daysFromNow(2),
            amount: 19.99,
            type: .digest
        )
    ]

    static let notifications: [NotificationItem] = [
        NotificationItem(
            title: "Renewal Warning",
            message: "Netflix Premium will renew in 2 days. Review now to avoid surprise charges.",
            timestampLabel: "10m ago"
        ),
        NotificationItem(
            title: "Savings Deposit",
            message: "You saved $14.99 from canceled Gym Pass and moved it toward Vacation Fund.",
            timestampLabel: "2h ago"
        ),
        NotificationItem(
            title: "Weekly Digest Ready",
            message: "You spent $50.97 on 3 subscriptions this week. Review the full breakdown.",
            timestampLabel: "1d ago"
        )
    ]

    static let tourSteps: [TourStep] = [
        TourStep(
            title: "Manage & Cancel Instantly",
            subtitle: "Review your subscriptions in one place and decide what is worth keeping.",
            symbol: "creditcard.fill",
            accentText: "$50.97 active this month",
            detailRows: [
                "Track monthly services like Netflix and Spotify",
                "Spot subscriptions that are underused",
                "Simulate canceling one tap away"
            ]
        ),
        TourStep(
            title: "Automated Savings Goals",
            subtitle: "Turn canceled subscriptions into money that works for something better.",
            symbol: "banknote.fill",
            accentText: "$14.99 redirected to savings",
            detailRows: [
                "Move canceled charges into a goal",
                "Watch progress grow over time",
                "Keep savings visible and motivating"
            ]
        ),
        TourStep(
            title: "Proactive Billing Alerts",
            subtitle: "See renewals before they become surprise charges.",
            symbol: "bell.badge.fill",
            accentText: "2 renewals in the next 3 days",
            detailRows: [
                "Highlight upcoming renewal dates",
                "Surface trial endings early",
                "Keep billing urgency easy to scan"
            ]
        ),
        TourStep(
            title: "Real-Time Notification Feed",
            subtitle: "Stay informed about renewals, savings, and key account moments.",
            symbol: "list.bullet.rectangle.portrait.fill",
            accentText: "Weekly digest ready",
            detailRows: [
                "Review renewal warnings quickly",
                "See savings activity in one feed",
                "Support clear VoiceOver summaries"
            ]
        )
    ]
}
