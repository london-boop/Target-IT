//
//  WelcomeFeatureRow.swift
//  TargetIT
//
//  Reusable row used on the Welcome screen for short feature highlights.
//

import SwiftUI

struct WelcomeFeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(Color("Gold"))
                .frame(width: 22)

            Text(text)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color("TargetBlack"))

            Spacer()
        }
        .padding(14)
        .background(Color.white.opacity(0.48))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
