//
//  ViewControllerExtension.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = Alert.alert.rawValue, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.ok.rawValue, style: .default))
        present(alert, animated: true)
    }
    
    func dismissKeyBoard() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFirstResponder))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissFirstResponder() {
        self.view.endEditing(true)
    }
    
    func successAlert() {
        let alert = UIAlertController(title: Alert.success.rawValue,message: Alert.applicationSuccess.rawValue,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.ok.rawValue, style: .default) { [weak self] _ in
                self?.navigationController?.popToRootViewController(animated: true)
            })
            present(alert, animated: true)
        }
}
