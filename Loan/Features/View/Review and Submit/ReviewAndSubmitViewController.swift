/*
 Screen 3: Review and Submit
 ○ Fields:
 ■ Display a summary of the personal and financial information entered.
 ○ Actions:
 ■ Provide buttons to Edit (to go back and edit details on the previous
 screens) or Submit the form.
 ■ Upon submission, save the form locally and show a success message.
 */

import UIKit

class ReviewAndSubmitViewController: UIViewController {
    
    @IBOutlet weak var reviewLabel: UILabel!
    var viewModel : LoanViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenName.reviewAndSubmit.rawValue
        let text = """
                Personal Information
                
                  Name: \(viewModel?.fullName ?? "")
                
                  Email: \(viewModel?.email ?? "")
                
                  Phone: \(viewModel?.phone ?? "")
                
                  Gender: \(viewModel?.gender ?? "")
                
                  Address: \(viewModel?.address ?? "")
                
                Financial Information
                
                  Annual Income: $\(viewModel?.annualIncome ?? "")
                
                  Desired Loan Amount: $\(viewModel?.loanAmount ?? "") 
                
                  IRD Number: \(viewModel?.irdNumber ?? "")
                """
        reviewLabel.text = text
    }
    
    @IBAction func submitEvent(_ sender: Any) {
        if viewModel?.isDraft == true {
            viewModel?.isDraft = false
            // user default clearing - draft
            viewModel?.clearDataFromUserDefaults()
        }
        // core data saving
        DispatchQueue.main.async {
            self.viewModel?.saveForm()
        }
        successAlert()
    }
    
    @IBAction func editEvent(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
