//
//  SharedStyles.swift
//  TargetIT
//
//  Shared style helpers used across the Phase 3 screens.
//

import SwiftUI

// Shared panel background used across cards in the shell.
let panelColor = Color.white.opacity(0.08)

// Shared title styling for dashboard sections.
func sectionTitle(_ title: String) -> some View {
    Text(title)
        .font(.title3.weight(.semibold))
        .foregroundStyle(Color("TargetWhite"))
}
