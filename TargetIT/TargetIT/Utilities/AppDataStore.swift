//
//  AppDataStore.swift
//  TargetIT
//
//  Simple local app data store for Phase 5.
//  This keeps the feature logic readable before deeper persistence work is added.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class AppDataStore: ObservableObject {
    @Published var subscriptions: [SubscriptionRecord]
    @Published var goals: [SavingsGoal]
    @Published var reminders: [BillingReminder]
    @Published var notifications: [NotificationItem]

    init(
        subscriptions: [SubscriptionRecord] = DemoData.subscriptions,
        goals: [SavingsGoal] = DemoData.goals,
        reminders: [BillingReminder] = DemoData.reminders,
        notifications: [NotificationItem] = DemoData.notifications
    ) {
        self.subscriptions = subscriptions
        self.goals = goals
        self.reminders = reminders
        self.notifications = notifications
    }

    // Total active monthly spend shown across the app.
    var activeMonthlySpend: Double {
        subscriptions
            .filter { $0.status != .canceled }
            .reduce(0) { $0 + $1.monthlyCost }
    }

    // Total savings recovered from canceled subscriptions.
    var recoveredSavings: Double {
        subscriptions
            .filter { $0.status == .canceled }
            .reduce(0) { $0 + $1.monthlyCost }
    }

    // Marks a subscription as canceled and reroutes the savings into the first goal.
    func cancelSubscription(_ subscription: SubscriptionRecord) {
        guard let index = subscriptions.firstIndex(where: { $0.id == subscription.id }) else {
            return
        }

        guard subscriptions[index].status != .canceled else {
            return
        }

        subscriptions[index].status = .canceled

        if goals.isEmpty == false {
            goals[0].currentAmount += subscription.monthlyCost
        }

        let reminderTitle = "\(subscription.name) canceled"
        reminders.insert(
            BillingReminder(
                title: reminderTitle,
                dueDate: Date(),
                amount: subscription.monthlyCost,
                type: .digest
            ),
            at: 0
        )

        notifications.insert(
            NotificationItem(
                title: "Savings Deposit",
                message: "You saved \(subscription.monthlyCost.currencyText) from canceled \(subscription.name) and moved it into your first savings goal.",
                timestampLabel: "Just now"
            ),
            at: 0
        )
    }
}
