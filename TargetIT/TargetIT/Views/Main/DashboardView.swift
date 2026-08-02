//
//  DashboardView.swift
//  TargetIT
//
//  First shell screen showing summary totals and upcoming items.
//

import SwiftUI

struct DashboardView: View {
    // Lets the dashboard ask the shell to replay the tour.
    let onReplayTour: () -> Void

    @EnvironmentObject private var appDataStore: AppDataStore

    @ScaledMetric(relativeTo: .largeTitle) private var overviewAmountSize = 40

    // Counts subscriptions that are still active or ending soon.
    private var activeSubscriptionsCount: Int {
        appDataStore.subscriptions.filter { $0.status != .canceled }.count
    }

    // Adds together active recurring monthly costs.
    private var monthlySpend: Double {
        appDataStore.activeMonthlySpend
    }

    // Adds together canceled subscription amounts to show saved money.
    private var totalSaved: Double {
        appDataStore.recoveredSavings
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("TARGET-IT")
                    .font(.title.weight(.bold))
                    .foregroundStyle(Color("TargetBlack"))

                // Main summary card for monthly subscription totals.
                VStack(alignment: .leading, spacing: 8) {
                    Text("Monthly Overview")
                        .font(.headline)
                        .foregroundStyle(Color("TargetBrown"))

                    Text(monthlySpend.currencyText)
                        .font(.system(size: overviewAmountSize, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("Gold"))

                    Text("\(activeSubscriptionsCount) active subscriptions · \(totalSaved.currencyText) currently saved from canceled services")
                        .font(.subheadline)
                        .foregroundStyle(Color("TargetBlack").opacity(0.72))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Monthly overview, \(monthlySpend.currencyText) active monthly spend, \(activeSubscriptionsCount) active subscriptions, \(totalSaved.currencyText) currently saved from canceled services")
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(panelColor)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

                // Replay Tour button gives presenters a quick way to start the walkthrough again.
                Button(action: onReplayTour) {
                    Text("Replay Interactive Tour")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color("TargetBrown"))
                        .cornerRadius(16)
                }

                // Reminder preview section.
                VStack(alignment: .leading, spacing: 14) {
                    sectionTitle("Coming Up")

                    if appDataStore.reminders.isEmpty {
                        Text("No upcoming reminders.")
                            .font(.subheadline)
                            .foregroundStyle(Color("TargetBlack").opacity(0.72))
                            .padding(18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(panelColor)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    } else {
                        ForEach(appDataStore.reminders.prefix(2)) { reminder in
                            ReminderCard(reminder: reminder)
                        }
                    }
                }

                // Savings preview section.
                VStack(alignment: .leading, spacing: 14) {
                    sectionTitle("Savings Goals")

                    ForEach(appDataStore.goals) { goal in
                        SavingsGoalCard(goal: goal)
                    }
                }
            }
            .padding(20)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    DashboardView(onReplayTour: {})
}
