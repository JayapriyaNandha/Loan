//
//  UserDefaultsManager.swift
//  Loan
//
//  Created by JayaKoushik on 29/05/26.
//
import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let formKey = "savedForm"

    private init() {}

    // Save
    func saveForm(_ form: FormData) {
        if let data = try? JSONEncoder().encode(form) {
            UserDefaults.standard.set(data, forKey: formKey)
        }
    }

    // Load
    func loadForm() -> FormData? {
        guard let data = UserDefaults.standard.data(forKey: formKey) else { return nil }
        return try? JSONDecoder().decode(FormData.self, from: data)
    }

    // Clear
    func clearForm() {
        UserDefaults.standard.removeObject(forKey: formKey)
    }
}

