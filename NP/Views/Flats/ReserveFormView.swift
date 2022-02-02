//
//  ReserveFormView.swift
//  NP
//
//  Created by Рушан Киньягулов on 06.01.2022.
//

import UIKit
import SnapKit

class ReserveFormView: UIView {

    private let lineView: UIView = {
        let lineView = UIView()
        lineView.layer.borderWidth = 5.0
        lineView.layer.borderColor = Color.brandGray.cgColor
        lineView.layer.cornerRadius = 3
        return lineView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    let nameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Ваше имя"
        field.returnKeyType = .done
        return field
    }()

    let phoneTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Ваш телефон"
        field.returnKeyType = .done
        field.textContentType = .telephoneNumber
        field.keyboardType = .numberPad
        return field
    }()

    let commentTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Комментарий"
        field.returnKeyType = .done
        return field
    }()

    let button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.brandRed.cgColor
        button.backgroundColor = Color.brandRed
        button.setTitleColor(.white, for: .normal)
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
        [lineView, titleLabel, nameTextField, phoneTextField, commentTextField, button].forEach { views in
            addSubview(views)
        }
    }

    private func setupConstraints() {
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(5)
            make.width.equalTo(45)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(commentTextField.snp.bottom).offset(30)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }

        commentTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(45)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
