//
//  ReviewAndSubmitViewController.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//

import UIKit

class ReviewAndSubmitViewController: UIViewController {

    @IBOutlet weak var reviewLabel: UILabel!
//    private var viewModel = ReviewVM()
    var viewModel : PersonalInfoVM?
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
                
                  Annual Income: \(viewModel?.annualIncome ?? "")
                
                  Desired Loan Amount: \(viewModel?.loanAmount ?? "") 
                
                  IRD Number: \(viewModel?.irdNumber ?? "")
                """
        reviewLabel.text = text
    }
    
    @IBAction func submitEvent(_ sender: Any) {
        successAlert()
    }
    
    @IBAction func editEvent(_ sender: Any) {
        if let personalVC = navigationController?.viewControllers.first(where: { $0 is PersonalViewController }) {
            navigationController?.popToViewController(personalVC, animated: true)
        }
    }
    
    func successAlert() {
        let alert = UIAlertController(
            title: "Success",
            message: "Your loan application has been submitted.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        })
        present(alert, animated: true)
    }
}
