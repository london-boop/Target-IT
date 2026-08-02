//
//  PlaceholderField.swift
//  TargetIT
//
//  Reusable field shell used for onboarding placeholders.
//

import SwiftUI

struct PlaceholderField: View {
    let label: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color("TargetBlack").opacity(0.84))

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.92))
                .frame(height: 54)
                .overlay(alignment: .leading) {
                    Text("Placeholder")
                        .font(.subheadline)
                        .foregroundStyle(Color("TargetBrown").opacity(0.65))
                        .padding(.horizontal, 16)
                }
        }
    }
}
