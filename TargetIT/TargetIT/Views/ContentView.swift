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

    var body: some View {
        ZStack {
            // Keep a full-screen background behind both phases so the app
            // does not flash white when switching screens.
            Color("TargetBlack")
                .ignoresSafeArea()

            if isShowingLoadingView {
                LoadingView()
                    .transition(.opacity)
                    .task {
                        // The root view controls when the splash hands off to WelcomeView.
                        // This keeps LoadingView simple and avoids callback/breakpoint confusion.
                        try? await Task.sleep(nanoseconds: 2_400_000_000)
                        guard !Task.isCancelled else { return }

                        withAnimation(.easeInOut(duration: 0.35)) {
                            isShowingLoadingView = false
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
