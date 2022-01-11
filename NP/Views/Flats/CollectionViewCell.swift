//
//  CollectionViewCell.swift
//  NP
//
//  Created by Рушан Киньягулов on 17.12.2021.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(image)
        
        image.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalToSuperview()
        }
    }
}
