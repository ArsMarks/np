//
//  ReserveFormViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 21.12.2021.
//

import UIKit
import SnapKit
import Firebase

class ReserveFormViewController: UIViewController {
    
    let reserveFormView = ReserveFormView()
    
    private var flatID = ""
    
    init(flatID: String, title: String) {
        super.init(nibName: nil, bundle: nil)
        self.flatID = flatID
        if title == "Заказать обратный звонок" {
            reserveFormView.button.setTitle("Перезвонить", for: .normal)
        } else {
            reserveFormView.button.setTitle("Записаться", for: .normal)
        }
        reserveFormView.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = reserveFormView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        [reserveFormView.phoneTextField, reserveFormView.nameTextField, reserveFormView.commentTextField].forEach { fields in
            fields.delegate = self
        }
        reserveFormView.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [reserveFormView.nameTextField, reserveFormView.phoneTextField, reserveFormView.commentTextField].forEach { fields in
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0, y: fields.frame.size.height - 1.0, width: fields.frame.size.width, height: 0.5)
            bottomLine.backgroundColor = Color.brandGray.cgColor
            fields.borderStyle = .none
            fields.layer.addSublayer(bottomLine)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func setupData() {
        if let phoneNumber = Auth.auth().currentUser?.phoneNumber {
            let authVC = AuthorizationViewController()
            reserveFormView.phoneTextField.text = authVC.format(with: "+X (XXX) XXX-XX-XX", phone: phoneNumber)
            reserveFormView.nameTextField.text = Auth.auth().currentUser?.displayName
        }
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                let authVC = AuthorizationViewController()
//                guard let phoneNumber = auth.currentUser?.phoneNumber else { return }
//                self.reserveFormView.phoneTextField.text = authVC.format(with: "+X (XXX) XXX-XX-XX", phone: phoneNumber)
//                guard let userName = auth.currentUser?.displayName else { return }
//                self.reserveFormView.nameTextField.text = userName
//            }
//        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let name = reserveFormView.nameTextField.text?.replacingOccurrences(of: " ", with: "_") ?? ""
        let phone = reserveFormView.phoneTextField.text?.replacingOccurrences(of: " ", with: "") ?? ""
        let comment = reserveFormView.commentTextField.text?.replacingOccurrences(of: " ", with: "_") ?? ""
        if name.count >= 2 && phone.count == 16 {
            sendEmail(name: name, phone: phone, comment: comment)
        } else if name.count < 2 && phone.count < 16 {
            showAlert(message: "Введите имя и телефон")
        } else if name.count < 2 {
            showAlert(message: "Введите имя")
        } else {
            showAlert(message: "Введите телефон")
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func sendEmail(name: String, phone: String, comment: String) {
        let body = "\(flatID),name_\(name),phone_\(phone),comment_\(comment)"
        EmailSender.sendEmail(body: body)
    }
}
