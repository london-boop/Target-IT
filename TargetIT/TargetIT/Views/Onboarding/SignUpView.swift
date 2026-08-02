//
//  SignUpView.swift
//  TargetIT
//
//  Local SwiftData sign up flow for MVP use.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \User.createdAt) private var users: [User]

    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var authenticatedUser: User?

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text("Sign Up")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(Color("TargetBlack"))

                    Text("Create a local Target-IT account on this device so your progress and subscriptions stay saved.")
                        .font(.body)
                        .foregroundStyle(Color("TargetBrown"))

                    authField(title: "Full Name", text: $fullName)
                    authField(title: "Email", text: $email, keyboardType: .emailAddress, textContentType: .emailAddress, autocapitalization: .never)
                    secureAuthField(title: "Password", text: $password, textContentType: .newPassword)
                    secureAuthField(title: "Confirm Password", text: $confirmPassword, textContentType: .newPassword)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }

                    Button(action: createAccount) {
                        Text("Create Account")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color("TargetBrown"))
                            .cornerRadius(16)
                    }

                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .font(.callout)
                            .foregroundStyle(Color("TargetBlack").opacity(0.72))

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
        .navigationDestination(item: $authenticatedUser) { _ in
            AppRootShellView()
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
        textContentType: UITextContentType? = nil,
        autocapitalization: TextInputAutocapitalization = .words
    ) -> some View {
        TextField(title, text: text)
            .textInputAutocapitalization(autocapitalization)
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

    // MARK: - Account Creation
    // Validates the fields, creates a local user, and saves it with SwiftData.
    private func createAccount() {
        let normalizedEmail = AuthSession.normalizedEmail(email)
        let trimmedName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty else {
            errorMessage = "Please enter your full name."
            return
        }

        guard !normalizedEmail.isEmpty else {
            errorMessage = "Please enter your email."
            return
        }

        guard normalizedEmail.contains("@") else {
            errorMessage = "Please enter a valid email address."
            return
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        guard users.contains(where: { AuthSession.normalizedEmail($0.email) == normalizedEmail }) == false else {
            errorMessage = "An account with that email already exists on this device."
            return
        }

        let salt = AuthSession.generateSalt()
        let passwordHash = AuthSession.hashPassword(password, salt: salt)

        let newUser = User(
            fullName: trimmedName,
            email: normalizedEmail,
            passwordHash: passwordHash,
            passwordSalt: salt,
            profileImageName: AuthSession.defaultProfileImageName(for: trimmedName)
        )

        modelContext.insert(newUser)

        do {
            try modelContext.save()
            AuthSession.setActiveUserID(newUser.id)
            authenticatedUser = newUser
            errorMessage = ""
        } catch {
            errorMessage = "We couldn’t create your account right now. Please try again."
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
    .modelContainer(for: User.self, inMemory: true)
}
