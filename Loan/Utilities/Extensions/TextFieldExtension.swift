//
//  TextFieldExtension.swift
//  Loan
//
//  Created by JayaKoushik on 27/05/26.
//

import UIKit

extension UITextField {
    func setPicker(items: [String], target: Any, selector: Selector) {
        let picker = UIPickerView()
        picker.tag = 100
        self.inputView = picker

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)], animated: true)
        self.inputAccessoryView = toolbar
    }
}
