//
//  FlatsView.swift
//  NP
//
//  Created by Рушан Киньягулов on 05.01.2022.
//

import UIKit
import SnapKit

class FlatsView: UIView {

    var photos: [UIImage] = []

    private let scrollView = UIScrollView()

    private let contentView = UIView()

    let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Cell.collectionViewCell)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    let pageContol = UIPageControl()

    let activityIndicator = UIActivityIndicatorView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = Color.brandRed
        return label
    }()

    let pricePerMeterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = Color.brandGray
        return label
    }()

    let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        let color = Color.brandRed

        button.setTitle("В избранное", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(color, for: .normal)

        let image = UIImage(systemName: "star")?.withTintColor(color, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    let propertiesView = UIView()

    private let squareIcon: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(named: "square")
        return photo
    }()

    private let roomsIcon: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(named: "roomsCount")
        return photo
    }()

    private let wcRoomsIcon: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(named: "wcRoomsCount")
        return photo
    }()

    private let squareTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Площадь"
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandGray
        return label
    }()

    private let roomsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Спальни"
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandGray
        return label
    }()

    private let wcRoomsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ванные комнаты"
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandGray
        return label
    }()

    let squareLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Color.brandRed
        return label
    }()

    let roomsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = Color.brandRed
        return label
    }()

    let wcRoomsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = Color.brandRed
        return label
    }()

    let flatDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let reserveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.brandRed
        button.setTitle("Забронировать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.brandRed.cgColor
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        propertiesView.setupSublayers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [squareIcon,
         squareTitleLabel,
         squareLabel,
         roomsIcon,
         roomsTitleLabel,
         roomsLabel,
         wcRoomsIcon,
         wcRoomsTitleLabel,
         wcRoomsLabel].forEach { views in
            propertiesView.addSubview(views)
        }
        [photoCollectionView,
         activityIndicator,
         pageContol,
         titleLabel,
         priceLabel,
         pricePerMeterLabel,
         favoriteButton,
         propertiesView,
         flatDescription,
         reserveButton].forEach { views in
            contentView.addSubview(views)
        }
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.centerX.equalTo(self.snp.centerX)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.centerX.equalTo(scrollView.snp.centerX)
        }

        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.width/1.5)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(photoCollectionView.snp.center)
        }

        pageContol.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(photoCollectionView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pageContol.snp.bottom).offset(15)
            make.leading.equalTo(contentView.snp.leading).offset(15)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
        }

        pricePerMeterLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(15)
        }

        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.height.equalTo(14)
        }

        propertiesView.snp.makeConstraints { make in
            make.top.equalTo(favoriteButton.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.height.equalTo(110)
        }

        squareIcon.snp.makeConstraints { make in
            make.top.equalTo(propertiesView.snp.top).offset(20)
            make.leading.equalTo(propertiesView.snp.leading).offset(50)
        }

        roomsIcon.snp.makeConstraints { make in
            make.top.equalTo(propertiesView.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }

        wcRoomsIcon.snp.makeConstraints { make in
            make.top.equalTo(propertiesView.snp.top).offset(20)
            make.trailing.equalTo(propertiesView.snp.trailing).offset(-50)
        }

        squareLabel.snp.makeConstraints { make in
            make.top.equalTo(roomsIcon.snp.bottom).offset(5)
            make.centerX.equalTo(squareIcon.snp.centerX)
        }

        roomsLabel.snp.makeConstraints { make in
            make.top.equalTo(roomsIcon.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        wcRoomsLabel.snp.makeConstraints { make in
            make.top.equalTo(roomsIcon.snp.bottom).offset(5)
            make.centerX.equalTo(wcRoomsIcon.snp.centerX)
        }

        squareTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(squareLabel.snp.bottom).offset(10)
            make.centerX.equalTo(squareIcon.snp.centerX)
        }

        roomsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(squareLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        wcRoomsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(squareLabel.snp.bottom).offset(10)
            make.centerX.equalTo(wcRoomsIcon.snp.centerX)
        }

        flatDescription.snp.makeConstraints { make in
            make.top.equalTo(propertiesView.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.right.equalTo(contentView.snp.right).offset(-15)
        }

        reserveButton.snp.makeConstraints { make in
            make.top.equalTo(flatDescription.snp.bottom).offset(20)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.height.equalTo(50)
        }
    }
}
