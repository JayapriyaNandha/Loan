//
//  PersonalInfoVM.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//
import Foundation
import CoreData

class LoanViewModel {
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
    var isDraft = false
    
    var forms: [FormData] = []{
        didSet {
            onUpdate?()
        }
    }
    var onUpdate: (() -> Void)?
    //MARK: - Personal infomation
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
    func assignPersonalInfo(_ name:String?, _ email:String?, _ phone:String?, _ gender:String?, _ address:String?) {
        self.fullName = name ?? ""
        self.email = email ?? ""
        self.phone = phone ?? ""
        self.gender = gender ?? ""
        self.address = address ?? ""
    }
    
    //MARK: - Financial infomation
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
    func assignFinancialInfo(_ income:String?, _ loanAmount:String?, _ irdNumber:String?) {
        self.annualIncome = income ?? ""
        self.loanAmount = loanAmount ?? ""
        self.irdNumber = irdNumber ?? ""
    }
    func refresh() {
        fullName = ""
        email = ""
        phone = ""
        gender = ""
        address = ""
        annualIncome = ""
        loanAmount = ""
        irdNumber = ""
    }
    //MARK: - Core data
    var isSaveSucessfully : Bool = false
    let repo = FormDataRepository(context: PersistenceController.shared.container.viewContext)
    func saveForm() {
        let form = FormData(
            name: fullName,
            email: email,
            phone: phone,
            gender: gender,
            address: address,
            annualIncome: annualIncome,
            loanAmount: loanAmount,
            irdNumber: irdNumber,
            submittedAt: Date())
        repo.save(form)
        print("Form saved successfully")
        confirmStorage()
    }
    // Test for saved data
    func confirmStorage() {
        let context = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<FormDataEntity>(entityName: "FormDataEntity")
        do {
            let results = try context.fetch(request)
            print("Saved objects count:", results.count)
            if results.count > 0 {
                isSaveSucessfully = true
            }
            for item in results {
                print("Item:", item)
            }
        } catch {
            print("Fetch error:", error)
        }
    }
    
    //MARK: - Applied list
    func loadForms() {
        forms = repo.fetchAll().sorted { $0.submittedAt > $1.submittedAt }
    }
    
    func deleteForm(id: UUID?) {
        if let id = id {
            repo.deleteById(id)
        }
        forms = repo.fetchAll().sorted { $0.submittedAt > $1.submittedAt }
        onUpdate?()
    }
    
    //MARK: - user default
    func resumeFormFilling() {
        clearDataFromUserDefaults()
        let form = FormData(name: fullName, email: email, phone: phone, gender: gender, address: address, annualIncome: annualIncome, loanAmount: loanAmount, irdNumber: irdNumber, submittedAt: Date())
            UserDefaultsManager.shared.saveForm(form)
    }
    
    func assignFormData() {
        let form = UserDefaultsManager.shared.loadForm()
        if form?.name != nil {
            isDraft = true
        }
        self.fullName = form?.name ?? ""
        self.email = form?.email ?? ""
        self.phone = form?.phone ?? ""
        self.gender = form?.gender ?? ""
        self.address = form?.address ?? ""
        self.annualIncome = form?.annualIncome ?? ""
        self.loanAmount = form?.loanAmount ?? ""
        self.irdNumber = form?.irdNumber ?? ""
    }
    func clearDataFromUserDefaults() {
        UserDefaultsManager.shared.clearForm()
    }
}
