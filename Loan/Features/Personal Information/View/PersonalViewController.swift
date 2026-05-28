//
//  PersonalViewController.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//

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
    var viewModel = PersonalInfoVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenName.personalInfo.rawValue
        dismissKeyBoard()
        textFieldReturnKeySetup()
        pickerSetup()
    }
    
    func pickerSetup() {
        genderTextField.setPicker(items: viewModel.pickerItem, target: self, selector: #selector(donePressed))
        genderTextField.inputView = genderPicker
        if let picker = genderTextField.inputView as? UIPickerView {
            picker.delegate = self
            picker.dataSource = self
        }
    }
    
    func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    func textFieldReturnKeySetup() {
        orderedFields.enumerated().forEach { index, field in
            field.delegate = self
            field.returnKeyType = (index == orderedFields.count - 1) ? .done : .next
        }
    }
    
    @objc func donePressed() {
        if genderTextField.text == "" {
            genderTextField.text = viewModel.pickerItem.first
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
    
    @IBAction func resumeButtonEvent(_ sender: Any) {
    }
    
    func isTextFieldDataValid() -> Bool {
        viewModel.assignPersonalInfo(nameTextField.text, emailTextField.text, phoneNumberTextField.text, genderTextField.text, addressTextField.text)
        let result = viewModel.isPersonalValid()
        for each in result.1 {
            switch each {
            case TextFieldError.name.rawValue : nameError.isHidden = false
            case TextFieldError.email.rawValue : emailError.isHidden = false
            case TextFieldError.phone.rawValue : phoneError.isHidden = false
            case TextFieldError.gender.rawValue :
                showAlert(message:Alert.selectGender.rawValue)
            default:
                break
            }
        }
        return result.0
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
        return viewModel.pickerItem.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.pickerItem[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = viewModel.pickerItem[row]
    }
}
