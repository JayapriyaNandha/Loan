//
//  HomeVM.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//
import Foundation

struct FormData : Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var email: String
    var phone: String
    var gender: String
    var address: String
    var annualIncome: String
    var loanAmount: String
    var irdNumber: String
    let submittedAt: Date
}
