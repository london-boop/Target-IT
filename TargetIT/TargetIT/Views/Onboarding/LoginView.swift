//
//  LoginView.swift
//  TargetIT
//
//  Placeholder login screen for Phase 3.
//  This keeps the returning-user path visible in the taught navigation style.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text("Login")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("TargetBlack"))

                    Text("This placeholder keeps the login route in place until the full returning-user flow is implemented.")
                        .font(.body)
                        .foregroundStyle(Color("TargetBrown"))

                    // Placeholder fields define the basic login structure.
                    PlaceholderField(label: "Email")
                    PlaceholderField(label: "Password")

                    // Temporary button to continue into the shell spike.
                    NavigationLink(destination: MainTabView()) {
                        Text("Log in to App")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color("TargetBrown"))
                            .cornerRadius(16)
                    }

                    // New users can go back to Sign Up.
                    HStack(spacing: 4) {
                        Text("Need an account?")
                            .font(.callout)
                            .foregroundStyle(Color("TargetBlack").opacity(0.72))

                        NavigationLink(destination: SignUpView()) {
                            Text("Sign up")
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
    LoginView()
}
