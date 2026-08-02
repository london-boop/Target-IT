//
//  TourInfoComponents.swift
//  TargetIT
//
//  Reusable components for the Interactive Tour.
//

import SwiftUI

// MARK: - Tour Step View
// One full-screen page inside the interactive tour.
struct TourStepView: View {
    let step: TourStep

    // Scaled metrics help the tour stay readable at larger text sizes.
    @ScaledMetric(relativeTo: .title2) private var iconSize = 34
    @ScaledMetric(relativeTo: .largeTitle) private var titleSize = 30

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                // Large icon and title introduce the feature for this step.
                VStack(alignment: .leading, spacing: 14) {
                    Image(systemName: step.symbol)
                        .font(.system(size: iconSize, weight: .bold))
                        .foregroundStyle(Color("Gold"))
                        .accessibilityHidden(true)

                    Text(step.title)
                        .font(.system(size: titleSize, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("TargetBlack"))
                        .fixedSize(horizontal: false, vertical: true)

                    Text(step.subtitle)
                        .font(.body)
                        .foregroundStyle(Color("TargetBrown"))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .accessibilityElement(children: .combine)

                // Accent card brings in the finance/product feel from the PDF.
                VStack(alignment: .leading, spacing: 8) {
                    Text("Preview")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color("TargetBrown"))

                    Text(step.accentText)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color("Gold"))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color.white.opacity(0.96))
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .accessibilityElement(children: .combine)

                // Demo user card helps the tour feel more like a real product walkthrough.
                DemoAudienceCard()

                // Detail rows explain the user value of the current feature.
                VStack(spacing: 12) {
                    ForEach(step.detailRows, id: \.self) { row in
                        TourDetailRow(text: row)
                    }
                }
            }
            .padding(24)
        }
        .accessibilityElement(children: .contain)
        .accessibilityHint("Swipe left or right with three fingers to move between tour pages.")
    }
}

// MARK: - Demo Audience Card
// Shows the teenage-to-adult audience angle with the Kayla demo image.
struct DemoAudienceCard: View {
    var body: some View {
        HStack(spacing: 14) {
            Image("kaylaJones")
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 6) {
                Text("Demo User: Kayla Jones")
                    .font(.headline)
                    .foregroundStyle(Color("TargetBlack"))

                Text("Target-IT supports teenage to adult users who need a clearer way to manage subscriptions.")
                    .font(.subheadline)
                    .foregroundStyle(Color("TargetBrown"))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(16)
        .background(Color.white.opacity(0.96))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Tour Detail Row
// Reusable row used inside each tour step for quick feature explanations.
struct TourDetailRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "sparkles")
                .foregroundStyle(Color("Gold"))
                .padding(.top, 2)
                .accessibilityHidden(true)

            Text(text)
                .font(.subheadline)
                .foregroundStyle(Color("TargetBlack"))
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
        .padding(16)
        .background(Color.white.opacity(0.96))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}
