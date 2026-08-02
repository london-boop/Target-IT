//
//  LoadingView.swift
//  TargetIT
//
//  Created by JOURNi Student on 7/28/26.
//

import SwiftUI

struct LoadingView: View {
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

    // Shared onboarding background: white at the top and light brown toward the bottom.
    private let gradientBackground = LinearGradient(
        colors: [
            Color.white,
            Color(.sRGB, red: 0.94, green: 0.91, blue: 0.88, opacity: 1.0)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        ZStack {
            gradientBackground
                .ignoresSafeArea()

            VStack(spacing: 24) {
                // Keep the logo large so the brand reads clearly during launch.
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320, height: 320)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .accessibilityHidden(true)

                // The company name appears after the logo.
                Text("TARGET-IT")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(Color("TargetBlack"))
                    .scaleEffect(titleScale)
                    .opacity(titleOpacity)

                // The tagline fades and slides in after the company name.
                Text("Track subscriptions. Protect your budget.")
                    .font(.subheadline)
                    .foregroundStyle(Color("TargetBrown"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .scaleEffect(taglineScale)
                    .opacity(taglineOpacity)
                    .offset(x: taglineOffset)

                // Brown progress indicator shown after the text sequence starts.
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

    // Runs the loading animation sequence in a clear, step-by-step order.
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

        withAnimation(.easeOut(duration: 0.45)) {
            taglineScale = 1.0
            taglineOpacity = 1.0
            taglineOffset = 0
        }

        guard await sleepUnlessCancelled(nanoseconds: 220_000_000) else { return }

        withAnimation(.easeIn(duration: 0.25)) {
            progressOpacity = 1.0
        }
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
