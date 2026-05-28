//
//  HomeViewController.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func newLoanApplication(_ sender: Any) {
        let storyboard = UIStoryboard(name: ViewControllerTitle.bundelName.rawValue, bundle: nil)
        let personalVC = storyboard.instantiateViewController(withIdentifier: ViewControllerTitle.personalInfoVc.rawValue)
        navigationController?.pushViewController(personalVC, animated: true)
    }
    
    @IBAction func appliedLoans(_ sender: Any) {
    }
    
    
    @IBAction func savedLoan(_ sender: Any) {
    }
}
