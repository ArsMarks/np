//
//  SMSVerificationView.swift
//  NP
//
//  Created by Рушан Киньягулов on 05.01.2022.
//

import UIKit
import SnapKit

class SMSVerificationView: UIView {

    private let enterSMSCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Для входа в аккаунт введите код из SMS"
        return label
    }()

    let smsCodeTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.placeholder = "123456"
        field.font = .systemFont(ofSize: 18)
        field.textAlignment = .center
        return field
    }()

    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = Color.brandGray
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.brandGray.cgColor
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        [enterSMSCodeLabel, smsCodeTextField, doneButton].forEach { views in
            self.addSubview(views)
        }
    }

    private func setupConstraints() {
        enterSMSCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
        }

        smsCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(enterSMSCodeLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(50)
        }

        doneButton.snp.makeConstraints { make in
            make.top.equalTo(smsCodeTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
        }
    }
}
