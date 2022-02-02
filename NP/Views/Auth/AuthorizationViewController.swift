//
//  AuthorizationViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 27.11.2021.
//

import UIKit
import SnapKit

class AuthorizationViewController: UIViewController {

    let authView = AuthorizationView()
    let profileWithoutAuthView = ProfileWithoutAuthView()
    let firebaseAuth = FirebaseAuth()

    var phoneNumber = String()

    override func loadView() {
        super.loadView()
        view = authView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogo()
        setupObservers()
        setupPhoneTextFieldToolbar()
        authView.phoneTextField.delegate = self
    }

    override func viewDidLayoutSubviews() {
        [authView, profileWithoutAuthView].forEach { views in
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0,
                                      y: views.phoneTextField.frame.size.height - 1.0,
                                      width: views.phoneTextField.frame.size.width,
                                      height: 1.0)
            bottomLine.backgroundColor = UIColor.red.cgColor
            views.phoneTextField.borderStyle = .none
            views.phoneTextField.layer.addSublayer(bottomLine)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    private func setupLogo() {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        switch traitCollection.userInterfaceStyle {
        case .dark: authView.companyLogo.image = UIImage(named: "Logo_dark")
        default: authView.companyLogo.image = UIImage(named: "Logo_light")
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            switch traitCollection.userInterfaceStyle {
            case .dark: authView.companyLogo.image = UIImage(named: "Logo_dark")
            case .light: authView.companyLogo.image = UIImage(named: "Logo_light")
            default: authView.companyLogo.image = UIImage(named: "Logo_light")
            }
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
        authView.phoneTextField.inputAccessoryView = toolbar
    }

    @objc func doneClicked() {
        self.view.endEditing(true)
    }

    public func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for characters in mask where index < numbers.endIndex {
            if characters == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(characters)
            }
        }
        return result
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextField(notification:)),
                                               name: UIResponder.keyboardDidChangeFrameNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextField(notification:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        authView.enterSkipLabel.addGestureRecognizer(tapGesture)
        authView.enterSkipLabel.isUserInteractionEnabled = true
    }

    @objc func updateTextField(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]
                                   as? NSValue)?.cgRectValue else { return }

        if notification.name == UIResponder.keyboardDidHideNotification {
            UIView.animate(withDuration: 0.03) {
                self.authView.enterLabel.alpha = 1.0
                self.authView.enterDescriptionLabel.alpha = 1.0
                self.authView.companyLogo.alpha = 1.0
            }

            authView.phoneLabel.snp.remakeConstraints { make in
                make.top.equalTo(authView.enterDescriptionLabel.snp.bottom).offset(60)
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            }

            authView.enterSkipLabel.snp.remakeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
                make.centerX.equalToSuperview()
            }
        } else {
            UIView.animate(withDuration: 0.03) {
                self.authView.enterLabel.alpha = 0.0
                self.authView.enterDescriptionLabel.alpha = 0.0
                self.authView.companyLogo.alpha = 0.0
            }

            authView.phoneLabel.snp.remakeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            }

            authView.enterSkipLabel.snp.remakeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-1 * (keyboardFrame.height))
                make.centerX.equalToSuperview()
            }
        }
    }

    @objc func buttonAction(sender: UIButton!) {

        if ((authView.phoneTextField.text?.isEmpty) != nil) {
            phoneNumber = authView.phoneTextField.text ?? ""
        } else if (profileWithoutAuthView.phoneTextField.text?.isEmpty) != nil {
            phoneNumber = profileWithoutAuthView.phoneTextField.text ?? ""
        } else {
            return
        }

        firebaseAuth.authWithNumber(phoneNumber: phoneNumber) { [weak self] (completion: Result<String, Error>) in
            switch completion {
            case .success(let verifyId):
                UserDefaults.standard.set(verifyId, forKey: "verificationID")
                self?.present(SMSVerificationViewController(), animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        let tabbarVC = TabBarController()
        tabbarVC.modalPresentationStyle = .fullScreen
        tabbarVC.modalTransitionStyle = .crossDissolve
        present(tabbarVC, animated: true)
    }
}
