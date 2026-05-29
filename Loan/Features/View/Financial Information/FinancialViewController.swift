/*
 Screen 2: Financial Information
 ○ Fields:
 ■ Annual Income (TextField with number validation)
 ■ Desired Loan Amount (TextField with number validation)
 ■ IRD Number (TextField with number validation)
 ○ Next Step: After validating income and loan amount (e.g., loan amount cannot
 exceed 50% of annual income), proceed to the next screen.
 */

import UIKit

class FinancialViewController: UIViewController {
    
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var irdTextField: UITextField!
    @IBOutlet weak var loanTextField: UITextField!
    var viewModel : LoanViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenName.financialInfo.rawValue
        dismissKeyBoard()
        prefillData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveEvent(_ sender: Any) {
        assignData()
        viewModel?.resumeFormFilling()
        navigationController?.popToRootViewController(animated: true)
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
        assignData()
        if let result = viewModel?.validateFinancial() {
            showAlert(title: Alert.error.rawValue, message: result)
            return false
        }
        return true
    }
    func assignData() {
        viewModel?.assignFinancialInfo(incomeTextField.text, loanTextField.text, irdTextField.text)
    }
    func prefillData() {
        self.incomeTextField.text = self.viewModel?.annualIncome ?? ""
        self.loanTextField.text = self.viewModel?.loanAmount ?? ""
        self.irdTextField.text = self.viewModel?.irdNumber ?? ""
    }
}
