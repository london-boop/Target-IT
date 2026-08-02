//
//  Formatters.swift
//  TargetIT
//
//  Shared formatting helpers used by the demo views.
//

import Foundation

// MARK: - Currency Formatting
// Keeps money formatting logic out of the view bodies.
extension Double {
    var currencyText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
}

// MARK: - Date Formatting
// Small helpers for readable dates in cards and accessibility text.
extension Date {
    static func daysFromNow(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: Date()) ?? Date()
    }

    var shortDateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    var accessibilityDateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
