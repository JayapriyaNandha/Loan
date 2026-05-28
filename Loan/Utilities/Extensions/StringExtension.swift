//
//  StringExtension.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//
import Foundation

extension String {
    
    // Full Name: At least 2 words, each ≥ 2 letters
    var isValidFullName: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = "^[A-Za-z]{2,}+\\s+[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: trimmed)
    }
    
    // Email Validation
    var isValidEmail: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: trimmed)
    }
    
    // Phone: 7–15 digits, optional + at start
    var isValidPhone: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = "^[+]?\\d{7,15}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: trimmed)
    }
    
    var isNumeric: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = "^[0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: trimmed)
    }
}



