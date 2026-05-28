//
//  PersonalInfoVM.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//
import Foundation


class PersonalInfoVM : BaseViewModel {
    var pickerItem = [Gender.male.rawValue, Gender.female.rawValue, Gender.others.rawValue]
    var fullName = ""
    var email = ""
    var phone = ""
    var gender = ""
    var address = ""
    
    var annualIncome = ""
    var loanAmount = ""
    var irdNumber = ""
    var loanToIncomeLimit: Double { 0.5 }
    
    func isPersonalValid() -> (Bool, [String]) {
        var errors: [String] = []
        if fullName.isEmpty == true || !fullName.isValidFullName {
            errors.append(TextFieldError.name.rawValue)
        }
        if email.isEmpty == true || !email.isValidEmail {
            errors.append(TextFieldError.email.rawValue)
        }
        if phone.isEmpty == true || !phone.isValidPhone {
            errors.append(TextFieldError.phone.rawValue)
        }
        if gender.isEmpty == true {
            errors.append(TextFieldError.gender.rawValue)
        }
        let isValid = errors.count == 0 ? true : false
        return (isValid, errors)
    }
    
    func validateFinancial() -> String? {
            guard let income = Double(annualIncome), income > 0 else {
                return FinancialInfoTextFieldError.annualIncome.rawValue
            }
            guard let loan = Double(loanAmount), loan > 0 else {
                return FinancialInfoTextFieldError.loanAmount.rawValue
            }
            if loan > income * loanToIncomeLimit {
                return FinancialInfoTextFieldError.loanLimit.rawValue
            }
            if irdNumber.trimmingCharacters(in: .whitespaces).isEmpty || !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: irdNumber)) {
                return FinancialInfoTextFieldError.irdNumber.rawValue
            }
            return nil
        }
    
    func assignPersonalInfo(_ name:String?, _ email:String?, _ phone:String?, _ gender:String?, _ address:String?) {
        self.fullName = name ?? ""
        self.email = email ?? ""
        self.phone = phone ?? ""
        self.gender = gender ?? ""
        self.address = address ?? ""
    }
}
