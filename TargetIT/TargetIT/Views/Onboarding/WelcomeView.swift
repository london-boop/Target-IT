//
//  WelcomeView.swift
//  TargetIT
//
//  Real entry point after LoadingView finishes.
//  The user taps Get Started to begin the tour.
//

import SwiftUI

struct WelcomeView: View {
    // Match the LoadingView background so onboarding feels visually continuous.
    // Keep the top white and let the bottom fade into a very light brown.
    private let gradientBackground = LinearGradient(
        colors: [
            Color.white,
            Color(.sRGB, red: 0.94, green: 0.91, blue: 0.88, opacity: 1.0)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    // Gold accent used for the main call-to-action.
    private let accentColor = Color("Gold")

    // Dynamic Type scaled metrics so large text still feels intentional.
    @ScaledMetric(relativeTo: .largeTitle) private var titleSize = 34
    @ScaledMetric(relativeTo: .body) private var taglineSize = 17

    var body: some View {
        NavigationStack {
            ZStack {
                gradientBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 28) {
                        Spacer(minLength: 20)

                        // Brand logo shown near the top of the welcome experience.
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 380, maxHeight: 380)
                            .accessibilityHidden(true)

                        // Main welcome copy.
                        VStack(spacing: 12) {
                            Text("Take Control of Your Subscriptions")
                                .font(.system(size: titleSize, weight: .bold, design: .rounded))
                                .foregroundStyle(Color("TargetBlack"))
                                .multilineTextAlignment(.center)

                            Text("Track recurring charges, catch renewals early, and turn canceled subscriptions into savings.")
                                .font(.system(size: taglineSize, weight: .medium))
                                .foregroundStyle(Color("TargetBrown"))
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .padding(.horizontal, 28)
                        }

                        // Summary cards give the screen a more finance-dashboard feel.
                        HStack(spacing: 14) {
                            WelcomeStatCard(title: "Monthly Spend", value: "$50.97")
                            WelcomeStatCard(title: "Saved", value: "$14.99")
                        }
                        .padding(.horizontal, 24)

                        // Short feature summary so the user understands the app value fast.
                        VStack(spacing: 12) {
                            WelcomeFeatureRow(
                                icon: "creditcard.fill",
                                text: "Manage subscriptions in one place"
                            )

                            WelcomeFeatureRow(
                                icon: "banknote.fill",
                                text: "Redirect canceled charges into savings goals"
                            )

                            WelcomeFeatureRow(
                                icon: "bell.badge.fill",
                                text: "Stay ahead of renewals and alerts"
                            )
                        }
                        .padding(.horizontal, 20)

                        Spacer()

                        // Primary button moves the user into the interactive tour.
                        NavigationLink(destination: InteractiveTourView()) {
                            Text("Get Started")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Color("TargetBlack"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(accentColor)
                                .cornerRadius(16)
                        }
                        .accessibilityHint("Starts the interactive tour.")
                        .padding(.horizontal, 32)

                        // Returning users should be able to log in from the welcome screen.
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .font(.callout)
                                .foregroundStyle(Color("TargetBlack").opacity(0.72))

                            NavigationLink(destination: LoginView()) {
                                Text("Log in")
                                    .font(.callout.weight(.semibold))
                                    .foregroundStyle(Color("Gold"))
                            }
                            .accessibilityHint("Opens the returning user login screen.")
                        }
                        .padding(.bottom, 44)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    WelcomeView()
}
