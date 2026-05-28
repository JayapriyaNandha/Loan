//
//  HomeVM.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//
import Foundation

struct FormData : Codable {
    var personal: PersonalData
    var financial: FinancialData
}

struct PersonalData : Codable {
    var name: String
    var email: String
    var phone: String
    var gender: String
    var address: String
}

struct FinancialData : Codable {
    var salary: Double
    var loan: Double
    var ird: String
    let submittedAt: Date
}
