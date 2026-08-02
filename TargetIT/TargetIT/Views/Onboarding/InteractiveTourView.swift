//
//  InteractiveTourView.swift
//  TargetIT
//
//  Guided onboarding view that introduces the core MVP features step by step.
//  This stays simple so the interns can follow the flow easily.
//

import SwiftUI

struct InteractiveTourView: View {
    // Tracks which tour step is currently being shown.
    @State private var currentStep = 0

    // Accessibility: respect user motion preferences.
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // Core feature pages pulled from the prototype PDF direction.
    private let steps = DemoData.tourSteps

    // Match the lighter onboarding background used by LoadingView and WelcomeView.
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

            VStack(spacing: 0) {
                // Top bar shows progress through the tour.
                HStack {
                    Text("Step \(currentStep + 1) of \(steps.count)")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color("TargetBlack").opacity(0.72))

                    Spacer()

                    if currentStep < steps.count - 1 {
                        Button("Skip") {
                            currentStep = steps.count - 1
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color("Gold"))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 18)
                .padding(.bottom, 10)

                TabView(selection: $currentStep) {
                    ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                        TourStepView(step: step)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(reduceMotion ? nil : .easeInOut(duration: 0.25), value: currentStep)

                // Page indicator gives the user visual feedback during the tour.
                HStack(spacing: 8) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        Capsule()
                            .fill(index == currentStep ? Color("Gold") : Color("TargetBrown").opacity(0.18))
                            .frame(width: index == currentStep ? 28 : 10, height: 10)
                    }
                }
                .padding(.top, 14)
                .padding(.bottom, 20)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Page \(currentStep + 1) of \(steps.count)")

                // Bottom buttons move the user through the tour in a straightforward way.
                HStack(spacing: 12) {
                    Button(action: goBack) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(.headline)
                        .foregroundStyle(currentStep == 0 ? Color("TargetBlack").opacity(0.35) : Color("Gold"))
                        .frame(maxWidth: .infinity, minHeight: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(currentStep == 0 ? Color("TargetBrown").opacity(0.16) : Color("Gold"), lineWidth: 1.4)
                        )
                    }
                    .disabled(currentStep == 0)

                    if currentStep == steps.count - 1 {
                        NavigationLink(destination: SignUpView()) {
                            HStack(spacing: 8) {
                                Text("Continue")
                                Image(systemName: "arrow.right.circle.fill")
                            }
                            .font(.headline)
                            .foregroundStyle(Color("TargetBlack"))
                            .frame(maxWidth: .infinity, minHeight: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("Gold"))
                            )
                        }
                    } else {
                        Button(action: goNext) {
                            HStack(spacing: 8) {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
                            .font(.headline)
                            .foregroundStyle(Color("TargetBlack"))
                            .frame(maxWidth: .infinity, minHeight: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("Gold"))
                            )
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 28)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // Moves to the previous tour step.
    private func goBack() {
        guard currentStep > 0 else { return }
        currentStep -= 1
    }

    // Moves to the next tour step.
    private func goNext() {
        guard currentStep < steps.count - 1 else { return }
        currentStep += 1
    }
}

#Preview {
    InteractiveTourView()
}
