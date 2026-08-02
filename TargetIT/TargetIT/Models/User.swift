//
//  User.swift
//  TargetIT
//
//  Local user account model for Phase 3 auth entry.
//

import Foundation
import SwiftData

@Model
final class User {
    var id: UUID
    var fullName: String
    var email: String

    // The password hash is stored separately from the salt.
    // This keeps local auth more secure than a raw unsalted hash.
    var passwordHash: String
    var passwordSalt: String

    // Demo profile art should only be assigned intentionally.
    // Most local accounts should leave this empty unless they match seeded demo content.
    var profileImageName: String
    var createdAt: Date
    var lastLoginAt: Date?

    init(
        id: UUID = UUID(),
        fullName: String,
        email: String,
        passwordHash: String,
        passwordSalt: String = "",
        profileImageName: String = "",
        createdAt: Date = Date(),
        lastLoginAt: Date? = nil
    ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.passwordHash = passwordHash
        self.passwordSalt = passwordSalt
        self.profileImageName = profileImageName
        self.createdAt = createdAt
        self.lastLoginAt = lastLoginAt
    }
}
