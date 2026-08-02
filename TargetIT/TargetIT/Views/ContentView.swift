//
//  ContentView.swift
//  TargetIT
//
//  Created by JOURNi Student on 7/23/26.
//

import SwiftUI

// MARK: - Root Content View
// This is the first view the app loads.
// It shows the LoadingView first, then hands off to WelcomeView.
struct ContentView: View {
    // Controls whether the splash/loading screen is still visible.
    @State private var isShowingLoadingView = true

    // Accessibility: respect the user's motion preference during screen handoff.
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            // Keep a full-screen background behind both phases so the app
            // does not flash white when switching screens.
            Color("TargetBlack")
                .ignoresSafeArea()

            if isShowingLoadingView {
                LoadingView()
                    .transition(.opacity)
                    .onAppear {
                        // The root view controls when the splash hands off to WelcomeView.
                        // This keeps LoadingView simple and follows the same style used in the other projects.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                            if reduceMotion {
                                isShowingLoadingView = false
                            } else {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    isShowingLoadingView = false
                                }
                            }
                        }
                    }
            } else {
                WelcomeView()
                    .transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
