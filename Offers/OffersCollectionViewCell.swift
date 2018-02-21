//
// Created by gideon on 2/2/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit

class OffersCollectionViewCell: UICollectionViewCell {
    private var imageBackDrop = UIView()
    var imageView = UIImageView()

    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var favoritedLabel = UILabel()

    var nameLabelText: String? {
        set {
            nameLabel.text = newValue
        }
        get {
            return nameLabel.text
        }
    }

    var descriptionLabelText: String? {
        set {
            descriptionLabel.text = newValue
        }
        get {
            return descriptionLabel.text
        }
    }

    var favoritedLabelText: String? {
        set {
            favoritedLabel.text = newValue
        }
        get {
            return favoritedLabel.text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.purple

        imageBackDrop.backgroundColor = Colors.gray.color()
        imageBackDrop.layer.cornerRadius = 5
        addSubview(imageBackDrop)
        imageBackDrop.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing)
            make.leading.equalTo(contentView.snp.leading)

            make.width.equalTo(contentView.bounds.width)
            make.height.equalTo(contentView.bounds.width * 3 / 5)
        }

        imageView = UIImageView(image: UIImage(named: "MockProduct"))
        imageBackDrop.addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imageBackDrop.snp.top).offset(6)
            make.right.equalTo(imageBackDrop.snp.right).inset(6)
            make.bottom.equalTo(imageBackDrop.snp.bottom).inset(6)
            make.left.equalTo(imageBackDrop.snp.left).offset(6)
        }
        imageView.contentMode = .scaleAspectFit

        nameLabel.text = "$1.00 cash back"
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView.snp.leading).inset(8)
            make.top.equalTo(imageBackDrop.snp.bottom).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).inset(8)
        }

        descriptionLabel.text = "Description"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 11)
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView.snp.leading).inset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.trailing.equalTo(contentView.snp.trailing).inset(8)
            make.bottom.equalTo(contentView.snp.bottom).inset(24)
        }

        favoritedLabel.isHidden = true
        favoritedLabel.text = "FAVORITED"
        favoritedLabel.numberOfLines = 0
        favoritedLabel.font = UIFont(name: "AvenirNext-Regular", size: 11)
        addSubview(favoritedLabel)
        favoritedLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView.snp.leading).inset(8)
            make.top.equalTo(descriptionLabel.snp.top).offset(5)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func favoriteCell() {
        favoritedLabel.isHidden = false
    }

    func unfavoriteCell() {
        favoritedLabel.isHidden = true
    }
}