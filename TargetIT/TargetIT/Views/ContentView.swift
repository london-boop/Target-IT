//
//  ContentView.swift
//  TargetIT
//
//  Created by JOURNi Student on 7/23/26.
//

import SwiftUI

struct ContentView: View {
    // This state controls the handoff from the loading screen to the first app screen.
    @State private var isShowingLoadingView = true

    var body: some View {
        ZStack {
            if isShowingLoadingView {
                LoadingView {
                    isShowingLoadingView = false
                }
                .transition(.opacity)
            } else {
                WelcomeView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isShowingLoadingView)
    }
}

private struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Text("Welcome to TARGET-IT")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text("Take control of recurring charges, catch upcoming renewals, and turn canceled subscriptions into savings.")
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                    .accessibilityHidden(true)

                VStack(spacing: 12) {
                    Label("Subscription Tracking", systemImage: "creditcard.fill")
                    Label("Savings Goals", systemImage: "banknote.fill")
                    Label("Billing Alerts", systemImage: "bell.badge.fill")
                }
                .font(.headline)
                .foregroundStyle(.brown)

                Text("Phase 2 foundation complete. Next up: interactive tour and core app shell.")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
            }
            .padding(32)
        }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    ContentView()
}
