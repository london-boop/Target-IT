//
//  LoadingView.swift
//  TargetIT
//
//  Created by JOURNi Student on 7/28/26.
//

import SwiftUI

struct LoadingView: View {
    // This closure lets the app decide what happens after the splash finishes.
    let onFinished: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // Prevents the staged animation from starting more than once.
    @State private var hasStartedAnimation = false

    // These state values drive the staged branded entrance animation.
    @State private var logoScale: CGFloat = 0.94
    @State private var logoOpacity: Double = 0.2
    @State private var titleScale: CGFloat = 0.96
    @State private var titleOpacity: Double = 0.0
    @State private var taglineScale: CGFloat = 0.96
    @State private var taglineOpacity: Double = 0.0
    @State private var taglineOffset: CGFloat = 28
    @State private var progressOpacity: Double = 0.0

    // Keep the splash short so it feels polished without slowing the pitch flow.
    private let splashDuration: Double = 2.4

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color("TargetWhite"),
                    Color("TargetBrown").opacity(0.28)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                // Keep the logo large and unframed so the brand stands on its own.
                // The lighter gradient background gives the darker "IT" enough contrast.
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320, height: 320)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .accessibilityHidden(true)

                VStack(spacing: 8) {
                    Text("TARGET-IT")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(Color("TargetBlack"))
                        .scaleEffect(titleScale)
                        .opacity(titleOpacity)

                    Text("Track subscriptions. Protect your budget.")
                        .font(.subheadline)
                        .foregroundStyle(Color("TargetBrown"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .scaleEffect(taglineScale)
                        .opacity(taglineOpacity)
                        .offset(x: taglineOffset)
                }

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("TargetBrown")))
                    .scaleEffect(1.2)
                    .opacity(progressOpacity)
                    .padding(.top, 8)
                    .accessibilityLabel("Loading Target-IT")
                    .accessibilityHint("Please wait while the app opens")
            }
            .padding(32)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Target-IT loading screen")
        .task {
            await runLoadingSequence()
        }
    }

    // Runs the loading sequence in a clear, step-by-step order.
    private func runLoadingSequence() async {
        guard !hasStartedAnimation else { return }
        hasStartedAnimation = true

        if reduceMotion {
            logoScale = 1.0
            logoOpacity = 1.0
            titleScale = 1.0
            titleOpacity = 1.0
            taglineScale = 1.0
            taglineOpacity = 1.0
            taglineOffset = 0
            progressOpacity = 1.0

            guard await sleepUnlessCancelled(nanoseconds: 1_200_000_000) else { return }
            guard !Task.isCancelled else { return }
            onFinished()
            return
        }

        withAnimation(.easeOut(duration: 0.4)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }

        guard await sleepUnlessCancelled(nanoseconds: 350_000_000) else { return }

        withAnimation(.easeOut(duration: 0.3)) {
            titleScale = 1.0
            titleOpacity = 1.0
        }

        guard await sleepUnlessCancelled(nanoseconds: 260_000_000) else { return }

        withAnimation(.easeOut(duration: 0.4)) {
            taglineScale = 1.0
            taglineOpacity = 1.0
            taglineOffset = 0
        }

        guard await sleepUnlessCancelled(nanoseconds: 220_000_000) else { return }

        withAnimation(.easeIn(duration: 0.25)) {
            progressOpacity = 1.0
        }

        guard await sleepUnlessCancelled(nanoseconds: UInt64((splashDuration - 1.23) * 1_000_000_000)) else { return }
        guard !Task.isCancelled else { return }
        onFinished()
    }

    // Sleeps for a duration and exits early if the SwiftUI task is cancelled.
    private func sleepUnlessCancelled(nanoseconds: UInt64) async -> Bool {
        do {
            try await Task.sleep(nanoseconds: nanoseconds)
            return !Task.isCancelled
        } catch {
            return false
        }
    }
}

#Preview {
    LoadingView()
}
