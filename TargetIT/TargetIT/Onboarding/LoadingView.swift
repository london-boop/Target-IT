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

    // These state values drive the staged branded entrance animation.
    @State private var logoScale: CGFloat = 0.9
    @State private var logoOpacity: Double = 0.0
    @State private var titleScale: CGFloat = 0.96
    @State private var titleOpacity: Double = 0.0
    @State private var taglineScale: CGFloat = 0.96
    @State private var taglineOpacity: Double = 0.0
    @State private var progressOpacity: Double = 0.0

    // Keep the splash short so it feels polished without slowing the pitch flow.
    private let splashDuration: Double = 2.1

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .white,
                    Color.brown.opacity(0.22)
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
                        .foregroundStyle(.black)
                        .scaleEffect(titleScale)
                        .opacity(titleOpacity)

                    Text("Track subscriptions. Protect your budget.")
                        .font(.subheadline)
                        .foregroundStyle(.brown.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .scaleEffect(taglineScale)
                        .opacity(taglineOpacity)
                }

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .brown))
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
        .onAppear {
            startAnimation()
            finishSplashAfterDelay()
        }
    }

    private func startAnimation() {
        if reduceMotion {
            logoScale = 1.0
            logoOpacity = 1.0
            titleScale = 1.0
            titleOpacity = 1.0
            taglineScale = 1.0
            taglineOpacity = 1.0
            progressOpacity = 1.0
            return
        }

        withAnimation(.easeOut(duration: 0.45)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }

        withAnimation(.easeOut(duration: 0.35).delay(0.24)) {
            titleScale = 1.0
            titleOpacity = 1.0
        }

        withAnimation(.easeOut(duration: 0.35).delay(0.44)) {
            taglineScale = 1.0
            taglineOpacity = 1.0
        }

        withAnimation(.easeIn(duration: 0.25).delay(0.6)) {
            progressOpacity = 1.0
        }
    }

    private func finishSplashAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + splashDuration) {
            onFinished()
        }
    }
}

#Preview {
    LoadingView(onFinished: {})
}
