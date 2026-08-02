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

                    ForEach(appDataStore.subscriptions) { subscription in
                        NavigationLink(destination: SubscriptionDetailView(subscription: subscription)) {
                            SubscriptionCard(subscription: subscription)
                        }
                        .buttonStyle(.plain)
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
