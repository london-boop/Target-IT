//
//  AuthSession.swift
//  TargetIT
//
//  Local-only auth/session helpers for MVP use.
//

import Foundation
import CommonCrypto
import CryptoKit
import Security

enum AuthSession {
    private static let activeUserKey = "TargetIT.activeUserID"
    private static let pbkdfRounds: UInt32 = 100_000
    private static let derivedKeyLength = 32

    static func normalizedEmail(_ value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    // Generates a unique random salt for each user password.
    static func generateSalt(byteCount: Int = 16) -> String {
        var data = Data(count: byteCount)

        let status = data.withUnsafeMutableBytes { rawBuffer in
            guard let baseAddress = rawBuffer.baseAddress else {
                return errSecParam
            }

            return SecRandomCopyBytes(kSecRandomDefault, byteCount, baseAddress)
        }

        if status == errSecSuccess {
            return data.base64EncodedString()
        }

        var generator = SystemRandomNumberGenerator()
        let fallbackBytes = (0..<byteCount).map { _ in UInt8.random(in: UInt8.min...UInt8.max, using: &generator) }
        return Data(fallbackBytes).base64EncodedString()
    }

    // Derives a password hash using PBKDF2 with HMAC-SHA256.
    static func hashPassword(_ password: String, salt: String) -> String {
        guard let saltData = Data(base64Encoded: salt) else {
            return ""
        }

        var derivedKey = Data(repeating: 0, count: derivedKeyLength)

        let result = derivedKey.withUnsafeMutableBytes { derivedKeyBytes in
            saltData.withUnsafeBytes { saltBytes in
                password.withCString { passwordPointer in
                    CCKeyDerivationPBKDF(
                        CCPBKDFAlgorithm(kCCPBKDF2),
                        passwordPointer,
                        password.utf8.count,
                        saltBytes.bindMemory(to: UInt8.self).baseAddress,
                        saltData.count,
                        CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
                        pbkdfRounds,
                        derivedKeyBytes.bindMemory(to: UInt8.self).baseAddress,
                        derivedKeyLength
                    )
                }
            }
        }

        guard result == kCCSuccess else {
            return ""
        }

        return derivedKey.base64EncodedString()
    }

    // Keeps legacy support in case an earlier unsalted test account exists locally.
    static func verifyPassword(_ password: String, storedHash: String, storedSalt: String) -> Bool {
        if storedSalt.isEmpty {
            return legacyHashPassword(password) == storedHash
        }

        return hashPassword(password, salt: storedSalt) == storedHash
    }

    // Uses the hardcoded Kayla image only when the user account is intentionally the demo user.
    static func defaultProfileImageName(for fullName: String) -> String {
        let normalizedName = fullName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return normalizedName == "kayla jones" ? "kaylaJones" : ""
    }

    static func setActiveUserID(_ id: UUID?) {
        UserDefaults.standard.set(id?.uuidString, forKey: activeUserKey)
    }

    static func activeUserID() -> UUID? {
        guard let raw = UserDefaults.standard.string(forKey: activeUserKey) else {
            return nil
        }

        return UUID(uuidString: raw)
    }

    static func clearActiveUser() {
        UserDefaults.standard.removeObject(forKey: activeUserKey)
    }

    // Old unsalted hash retained only to support local upgrade during development.
    private static func legacyHashPassword(_ password: String) -> String {
        let digest = SHA256.hash(data: Data(password.utf8))
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
