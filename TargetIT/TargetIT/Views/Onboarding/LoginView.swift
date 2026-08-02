//
//  LoginView.swift
//  TargetIT
//
//  Local SwiftData login flow for MVP use.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \User.createdAt) private var users: [User]

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var authenticatedUser: User?

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text("Login")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("TargetBlack"))

                    Text("Log in with a local account saved on this device.")
                        .font(.body)
                        .foregroundStyle(Color("TargetBrown"))

                    authField(title: "Email", text: $email, keyboardType: .emailAddress, textContentType: .emailAddress)
                    secureAuthField(title: "Password", text: $password, textContentType: .password)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }

                    Button(action: logIn) {
                        Text("Log In")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color("TargetBrown"))
                            .cornerRadius(16)
                    }

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
        .navigationDestination(item: $authenticatedUser) { _ in
            MainTabView()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Text Field Helper
    // Keeps the regular text field styling consistent across the form.
    @ViewBuilder
    private func authField(
        title: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil
    ) -> some View {
        TextField(title, text: text)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .keyboardType(keyboardType)
            .textContentType(textContentType)
            .padding(.horizontal, 16)
            .frame(minHeight: 54)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("TargetBrown").opacity(0.18), lineWidth: 1)
            )
            .cornerRadius(16)
    }

    // MARK: - Secure Field Helper
    // Keeps password field styling consistent with the rest of the form.
    @ViewBuilder
    private func secureAuthField(title: String, text: Binding<String>, textContentType: UITextContentType? = nil) -> some View {
        SecureField(title, text: text)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .textContentType(textContentType)
            .padding(.horizontal, 16)
            .frame(minHeight: 54)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("TargetBrown").opacity(0.18), lineWidth: 1)
            )
            .cornerRadius(16)
    }

    // MARK: - Login Logic
    // Checks local credentials and opens the app when they match.
    private func logIn() {
        let normalizedEmail = AuthSession.normalizedEmail(email)

        guard !normalizedEmail.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter your email and password."
            return
        }

        guard let matchedUser = users.first(where: {
            AuthSession.normalizedEmail($0.email) == normalizedEmail &&
            AuthSession.verifyPassword(password, storedHash: $0.passwordHash, storedSalt: $0.passwordSalt)
        }) else {
            errorMessage = "We couldn't find an account with that email and password."
            return
        }

        // Upgrade any older unsalted local test accounts to the current salted format.
        if matchedUser.passwordSalt.isEmpty {
            let newSalt = AuthSession.generateSalt()
            matchedUser.passwordSalt = newSalt
            matchedUser.passwordHash = AuthSession.hashPassword(password, salt: newSalt)
        }

        matchedUser.lastLoginAt = Date()

        do {
            try modelContext.save()
            AuthSession.setActiveUserID(matchedUser.id)
            authenticatedUser = matchedUser
            errorMessage = ""
        } catch {
            errorMessage = "We couldn't log you in right now. Please try again."
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .modelContainer(for: User.self, inMemory: true)
}
