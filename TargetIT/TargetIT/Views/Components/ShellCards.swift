//
//  ShellCards.swift
//  TargetIT
//
//  Reusable cards used across the Phase 3 shell screens.
//

import SwiftUI

// MARK: - Subscription Card
// Reusable card for showing one subscription row with status and price.
struct SubscriptionCard: View {
    let subscription: SubscriptionRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(subscription.name)
                        .font(.headline)
                        .foregroundStyle(Color("TargetWhite"))

                    Text(subscription.category)
                        .font(.subheadline)
                        .foregroundStyle(Color("TargetWhite").opacity(0.65))
                }

                Spacer()

                StatusBadge(status: subscription.status)
            }

            HStack {
                Text(subscription.monthlyCost.currencyText)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color("Gold"))

                Spacer()

                Text("Renews \(subscription.nextBillingDate.shortDateText)")
                    .font(.footnote)
                    .foregroundStyle(Color("TargetWhite").opacity(0.7))
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(panelColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(subscription.name), \(subscription.status.accessibilityText), \(subscription.monthlyCost.currencyText), renews \(subscription.nextBillingDate.accessibilityDateText)")
    }
}

// MARK: - Savings Goal Card
// Reusable card for showing one savings goal and its progress.
struct SavingsGoalCard: View {
    let goal: SavingsGoal

    // Progress value kept between 0 and 1 for ProgressView.
    private var progress: Double {
        min(goal.currentAmount / goal.targetAmount, 1.0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(goal.title)
                        .font(.headline)
                        .foregroundStyle(Color("TargetWhite"))

                    Text("Target by \(goal.targetDate.shortDateText)")
                        .font(.subheadline)
                        .foregroundStyle(Color("TargetWhite").opacity(0.65))
                }

                Spacer()

                Text(goal.currentAmount.currencyText)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color("Sage"))
            }

            ProgressView(value: progress)
                .tint(Color("Sage"))
                .accessibilityLabel("Progress for \(goal.title)")
                .accessibilityValue("\(Int(progress * 100)) percent")

            Text("\(goal.currentAmount.currencyText) of \(goal.targetAmount.currencyText)")
                .font(.footnote)
                .foregroundStyle(Color("TargetWhite").opacity(0.72))
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(panelColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

// MARK: - Reminder Card
// Small card used for upcoming billing reminders.
struct ReminderCard: View {
    let reminder: BillingReminder

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: reminder.type.iconName)
                .foregroundStyle(Color("TargetBrown"))
                .frame(width: 22)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                Text(reminder.title)
                    .font(.headline)
                    .foregroundStyle(Color("TargetWhite"))

                Text("\(reminder.amount.currencyText) · \(reminder.dueDate.shortDateText)")
                    .font(.subheadline)
                    .foregroundStyle(Color("TargetWhite").opacity(0.7))
            }

            Spacer()
        }
        .padding(18)
        .background(panelColor)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Notification Card
// Reusable card used for alert and notification feed items.
struct NotificationCard: View {
    let notification: NotificationItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(notification.title)
                    .font(.headline)
                    .foregroundStyle(Color("TargetWhite"))

                Spacer()

                Text(notification.timestampLabel)
                    .font(.footnote)
                    .foregroundStyle(Color("TargetWhite").opacity(0.6))
            }

            Text(notification.message)
                .font(.subheadline)
                .foregroundStyle(Color("TargetWhite").opacity(0.78))
        }
        .padding(18)
        .background(panelColor)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Status Badge
// Small capsule showing subscription state with icon + text.
struct StatusBadge: View {
    let status: SubscriptionStatus

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: status.iconName)
                .font(.caption.weight(.bold))
            Text(status.label)
                .font(.caption.weight(.semibold))
        }
        .foregroundStyle(status.foregroundColor)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(status.backgroundColor)
        .clipShape(Capsule())
    }
}
