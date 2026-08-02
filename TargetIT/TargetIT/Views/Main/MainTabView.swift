//
//  MainTabView.swift
//  TargetIT
//
//  This is the Phase 3 shell spike that will sit behind onboarding.
//

import SwiftUI

struct MainTabView: View {
    // Lets users replay the tour from inside the app shell.
    @State private var isShowingTour = false

    var body: some View {
        TabView {
            DashboardView(onReplayTour: {
                isShowingTour = true
            })
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
        .sheet(isPresented: $isShowingTour) {
            NavigationStack {
                InteractiveTourView(isReplayMode: true)
            }
        }
    }
}

#Preview {
    MainTabView()
}
