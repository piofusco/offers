//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

import SnapKit
import Kingfisher

class OfferDetailHeaderView: UITableViewHeaderFooterView {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.favorited.image, for: .normal)
        button.setImage(Images.favoritedFilled.image, for: .selected)
        button.accessibilityIdentifier = "FavoriteButton"
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(imageView)
        addSubview(favoriteButton)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp.leading).inset(10)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.bottom.equalTo(self.snp.bottom).inset(10)
        }

        favoriteButton.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(imageView.snp.trailing).inset(10)
            make.bottom.equalTo(imageView.snp.bottom).inset(10)
            make.width.height.equalTo(45)
        }
    }
}

extension OfferDetailHeaderView {
    func setupForURL(url: String?) {
        if let urlString = url, let url = URL(string: urlString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
    }

    func setupFavoritedButton(isFavorited: Bool) {
        favoriteButton.isSelected = isFavorited
    }
}