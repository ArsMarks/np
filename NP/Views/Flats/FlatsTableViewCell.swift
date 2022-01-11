//
//  FlatsTableViewCell.swift
//  NP
//
//  Created by Рушан Киньягулов on 16.12.2021.
//

import UIKit
import SnapKit

class FlatsTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let squareTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Площадь:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandGray
        return label
    }()
    
    private let floorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Этаж:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandGray
        return label
    }()
    
    private let roomsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Комнат:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandGray
        return label
    }()
    
    private let squareLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let floorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let roomsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = Color.brandRed
        return label
    }()
    
    private let pricePerMeterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = Color.brandGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        [titleLabel, squareTitleLabel, floorTitleLabel, roomsTitleLabel, squareLabel, floorLabel, roomsLabel, priceLabel, pricePerMeterLabel].forEach { views in
            contentView.addSubview(views)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(15)
            make.leading.equalTo(self.contentView).offset(15)
        }
        
        squareTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.contentView).offset(15)
        }
        
        floorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(squareTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.contentView).offset(15)
        }
        
        roomsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(floorTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.contentView).offset(15)
            make.bottom.equalTo(self.contentView).offset(-15)
        }
        
        squareLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.contentView).offset(85)
        }
        
        floorLabel.snp.makeConstraints { make in
            make.top.equalTo(squareTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.contentView).offset(85)
        }
        
        roomsLabel.snp.makeConstraints { make in
            make.top.equalTo(floorTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.contentView).offset(85)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.equalTo(self.contentView).offset(-15)
        }
        
        pricePerMeterLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.contentView).offset(-15)
        }
        
    }
    
    public func setupFlatsInfo(rooms: Int, square: Float, floor: Int, price: Int, pricePerMeter: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ru_RU")
        guard let formattedPrice = formatter.string(from: price as NSNumber) else { return }
        guard let formattedPricePerMeter = formatter.string(from: pricePerMeter as NSNumber) else { return }
        if rooms == 1 {
            titleLabel.text = "Квартира с 1-ой спальней"
        } else if rooms == 2 || rooms == 3 || rooms == 4 {
            titleLabel.text = "Квартира с \(rooms)-мя спальнями"
        } else {
            titleLabel.text = "Квартира с \(rooms)-ю спальнями"
        }
        squareLabel.text = String(square) + " м²"
        floorLabel.text = String(floor)
        roomsLabel.text = String(rooms)
        priceLabel.text = formattedPrice.replacingOccurrences(of: ",00", with: "")
        pricePerMeterLabel.text = formattedPricePerMeter.replacingOccurrences(of: ",00", with: "") + " за м²"
    }
}
