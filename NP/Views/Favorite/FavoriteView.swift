//
//  FavoriteView.swift
//  NP
//
//  Created by Рушан Киньягулов on 05.01.2022.
//

import UIKit
import SnapKit

class FavoriteView: UIView {

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "В избранном пока нет объектов, но вы можете добавить их"
        label.textAlignment = .center
        return label
    }()

    let flatsTableView = UITableView()

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
        self.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
        }
    }
}
