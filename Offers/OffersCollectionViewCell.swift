//
// Created by gideon on 2/2/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit

class OffersCollectionViewCell: UICollectionViewCell {
    private var imageBackDrop = UIView()
    var imageView = UIImageView()

    private var valueLabel = UILabel()
    private var nameLabel = UILabel()
    private var favoritedLabel = UILabel()

    var valueLabelText: String? {
        set {
            valueLabel.text = newValue
        }
        get {
            return valueLabel.text
        }
    }

    var nameLabelText: String? {
        set {
            nameLabel.text = newValue
        }
        get {
            return nameLabel.text
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

        imageBackDrop.backgroundColor = Colors.gray.color()
        imageBackDrop.layer.cornerRadius = 5
        contentView.addSubview(imageBackDrop)
        imageBackDrop.snp.makeConstraints { (make) -> Void in
            make.top.trailing.leading.equalTo(contentView)

            make.width.equalTo(contentView)
            make.height.equalTo(contentView.bounds.width * 3 / 5)
        }

        imageBackDrop.addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.left.equalTo(imageBackDrop).offset(6)
            make.right.bottom.equalTo(imageBackDrop).inset(6)
        }
        imageView.contentMode = .scaleAspectFit

        valueLabel.text = "$1.00 cash back"
        valueLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        valueLabel.textColor = Colors.darkGray.color()
        contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(imageBackDrop.snp.bottom).offset(8)
        }

        nameLabel.text = "Description"
        nameLabel.font = UIFont(name: "AvenirNext-Regular", size: 11)
        nameLabel.textColor = Colors.darkGray.color()
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(valueLabel.snp.bottom).offset(3)
            make.leading.trailing.equalTo(contentView)
        }

        favoritedLabel.isHidden = true
        favoritedLabel.text = "FAVORITED"
        favoritedLabel.numberOfLines = 0
        favoritedLabel.font = UIFont(name: "AvenirNext-Regular", size: 30)
        favoritedLabel.textColor = UIColor.red
        contentView.addSubview(favoritedLabel)
        favoritedLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(contentView)
        }
        favoritedLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 4);
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