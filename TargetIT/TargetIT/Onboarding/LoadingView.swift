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

    // These state values drive the simple branded entrance animation.
    @State private var logoScale: CGFloat = 0.94
    @State private var logoOpacity: Double = 0.0
    @State private var contentOpacity: Double = 0.0

    // Keep the splash short so it feels polished without slowing the pitch flow.
    private let splashDuration: Double = 1.8

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 24) {
                // The logo needs a light surface behind it so the darker "IT"
                // portion remains readable against the black splash background.
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                    .padding(22)
                    .background(
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .fill(Color.white.opacity(0.96))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .stroke(Color.brown.opacity(0.35), lineWidth: 1.5)
                    )
                    .shadow(color: .brown.opacity(0.18), radius: 16, x: 0, y: 10)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .accessibilityHidden(true)

                VStack(spacing: 8) {
                    Text("TARGET-IT")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)

                    Text("Track subscriptions. Protect your budget.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.78))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .opacity(contentOpacity)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .brown))
                    .scaleEffect(1.2)
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
            contentOpacity = 1.0
            return
        }

        withAnimation(.easeOut(duration: 0.45)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }

        withAnimation(.easeIn(duration: 0.35).delay(0.18)) {
            contentOpacity = 1.0
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
