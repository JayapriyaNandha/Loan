/*
 Screen 1: Personal Information
 ○ Fields:
 ■ Full Name (TextField)
 ■ Email Address (TextField with email validation)
 ■ Phone Number (TextField with number validation)
 ■ Gender (TextField with PickerView)
 ■ Address (TextField-Optional)
 ○ Next Step: Proceed to the next screen after validating that all required fields are
 filled and valid.
 */

import UIKit

class PersonalViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let genderPicker = UIPickerView()
    
    private lazy var orderedFields: [UITextField] = [nameTextField, emailTextField, phoneNumberTextField, addressTextField]
    var viewModel : LoanViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenName.personalInfo.rawValue
        dismissKeyBoard()
        textFieldReturnKeySetup()
        pickerSetup()
        if viewModel?.isDraft == true {
            preFillTextField()
        }
    }
    
    func pickerSetup() {
        genderTextField.setPicker(items: viewModel?.pickerItem ?? [""], target: self, selector: #selector(donePressed))
        genderTextField.inputView = genderPicker
        if let picker = genderTextField.inputView as? UIPickerView {
            picker.delegate = self
            picker.dataSource = self
        }
    }
    
    func textFieldReturnKeySetup() {
        orderedFields.enumerated().forEach { index, field in
            field.delegate = self
            field.returnKeyType = (index == orderedFields.count - 1) ? .done : .next
        }
    }
    
    func preFillTextField() {
        if let name = viewModel?.fullName, name.count > 0, let email = viewModel?.email, email.count > 0, let gender = viewModel?.gender, gender.count > 0, let phone = viewModel?.phone, phone.count > 0 {
            nameTextField.text = name
            emailTextField.text = email
            phoneNumberTextField.text = phone
            genderTextField.text = gender
            addressTextField.text = viewModel?.address ?? ""
        }
    }
    
    @objc func donePressed() {
        if genderTextField.text == "" {
            genderTextField.text = viewModel?.pickerItem.first ?? ""
        }
        view.endEditing(true)
    }
    
    @IBAction func nextButtonEvent(_ sender: Any) {
        if isTextFieldDataValid() {
            let storyboard = UIStoryboard(name: ViewControllerTitle.bundelName.rawValue, bundle: nil)
            let financialVC = storyboard.instantiateViewController(withIdentifier: ViewControllerTitle.financialInfoVc.rawValue) as! FinancialViewController
            financialVC.viewModel = viewModel
            navigationController?.pushViewController(financialVC, animated: true)
        }
    }
    
    func isTextFieldDataValid() -> Bool {
        hideError()
        viewModel?.assignPersonalInfo(nameTextField.text, emailTextField.text, phoneNumberTextField.text, genderTextField.text, addressTextField.text)
        guard let result = viewModel?.isPersonalValid() else {
            return false
        }
        for each in result.1 {
            switch each {
            case TextFieldError.name.rawValue : nameError.isHidden = false
            case TextFieldError.email.rawValue : emailError.isHidden = false
            case TextFieldError.phone.rawValue : phoneError.isHidden = false
            case TextFieldError.gender.rawValue :
                showAlert(message:Alert.selectGender.rawValue)
            default:break
            }
        }
        return result.0
    }
    func hideError() {
        nameError.isHidden = true
        emailError.isHidden = true
        phoneError.isHidden = true
    }
}
// MARK: - TextField Delegate
extension PersonalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let idx = orderedFields.firstIndex(of: textField) else {
            textField.resignFirstResponder()
            return true
        }
        if idx < orderedFields.count - 1 {
            let next = orderedFields[idx + 1]
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
// MARK: - Picker DataSource and Delegate
extension PersonalViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.pickerItem.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.pickerItem[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = viewModel?.pickerItem[row]
    }
}
