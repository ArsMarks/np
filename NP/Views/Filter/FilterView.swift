//
//  FilterView.swift
//  NP
//
//  Created by Рушан Киньягулов on 05.01.2022.
//

import UIKit
import SnapKit

class FilterView: UIView {

    let clearFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.brandRed
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.brandRed.cgColor
        
        button.setTitle("Сбросить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleEdgeInsets = UIEdgeInsets(top:0, left:10, bottom:0, right:0)
        
        let image = UIImage(systemName: "multiply")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top:0, left:-5, bottom:0, right:0)

        return button
    }()

    let priceView = UIView()
    let squareView = UIView()
    
    let priceTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .decimalPad
        field.textAlignment = .right
        field.placeholder = "223,4"
        field.font = .systemFont(ofSize: 16)
        return field
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена, до"
        label.font = .systemFont(ofSize: 16)
        label.textColor = Color.brandGray
        return label
    }()

    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "млн ₽"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let squareLabel: UILabel = {
        let label = UILabel()
        label.text = "Площадь, от"
        label.font = .systemFont(ofSize: 16)
        label.textColor = Color.brandGray
        return label
    }()
    
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.text = "м²"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let squareTextField: UITextField = {
        let field = UITextField()
        field.keyboardType = .decimalPad
        field.textAlignment = .right
        field.placeholder = "22"
        field.font = .systemFont(ofSize: 16)
        return field
    }()
    
    let roomsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        
        stackView.layer.borderColor = Color.brandGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 3
        return stackView
    }()
    
    let studioRoomButton = UIButton()
    let oneRoomButton = UIButton()
    let twoRoomButton = UIButton()
    let threeRoomButton = UIButton()
    let fourRoomButton = UIButton()
    let fourPlusRoomButton = UIButton()
    
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = Color.brandRed.cgColor
        button.backgroundColor = Color.brandRed
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        setupStackView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        [clearFilterButton, priceView, squareView, roomsStackView, filterButton].forEach { views in
            self.addSubview(views)
        }
        [priceLabel, priceTextField, currencyLabel].forEach { views in
            priceView.addSubview(views)
        }
        [squareLabel, squareTextField, unitLabel].forEach { views in
            squareView.addSubview(views)
        }
    }
    
    private func setupConstraints() {
        clearFilterButton.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(135)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        
        priceView.snp.makeConstraints { make in
            make.top.equalTo(clearFilterButton.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceView)
            make.leading.equalTo(priceView).offset(5)
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceView)
            make.trailing.equalTo(priceView).offset(-5)
        }
        
        priceTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalTo(priceLabel.snp.right)
            make.right.equalTo(currencyLabel.snp.left).offset(-5)
            make.width.equalTo(UIScreen.main.bounds.width - 175)
        }
        
        squareView.snp.makeConstraints { make in
            make.top.equalTo(priceView.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
        
        squareLabel.snp.makeConstraints { make in
            make.centerY.equalTo(squareView)
            make.leading.equalTo(squareView).offset(5)
        }
        
        
        unitLabel.snp.makeConstraints { make in
            make.centerY.equalTo(squareView)
            make.trailing.equalTo(squareView).offset(-5)
        }
        
        squareTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalTo(squareLabel.snp.right)
            make.right.equalTo(unitLabel.snp.left).offset(-5)
            make.width.equalTo(UIScreen.main.bounds.width - 170)
        }
        
        roomsStackView.snp.makeConstraints { make in
            make.top.equalTo(squareView.snp.bottom).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
        
        filterButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
    }
    
    func setupButtons() {
        let titleArray = ["Студия", "1", "2", "3", "4", "    4+    "]
        let buttons = [studioRoomButton, oneRoomButton, twoRoomButton, threeRoomButton, fourRoomButton, fourPlusRoomButton]
        buttons.forEach { button in
            button.setTitleColor(.label, for: .normal)
            button.backgroundColor = .systemBackground
            button.layer.borderWidth = 0.3
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.layer.borderColor = Color.brandGray.cgColor
            roomsStackView.addArrangedSubview(button)
        }

        for (index, button) in buttons.enumerated() {
            button.setTitle(titleArray[index], for: .normal)
            button.tag = index
        }
    }

    func setupStackView() {
        roomsStackView.axis = .horizontal
        roomsStackView.spacing = 0
        roomsStackView.distribution = .fillProportionally
    }
}
