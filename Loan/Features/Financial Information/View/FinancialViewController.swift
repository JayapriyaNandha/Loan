//
//  FinancialViewController.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//

import UIKit

class FinancialViewController: UIViewController {
    
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var irdTextField: UITextField!
    @IBOutlet weak var loanTextField: UITextField!
    var viewModel : PersonalInfoVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenName.financialInfo.rawValue
        prefillData()
        // Do any additional setup after loading the view.
    }

    func prefillData() {
        if viewModel?.annualIncome != nil {
            DispatchQueue.main.async {
                self.incomeTextField.text = self.viewModel?.annualIncome
                self.loanTextField.text = self.viewModel?.loanAmount
                self.irdTextField.text = self.viewModel?.irdNumber
            }
        }
    }
    
    @IBAction func nextEvent(_ sender: Any) {
        if isTextFieldDataValid() {
            let storyboard = UIStoryboard(name: ViewControllerTitle.bundelName.rawValue, bundle: nil)
            let reviewVC = storyboard.instantiateViewController(withIdentifier: ViewControllerTitle.reviewVc.rawValue) as! ReviewAndSubmitViewController
            reviewVC.viewModel = viewModel
            navigationController?.pushViewController(reviewVC, animated: true)
        }
    }
    
    func isTextFieldDataValid() -> Bool {
        viewModel?.annualIncome = incomeTextField.text ?? ""
        viewModel?.loanAmount = loanTextField.text ?? ""
        viewModel?.irdNumber = irdTextField.text ?? ""
        if let result = viewModel?.validateFinancial() {
            showAlert(title: Alert.error.rawValue, message: result)
            return false
        }
        return true
    }
}
