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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                // Large icon and title introduce the feature for this step.
                VStack(alignment: .leading, spacing: 14) {
                    Image(systemName: step.symbol)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(Color("Gold"))

                    Text(step.title)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("TargetBlack"))

                    Text(step.subtitle)
                        .font(.body)
                        .foregroundStyle(Color("TargetBrown"))
                }

                // Accent card brings in the finance/product feel from the PDF.
                VStack(alignment: .leading, spacing: 8) {
                    Text("Preview")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color("TargetBrown"))

                    Text(step.accentText)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color("Gold"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color.white.opacity(0.92))
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

                // Detail rows explain the user value of the current feature.
                VStack(spacing: 12) {
                    ForEach(step.detailRows, id: \.self) { row in
                        TourDetailRow(text: row)
                    }
                }
            }
            .padding(24)
        }
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

            Text(text)
                .font(.subheadline)
                .foregroundStyle(Color("TargetBlack"))

            Spacer()
        }
        .padding(16)
        .background(Color.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
