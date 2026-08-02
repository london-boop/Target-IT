//
//  SubscriptionDetailView.swift
//  TargetIT
//
//  Shows one subscription in detail and lets the user simulate canceling it.
//

import SwiftUI

struct SubscriptionDetailView: View {
    let subscription: SubscriptionRecord

    @EnvironmentObject private var appDataStore: AppDataStore
    @Environment(\.dismiss) private var dismiss

    @State private var showCancelConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(subscription.name)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(Color("TargetBlack"))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Category")
                        .font(.headline)
                        .foregroundStyle(Color("TargetBrown"))

                    Text(subscription.category)
                        .font(.body)
                        .foregroundStyle(Color("TargetBlack"))
                }
                .padding(18)
                .background(panelColor)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Monthly Cost")
                        .font(.headline)
                        .foregroundStyle(Color("TargetBrown"))

                    Text(subscription.monthlyCost.currencyText)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color("Gold"))
                }
                .padding(18)
                .background(panelColor)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Next Renewal")
                        .font(.headline)
                        .foregroundStyle(Color("TargetBrown"))

                    Text(subscription.nextBillingDate.shortDateText)
                        .font(.body)
                        .foregroundStyle(Color("TargetBlack"))
                }
                .padding(18)
                .background(panelColor)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Status")
                        .font(.headline)
                        .foregroundStyle(Color("TargetBrown"))

                    StatusBadge(status: subscription.status)
                }
                .padding(18)
                .background(panelColor)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

                Button(action: {
                    showCancelConfirmation = true
                }) {
                    Text(subscription.status == .canceled ? "Already Canceled" : "Cancel Subscription")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(subscription.status == .canceled ? Color.gray : Color("TargetBrown"))
                        .cornerRadius(16)
                }
                .disabled(subscription.status == .canceled)
            }
            .padding(24)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("Subscription Detail")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "Cancel this subscription?",
            isPresented: $showCancelConfirmation,
            titleVisibility: .visible
        ) {
            Button("Cancel Subscription", role: .destructive) {
                appDataStore.cancelSubscription(subscription)
                dismiss()
            }
        } message: {
            Text("This will simulate canceling the subscription and reroute the savings into your first savings goal.")
        }
    }
}

#Preview {
    NavigationStack {
        SubscriptionDetailView(subscription: DemoData.subscriptions[0])
            .environmentObject(AppDataStore())
    }
}
