//
//  AuthorizationView.swift
//  NP
//
//  Created by Рушан Киньягулов on 05.01.2022.
//

import UIKit
import SnapKit

class AuthorizationView: UIView {

    let companyLogo = UIImageView()

    let enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Войти"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .label
        return label
    }()

    let enterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизуйтесь для доступа ко всем функциям"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()

    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandGray
        return label
    }()

    let phoneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Получить код для входа в SMS"
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandGray
        return label
    }()

    let phoneTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.placeholder = "+7 (000) 000-00-00"
        field.font = .systemFont(ofSize: 18)
        field.textContentType = .telephoneNumber
        return field
    }()

    let enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.brandGray
        button.setTitle("Запросить код", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.brandGray.cgColor
        return button
    }()

    let enterSkipLabel: UILabel = {
        let label = UILabel()
        label.text = "Пропустить"
        label.textColor = Color.brandGray
        return label
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

    func setupSubviews() {
        [companyLogo,
         enterLabel,
         enterDescriptionLabel,
         phoneLabel,
         phoneTextField,
         phoneDescriptionLabel,
         enterButton,
         enterSkipLabel].forEach { views in
            self.addSubview(views)
        }
    }

    func setupConstraints() {

        companyLogo.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
        }

        enterLabel.snp.makeConstraints { make in
            make.top.equalTo(companyLogo.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }

        enterDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(enterLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
        }

        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(enterDescriptionLabel.snp.bottom).offset(60)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }

        phoneDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
        }

        enterButton.snp.makeConstraints { make in
            make.bottom.equalTo(enterSkipLabel.snp.top).offset(-15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }

        enterSkipLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.centerX.equalToSuperview()
        }
    }
}
