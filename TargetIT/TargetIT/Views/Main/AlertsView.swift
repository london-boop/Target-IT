//
//  AlertsView.swift
//  TargetIT
//
//  Combined reminder center for upcoming billing reminders and notification feed items.
//

import SwiftUI

struct AlertsView: View {
    @EnvironmentObject private var appDataStore: AppDataStore

    // These small text helpers keep the summary sentence grammatically correct.
    private var reminderCountText: String {
        let count = appDataStore.reminders.count
        return "\(count) \(count == 1 ? "reminder" : "reminders")"
    }

    private var notificationCountText: String {
        let count = appDataStore.notifications.count
        return "\(count) \(count == 1 ? "feed update" : "feed updates")"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Reminder Center")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color("TargetBlack"))

                // Quick summary helps the user scan how many items need attention.
                VStack(alignment: .leading, spacing: 8) {
                    Text("What Needs Attention")
                        .font(.headline)
                        .foregroundStyle(Color("TargetBrown"))

                    Text("\(reminderCountText) · \(notificationCountText)")
                        .font(.subheadline)
                        .foregroundStyle(Color("TargetBlack").opacity(0.72))
                }
                .padding(18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(panelColor)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .accessibilityElement(children: .combine)
                .accessibilityLabel("What needs attention, \(reminderCountText), \(notificationCountText)")

                VStack(alignment: .leading, spacing: 14) {
                    Text("Upcoming Reminders")
                        .font(.headline)
                        .foregroundStyle(Color("TargetBrown"))

                    if appDataStore.reminders.isEmpty {
                        Text("No upcoming reminders.")
                            .font(.subheadline)
                            .foregroundStyle(Color("TargetBlack").opacity(0.72))
                            .padding(18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(panelColor)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    } else {
                        ForEach(appDataStore.reminders) { reminder in
                            ReminderCard(reminder: reminder)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 14) {
                    Text("Notification Feed")
                        .font(.headline)
                        .foregroundStyle(Color("TargetBrown"))

                    if appDataStore.notifications.isEmpty {
                        Text("No notifications yet.")
                            .font(.subheadline)
                            .foregroundStyle(Color("TargetBlack").opacity(0.72))
                            .padding(18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(panelColor)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    } else {
                        ForEach(appDataStore.notifications) { notification in
                            NotificationCard(notification: notification)
                        }
                    }
                }
            }
            .padding(20)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    AlertsView()
        .environmentObject(AppDataStore())
}
