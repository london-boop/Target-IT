//
//  SubscriptionsView.swift
//  TargetIT
//
//  Lists seeded subscriptions for the Phase 3 shell.
//

import SwiftUI

struct SubscriptionsView: View {
    @EnvironmentObject private var appDataStore: AppDataStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Subscriptions")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color("TargetBlack"))

                    if appDataStore.subscriptions.isEmpty {
                        Text("No subscriptions added yet.")
                            .font(.subheadline)
                            .foregroundStyle(Color("TargetBlack").opacity(0.72))
                            .padding(18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(panelColor)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    } else {
                        ForEach(appDataStore.subscriptions) { subscription in
                            NavigationLink(destination: SubscriptionDetailView(subscription: subscription)) {
                                SubscriptionCard(subscription: subscription)
                            }
                            .buttonStyle(.plain)
                            .accessibilityHint("Opens details for \(subscription.name).")
                        }
                    }
                }
                .padding(20)
            }
            .background(Color.white.ignoresSafeArea())
            .navigationTitle("Subscriptions")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SubscriptionsView()
}
