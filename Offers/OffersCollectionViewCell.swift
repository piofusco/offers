//
// Created by gideon on 2/2/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit

class OffersCollectionViewCell: UICollectionViewCell {
    var imageBackDrop: UIView = UIView()
    var imageView: UIImageView = UIImageView()
    var nameLabel: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.green

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

        nameLabel.text = "$1.00 cash back"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imageBackDrop.snp.bottom).offset(8)
        }

        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont.systemFont(ofSize: 11)
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom).inset(24)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}