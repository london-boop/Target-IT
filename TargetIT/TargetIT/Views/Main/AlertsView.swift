//
//  AlertsView.swift
//  TargetIT
//
//  Lists seeded notifications for the Phase 3 shell.
//

import SwiftUI

struct AlertsView: View {
    @EnvironmentObject private var appDataStore: AppDataStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Alerts")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color("TargetBlack"))

                ForEach(appDataStore.notifications) { notification in
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
