//
//  MainTabView.swift
//  TargetIT
//
//  This is the Phase 3 shell spike that will sit behind onboarding.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            SubscriptionsView()
                .tabItem {
                    Label("Subs", systemImage: "creditcard.fill")
                }

            SavingsView()
                .tabItem {
                    Label("Savings", systemImage: "banknote.fill")
                }

            AlertsView()
                .tabItem {
                    Label("Alerts", systemImage: "bell.badge.fill")
                }
        }
        .tint(Color("TargetBrown"))
    }
}

#Preview {
    MainTabView()
}
