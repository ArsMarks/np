//
//  ProfileWithoutAuthView.swift
//  NP
//
//  Created by Рушан Киньягулов on 05.01.2022.
//

import UIKit
import SnapKit

class ProfileWithoutAuthView: AuthorizationView {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Авторизуйтесь для доступа ко всем функциям: презентации проектов, избранное и многое другое."
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        setupOverrides()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        [enterLabel, descriptionLabel, phoneLabel, phoneTextField, phoneDescriptionLabel, enterButton].forEach { views in
            self.addSubview(views)
        }
    }
    
    private func setupOverrides() {
        enterLabel.text = "Добро пожаловать"
        enterLabel.font = .boldSystemFont(ofSize: 26)
    }
    
    override func setupConstraints() {
        enterLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(enterLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }

        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(40)
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
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
    }
}
