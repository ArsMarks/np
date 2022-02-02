//
//  ProfileViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 01.12.2021.
//

import UIKit
import SnapKit
import Firebase

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
    let firebaseAuth = FirebaseAuth()

    override func loadView() {
        super.loadView()
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Профиль"
        navigationItem.rightBarButtonItem = profileView.signOutRightButton
        profileView.signOutRightButton.action = #selector(rightButtonAction)
        navigationItem.rightBarButtonItem?.target = self
        setupPhoneTextFieldToolbar()
        setupName()
        setupPhonePlaceholder()
        profileView.nameTextField.delegate = self
    }

    override func viewDidLayoutSubviews() {
        [profileView.nameTextField, profileView.phoneTextField].forEach { field in
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0,
                                      y: field.frame.size.height - 1.0,
                                      width: field.frame.size.width,
                                      height: 1.0)
            bottomLine.backgroundColor = UIColor.red.cgColor
            field.borderStyle = .none
            field.layer.addSublayer(bottomLine)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    @objc func doneClicked() {
        self.view.endEditing(true)
    }

    private func setupName() {
        firebaseAuth.getDisplayName { [weak self] name in
            self?.profileView.nameTextField.text = name
        }
    }

    func setupPhoneTextFieldToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        profileView.phoneTextField.inputAccessoryView = toolbar
    }

    private func setupPhonePlaceholder() {
        guard let phoneNumber = Auth.auth().currentUser?.phoneNumber else { return }
        let authVC = AuthorizationViewController()
        profileView.phoneTextField.text = authVC.format(with: "+X (XXX) XXX-XX-XX", phone: phoneNumber)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc func buttonAction(sender: UIButton!) {
        guard let name = profileView.nameTextField.text else { return }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: { error in
            if error != nil {
                self.showAlert(title: "Ошибка", message: "Не удалось сохранить данные")
            } else {
                self.setupName()
                self.showAlert(title: "Готово", message:"Данные сохранены")
            }
        })
    }

    @objc func rightButtonAction(sender: UIBarButtonItem!) {
        let firebaseAuth = Auth.auth()
        let authVC = AuthorizationViewController()
        authVC.modalTransitionStyle = .flipHorizontal
        authVC.modalPresentationStyle = .fullScreen
        do {
            try firebaseAuth.signOut()
            present(authVC, animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
