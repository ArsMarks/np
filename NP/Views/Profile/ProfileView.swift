//
//  ProfileView.swift
//  NP
//
//  Created by Рушан Киньягулов on 05.01.2022.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваше имя"
        label.textColor = Color.brandGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.textColor = Color.brandGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let nameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите имя"
        field.keyboardType = .default
        field.returnKeyType = .done
        return field
    }()
    
    let phoneTextField: UITextField = {
        let field = UITextField()
        field.isUserInteractionEnabled = false
        return field
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = Color.brandGray
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.brandGray.cgColor
        return button
    }()
    
    let signOutRightButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "Выход"
        item.style = .plain
        return item
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
        [nameLabel, nameTextField, phoneLabel, phoneTextField, saveButton].forEach { subview in
            self.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(0)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(0)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
    }
}
