//
//  AuthorizationViewControllerExtensions.swift
//  NP
//
//  Created by Рушан Киньягулов on 04.01.2022.
//

import UIKit

extension AuthorizationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XX-XX", phone: newString)
        
        if textField.text?.count == 18 {
            [authView, profileWithoutAuthView].forEach { views in
                views.enterButton.backgroundColor = Color.brandRed
                views.enterButton.layer.borderColor = Color.brandRed.cgColor
                views.enterButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            }
        } else {
            [authView, profileWithoutAuthView].forEach { views in
                views.enterButton.backgroundColor = Color.brandGray
                views.enterButton.layer.borderColor = Color.brandGray.cgColor
                views.enterButton.removeTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            }
        }
        return false
    }
}
