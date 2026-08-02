//
//  LoadingView.swift
//  TargetIT
//
//  Created by JOURNi Student on 7/28/26.
//

import SwiftUI

struct LoadingView: View {
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0.0
    @State private var titleOpacity: Double = 0.0
    @State private var taglineOpacity: Double = 0.0
    @State private var loadingProgress: CGFloat = 0.0

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // Dynamic Type scaled metrics
    @ScaledMetric(relativeTo: .largeTitle) private var titleSize = 38
    @ScaledMetric(relativeTo: .headline) private var taglineSize = 18

    // Keep the splash short so it feels polished without slowing the pitch flow.
    private let splashDuration: TimeInterval = 2.4

    // Tone-approved onboarding background.
    // Keep the top clearly white and let the bottom fade into a very light brown.
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

            VStack(spacing: 32) {
                Spacer()

                // Logo and branding appear first.
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)
                        .accessibilityHidden(true)

                    Text("TARGET-IT")
                        .font(.system(size: titleSize, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("TargetBlack"))
                        .opacity(titleOpacity)

                    Text("Track subscriptions. Protect your budget.")
                        .font(.system(size: taglineSize, weight: .medium))
                        .foregroundStyle(Color("TargetBrown"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 24)
                        .opacity(taglineOpacity)
                }

                Spacer()

                // The loading bar stays simple and easy for the interns to follow.
                VStack(spacing: 14) {
                    loadingBar

                    Text("Loading...")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color("TargetBrown"))
                        .opacity(taglineOpacity)
                }
                .padding(.horizontal, 60)
                .padding(.bottom, 80)
            }
        }
        .onAppear {
            startAnimations()
        }
    }

    // MARK: - Loading Bar
    // Simple progress bar inspired by the teaching pattern from the other projects.
    private var loadingBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color("TargetBrown").opacity(0.18))
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color("TargetBrown"))
                    .frame(width: geometry.size.width * loadingProgress, height: 8)
            }
        }
        .frame(height: 8)
    }

    // MARK: - Animation Logic
    // This uses a simple onAppear animation pattern similar to the other cohort projects.
    private func startAnimations() {
        let animationDuration = reduceMotion ? 0.0 : 0.6
        let progressDuration = reduceMotion ? 0.0 : splashDuration

        withAnimation(.easeOut(duration: animationDuration)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }

        withAnimation(.easeIn(duration: reduceMotion ? 0.0 : 0.35).delay(reduceMotion ? 0.0 : 0.2)) {
            titleOpacity = 1.0
        }

        withAnimation(.easeIn(duration: reduceMotion ? 0.0 : 0.35).delay(reduceMotion ? 0.0 : 0.4)) {
            taglineOpacity = 1.0
        }

        withAnimation(.easeInOut(duration: progressDuration)) {
            loadingProgress = 1.0
        }
    }
}

#Preview {
    LoadingView()
}
