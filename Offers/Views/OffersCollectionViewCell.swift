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
        label.font = Fonts.demiBold.font(withSize: 12)
        label.textColor = Colors.darkGray.color()
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 11)
        label.textColor = Colors.darkGray.color()
        return label
    }()

    private var favoritedIcon: UIImageView = {
        let image = UIImageView(image: Images.favoritedFilled.image, highlightedImage: Images.favorited.image)
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OffersCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(imageBackDrop)
        imageBackDrop.addSubview(imageView)
        contentView.addSubview(valueLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(favoritedIcon)
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
            make.leading.equalTo(contentView)
            make.top.equalTo(imageBackDrop.snp.bottom).offset(8)
        }

        favoritedIcon.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView)
            make.center.equalTo(valueLabel.snp.center)
            make.height.width.equalTo(15)
        }

        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(valueLabel.snp.bottom).offset(3)
            make.leading.trailing.equalTo(contentView)
        }
    }
}

extension OffersCollectionViewCell {
    func configureFor(offer: Offer) {
        valueLabel.text = offer.currentValue
        descriptionLabel.text = offer.name
        favoritedIcon.isHighlighted = !offer.favorited

        if let urlString = offer.url, let url = URL(string: urlString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
    }
}