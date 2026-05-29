//
//  Constants.swift
//  Loan
//
//  Created by JayaKoushik on 28/05/26.
//

enum ScreenName : String {
    case personalInfo = "Personal Information"
    case financialInfo = "Financial Information"
    case reviewAndSubmit = "Review and Submit"
    case applied = "Loan Applied"
}
enum Gender : String {
    case male = "Male"
    case female = "Female"
    case others = "Others"
}
enum TextFieldError : String {
    case name = "Name"
    case email = "Email"
    case phone = "Phone"
    case gender = "Gender"
    case address = "Address"
    case salary = "Salary"
    case loanAmount = "Loan Amount"
    case irdNumber = "Aadhar/Pan"
}
enum FinancialInfoTextFieldError : String {
    case annualIncome = "Please enter a valid annual income."
    case loanAmount = "Please enter a valid desired loan amount."
    case loanLimit = "Loan amount cannot exceed 50% of annual income."
    case irdNumber = "Please enter a valid IRD number."
    case newLoan = "Please proceed with new loan application"
}
enum Alert : String {
    case error = "Error"
    case selectGender = "Please select Gender"
    case success = "Success"
    case applicationSuccess = "Your loan application has been submitted."
    case ok = "OK"
    case alert = "Alert"
}
enum ViewControllerTitle : String {
    case bundelName = "Main"
    case personalInfoVc = "PersonalViewController"
    case financialInfoVc = "FinancialViewController"
    case reviewVc = "ReviewAndSubmitViewController"
    case appliedVC = "AppliedViewController"
}
