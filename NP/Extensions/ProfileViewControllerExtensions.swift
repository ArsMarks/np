//
//  ProfileViewControllerExtensions.swift
//  NP
//
//  Created by Рушан Киньягулов on 04.01.2022.
//

import UIKit

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if profileView.nameTextField.text != nil {
            profileView.saveButton.backgroundColor = Color.brandRed
            profileView.saveButton.layer.borderColor = Color.brandRed.cgColor
            profileView.saveButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        } else {
            profileView.saveButton.backgroundColor = Color.brandGray
            profileView.saveButton.layer.borderColor = Color.brandGray.cgColor
            profileView.saveButton.removeTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
