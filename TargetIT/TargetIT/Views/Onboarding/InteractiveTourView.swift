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

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar shows progress through the tour.
                HStack {
                    Text("Step \(currentStep + 1) of \(steps.count)")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color("TargetBrown"))

                    Spacer()

                    if currentStep < steps.count - 1 {
                        Button("Skip") {
                            currentStep = steps.count - 1
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color("TargetBrown"))
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
                            .fill(index == currentStep ? Color("TargetBrown") : Color("TargetBrown").opacity(0.18))
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
                        .foregroundStyle(currentStep == 0 ? Color("TargetBrown").opacity(0.35) : Color("TargetBrown"))
                        .frame(maxWidth: .infinity, minHeight: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(currentStep == 0 ? Color("TargetBrown").opacity(0.16) : Color("TargetBrown"), lineWidth: 1.4)
                        )
                    }
                    .disabled(currentStep == 0)

                    if currentStep == steps.count - 1 {
                        NavigationLink(destination: SignUpView()) {
                            HStack(spacing: 8) {
                                Text("Continue")
                                Image(systemName: "arrow.right.circle.fill")
                            }
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("TargetBrown"))
                            )
                        }
                    } else {
                        Button(action: goNext) {
                            HStack(spacing: 8) {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("TargetBrown"))
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
