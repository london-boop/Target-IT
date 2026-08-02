//
//  SignUpView.swift
//  TargetIT
//
//  Placeholder sign-up screen for Phase 3.
//  This keeps the onboarding flow correct before the full form is built.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack {
            Color("TargetBlack")
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text("Sign Up")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("TargetWhite"))

                    Text("This placeholder reserves the correct sign-up step for the interns before the full form is implemented.")
                        .font(.body)
                        .foregroundStyle(Color("TargetWhite").opacity(0.8))

                    // Placeholder fields help the interns understand the screen structure first.
                    PlaceholderField(label: "Full Name")
                    PlaceholderField(label: "Email")
                    PlaceholderField(label: "Password")

                    // Temporary button to continue into the shell spike.
                    NavigationLink(destination: MainTabView()) {
                        Text("Continue to App")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Color("TargetBlack"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color("Gold"))
                            .cornerRadius(16)
                    }

                    // Returning users can navigate to Login from here.
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .font(.callout)
                            .foregroundStyle(Color("TargetWhite").opacity(0.8))

                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(Color("Gold"))
                        }
                    }
                }
                .padding(24)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    SignUpView()
}
