//
//  FlatReserveViews.swift
//  NP
//
//  Created by Рушан Киньягулов on 05.01.2022.
//

import UIKit
import SnapKit

class FlatReserveView: UIView {
    
    let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    let telegramButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Написать в Telegram", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    let whatsAppButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Написать в WhatsApp", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    let registrationForViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Записаться на просмотр", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    let callBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Заказать обратный звонок", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Color.brandGray
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let lineView: UIView = {
        let lineView = UIView()
        lineView.layer.borderWidth = 5.0
        lineView.layer.borderColor = Color.brandGray.cgColor
        lineView.layer.cornerRadius = 3
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        [lineView, callButton, telegramButton, whatsAppButton, registrationForViewButton, callBackButton, cancelButton].forEach { views in
            addSubview(views)
        }
    }
    
    private func setupConstraints() {
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(45)
            make.height.equalTo(5)
        }
        
        callButton.snp.makeConstraints { make in
            make.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.bottom.equalTo(telegramButton.snp.top)
        }

        telegramButton.snp.makeConstraints { make in
            make.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.bottom.equalTo(whatsAppButton.snp.top)
        }

        whatsAppButton.snp.makeConstraints { make in
            make.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.bottom.equalTo(registrationForViewButton.snp.top)
        }

        registrationForViewButton.snp.makeConstraints { make in
            make.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.bottom.equalTo(callBackButton.snp.top)
        }

        callBackButton.snp.makeConstraints { make in
            make.top.equalTo(registrationForViewButton.snp.bottom)
            make.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.bottom.equalTo(cancelButton.snp.top).offset(-20)
        }

        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
        }
    }
    
    func setupButtons() {
        let buttons = [callButton, telegramButton, whatsAppButton, registrationForViewButton, callBackButton]
        buttons.forEach { buttons in
            let topLine = CALayer()
            topLine.frame = CGRect(x: 0.0, y: 1.0, width: UIScreen.main.bounds.width, height: 0.5)
            topLine.backgroundColor = Color.brandGray.cgColor
            buttons.layer.addSublayer(topLine)
        }
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 50, width: UIScreen.main.bounds.width, height: 0.5)
        bottomLine.backgroundColor = Color.brandGray.cgColor
        callBackButton.layer.addSublayer(bottomLine)
    }
}
