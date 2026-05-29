//
//  HomeViewController.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var newLoanButton: UIButton!
    @IBOutlet weak var appliedButton: UIButton!
    lazy var viewModel = LoanViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newLoanApplication(_ sender: Any) {
        viewModel.refresh()
        viewModel.isDraft = false
        let storyboard = UIStoryboard(name: ViewControllerTitle.bundelName.rawValue, bundle: nil)
        let personalVC = storyboard.instantiateViewController(withIdentifier: ViewControllerTitle.personalInfoVc.rawValue) as! PersonalViewController
        personalVC.viewModel = viewModel
        navigationController?.pushViewController(personalVC, animated: true)
    }
    
    @IBAction func appliedLoans(_ sender: Any) {
        let storyboard = UIStoryboard(name: ViewControllerTitle.bundelName.rawValue, bundle: nil)
        let personalVC = storyboard.instantiateViewController(withIdentifier: ViewControllerTitle.appliedVC.rawValue) as! AppliedViewController
        personalVC.viewModel = viewModel
        navigationController?.pushViewController(personalVC, animated: true)
    }
    
    @IBAction func resumeEvent(_ sender: Any) {
        viewModel.assignFormData()
        if viewModel.isDraft {
            let storyboard = UIStoryboard(name: ViewControllerTitle.bundelName.rawValue, bundle: nil)
            let personalVC = storyboard.instantiateViewController(withIdentifier: ViewControllerTitle.personalInfoVc.rawValue) as! PersonalViewController
            personalVC.viewModel = viewModel
            navigationController?.pushViewController(personalVC, animated: true)
        } else {
            showAlert(message: FinancialInfoTextFieldError.newLoan.rawValue)
        }
    }
}
