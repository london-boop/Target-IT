//
//  SavingsView.swift
//  TargetIT
//
//  Lists seeded savings goals for the Phase 3 shell.
//

import SwiftUI

struct SavingsView: View {
    @EnvironmentObject private var appDataStore: AppDataStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Savings Hub")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color("TargetBlack"))

                if appDataStore.goals.isEmpty {
                    Text("No savings goals yet.")
                        .font(.subheadline)
                        .foregroundStyle(Color("TargetBlack").opacity(0.72))
                        .padding(18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(panelColor)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                } else {
                    ForEach(appDataStore.goals) { goal in
                        SavingsGoalCard(goal: goal)
                    }
                }
            }
            .padding(20)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    SavingsView()
}
