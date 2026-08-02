//
//  AlertsView.swift
//  TargetIT
//
//  Lists seeded notifications for the Phase 3 shell.
//

import SwiftUI

struct AlertsView: View {
    private let notifications = DemoData.notifications

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Alerts")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color("TargetBlack"))

                ForEach(notifications) { notification in
                    NotificationCard(notification: notification)
                }
            }
            .padding(20)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    AlertsView()
}
