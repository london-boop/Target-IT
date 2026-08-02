//
//  DashboardView.swift
//  TargetIT
//
//  First shell screen showing summary totals and upcoming items.
//

import SwiftUI

struct DashboardView: View {
    private let subscriptions = DemoData.subscriptions
    private let goals = DemoData.goals
    private let reminders = DemoData.reminders

    // Counts subscriptions that are still active or ending soon.
    private var activeSubscriptionsCount: Int {
        subscriptions.filter { $0.status != .canceled }.count
    }

    // Adds together active recurring monthly costs.
    private var monthlySpend: Double {
        subscriptions
            .filter { $0.status != .canceled }
            .reduce(0) { $0 + $1.monthlyCost }
    }

    // Adds together canceled subscription amounts to show saved money.
    private var totalSaved: Double {
        subscriptions
            .filter { $0.status == .canceled }
            .reduce(0) { $0 + $1.monthlyCost }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("TARGET-IT")
                    .font(.title.weight(.bold))
                    .foregroundStyle(Color("TargetWhite"))

                // Main summary card for monthly subscription totals.
                VStack(alignment: .leading, spacing: 8) {
                    Text("Monthly Overview")
                        .font(.headline)
                        .foregroundStyle(Color("TargetWhite").opacity(0.85))

                    Text(monthlySpend.currencyText)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("Gold"))

                    Text("\(activeSubscriptionsCount) active subscriptions · \(totalSaved.currencyText) currently saved from canceled services")
                        .font(.subheadline)
                        .foregroundStyle(Color("TargetWhite").opacity(0.74))
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(panelColor)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

                // Reminder preview section.
                VStack(alignment: .leading, spacing: 14) {
                    sectionTitle("Coming Up")

                    ForEach(reminders.prefix(2)) { reminder in
                        ReminderCard(reminder: reminder)
                    }
                }

                // Savings preview section.
                VStack(alignment: .leading, spacing: 14) {
                    sectionTitle("Savings Goals")

                    ForEach(goals) { goal in
                        SavingsGoalCard(goal: goal)
                    }
                }
            }
            .padding(20)
        }
        .background(Color("TargetBlack").ignoresSafeArea())
    }
}

#Preview {
    DashboardView()
}
