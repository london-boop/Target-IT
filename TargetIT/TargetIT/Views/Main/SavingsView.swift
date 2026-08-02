//
//  SavingsView.swift
//  TargetIT
//
//  Lists seeded savings goals for the Phase 3 shell.
//

import SwiftUI

struct SavingsView: View {
    private let goals = DemoData.goals

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Savings Hub")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color("TargetWhite"))

                ForEach(goals) { goal in
                    SavingsGoalCard(goal: goal)
                }
            }
            .padding(20)
        }
        .background(Color("TargetBlack").ignoresSafeArea())
    }
}

#Preview {
    SavingsView()
}
