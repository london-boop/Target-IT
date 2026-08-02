//
//  WelcomeStatCard.swift
//  TargetIT
//
//  Small preview card used to match the finance-dashboard personality from the PDF.
//

import SwiftUI

struct WelcomeStatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color("TargetBrown"))

            Text(value)
                .font(.title3.weight(.bold))
                .foregroundStyle(Color("Gold"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.white.opacity(0.92))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color("TargetBrown").opacity(0.18), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
