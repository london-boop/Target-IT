//
//  ContentView.swift
//  TargetIT
//
//  Created by JOURNi Student on 7/23/26.
//

import SwiftUI
import SwiftData

// MARK: - Root Content View
// This is the first view the app loads.
// It shows the LoadingView first, then hands off to WelcomeView or the main app if a local session already exists.
struct ContentView: View {
    // Controls whether the splash/loading screen is still visible.
    @State private var isShowingLoadingView = true

    // Accessibility: respect the user's motion preference during screen handoff.
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // Reads saved local users so the app can restore a session if one exists.
    @Query(sort: \User.createdAt) private var users: [User]

    // Finds the currently active local user from the saved session helper.
    private var activeUser: User? {
        guard let activeUserID = AuthSession.activeUserID() else {
            return nil
        }

        return users.first(where: { $0.id == activeUserID })
    }

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
                        // The root view controls when the splash hands off.
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
            } else if activeUser != nil {
                MainTabView()
                    .transition(.opacity)
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
        .modelContainer(for: User.self, inMemory: true)
}
