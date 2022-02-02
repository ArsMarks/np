//
//  SMSVerificationViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 07.12.2021.
//

import UIKit
import Firebase

class SMSVerificationViewController: UIViewController {

    let smsVerificationView = SMSVerificationView()
    let firebaseAuth = FirebaseAuth()

    override func loadView() {
        super.loadView()
        view = smsVerificationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        smsVerificationView.smsCodeTextField.becomeFirstResponder()
        smsVerificationView.smsCodeTextField.delegate = self
    }

    override func viewDidLayoutSubviews() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0,
                                  y: smsVerificationView.smsCodeTextField.frame.size.height - 2.0,
                                  width: smsVerificationView.smsCodeTextField.frame.size.width,
                                  height: 1.0)
        bottomLine.backgroundColor = UIColor.red.cgColor
        smsVerificationView.smsCodeTextField.borderStyle = .none
        smsVerificationView.smsCodeTextField.layer.addSublayer(bottomLine)
    }

    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Введен неверный код", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc func buttonAction(sender: UIButton!) {
        guard let smsCode = smsVerificationView.smsCodeTextField.text else { return }
        guard let verifyID = UserDefaults.standard.string(forKey: "verificationID") else { return }

        firebaseAuth.checkSms(smsCode: smsCode, verifyID: verifyID) { [weak self] (completion: Result<AnyObject?, Error>) in
            switch completion {
            case .failure:
                self?.showAlert()
            case .success:
                let tabbarVC = TabBarController()
                tabbarVC.modalPresentationStyle = .fullScreen
                self?.present(tabbarVC, animated: true)
            }
        }
    }
}
