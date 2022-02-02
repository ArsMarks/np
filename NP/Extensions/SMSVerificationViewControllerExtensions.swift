//
//  SMSVerificationViewControllerExtensions.swift
//  NP
//
//  Created by Рушан Киньягулов on 04.01.2022.
//

import UIKit

extension SMSVerificationViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if smsVerificationView.smsCodeTextField.text?.count == 6 {
            smsVerificationView.doneButton.backgroundColor = Color.brandRed
            smsVerificationView.doneButton.layer.borderColor = Color.brandRed.cgColor
            smsVerificationView.doneButton.addTarget(self,
                                                     action: #selector(buttonAction(sender:)),
                                                     for: .touchUpInside)
        } else {
            smsVerificationView.doneButton.backgroundColor = Color.brandGray
            smsVerificationView.doneButton.layer.borderColor = Color.brandGray.cgColor
            smsVerificationView.doneButton.removeTarget(self,
                                                        action: #selector(buttonAction(sender:)),
                                                        for: .touchUpInside)
        }
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 6
    }
}
