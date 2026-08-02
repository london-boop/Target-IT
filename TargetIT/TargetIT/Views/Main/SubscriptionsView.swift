//
//  SubscriptionsView.swift
//  TargetIT
//
//  Lists seeded subscriptions for the Phase 3 shell.
//

import SwiftUI

struct SubscriptionsView: View {
    private let subscriptions = DemoData.subscriptions

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Subscriptions")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color("TargetWhite"))

                ForEach(subscriptions) { subscription in
                    SubscriptionCard(subscription: subscription)
                }
            }
            .padding(20)
        }
        .background(Color("TargetBlack").ignoresSafeArea())
    }
}

#Preview {
    SubscriptionsView()
}
