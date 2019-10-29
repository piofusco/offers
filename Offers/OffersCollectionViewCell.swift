//
// Created by gideon on 2/2/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit
import Kingfisher

class OffersCollectionViewCell: UICollectionViewCell {
    private var imageBackDrop: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray.color()
        view.layer.cornerRadius = 5
        return view
    }()
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "$1.00 cash back"
        label.font = Fonts.demiBold.font(withSize: 12)
        label.textColor = Colors.darkGray.color()
        return label
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "AvenirNext-Regular", size: 11)
        label.textColor = Colors.darkGray.color()
        return label
    }()

    private var favoritedLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "FAVORITED"
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Regular", size: 30)
        label.textColor = UIColor.red
        label.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 4);
        return label
    }()

    var valueLabelText: String? {
        set {
            valueLabel.text = newValue
        }
        get {
            valueLabel.text
        }
    }

    var nameLabelText: String? {
        set {
            nameLabel.text = newValue
        }
        get {
            nameLabel.text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        contentView.addSubview(imageBackDrop)
        imageBackDrop.addSubview(imageView)
        contentView.addSubview(valueLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoritedLabel)
    }

    private func setupConstraints() {
        imageBackDrop.snp.makeConstraints { (make) -> Void in
            make.top.trailing.leading.equalTo(contentView)
            make.width.equalTo(contentView)
            make.height.equalTo(contentView.bounds.width * 3 / 5)
        }

        imageView.snp.makeConstraints { (make) -> Void in
            make.top.left.equalTo(imageBackDrop).offset(6)
            make.right.bottom.equalTo(imageBackDrop).inset(6)
        }

        valueLabel.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(imageBackDrop.snp.bottom).offset(8)
        }

        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(valueLabel.snp.bottom).offset(3)
            make.leading.trailing.equalTo(contentView)
        }

        favoritedLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OffersCollectionViewCell {
    func configureFor(offer: Offer) {
        valueLabelText = offer.currentValue
        nameLabelText = offer.name
        favoritedLabel.isHidden = !offer.favorited

        if let urlString = offer.url, let url = URL(string: urlString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
    }
}