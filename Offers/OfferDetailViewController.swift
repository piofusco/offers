//
// Created by gideon on 2/10/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit
import Kingfisher

protocol Favoritable {
    func didFavoriteOffer(withId id: String)
}

class OfferDetailViewController: UIViewController {
    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var termsLabel = UILabel()
    private var currentValueLabel = UILabel()
    private var imageView = UIImageView()
    private var favoriteLabel = UILabel()
    private var favoriteSwitch = UISwitch()

    var delegate: Favoritable?
    private var offer: Offer

    init(offer: Offer) {
        self.offer = offer

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        nameLabel.text = "Name: \(offer.name)"
        descriptionLabel.text = "Description: \(offer.description)"
        termsLabel.text = "Terms: \(offer.terms)"
        currentValueLabel.text = "Current value: \(offer.currentValue)"
        favoriteSwitch.isOn = offer.favorited
        if let urlString = offer.url, let url = URL(string: urlString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }

        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.numberOfLines = 0
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        termsLabel.font = UIFont.systemFont(ofSize: 15)
        termsLabel.numberOfLines = 0
        view.addSubview(termsLabel)
        termsLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        currentValueLabel.font = UIFont.systemFont(ofSize: 15)
        currentValueLabel.numberOfLines = 0
        view.addSubview(currentValueLabel)
        currentValueLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.termsLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        favoriteLabel.font = UIFont.systemFont(ofSize: 15)
        favoriteLabel.numberOfLines = 0
        favoriteLabel.text = "Favorited"
        view.addSubview(favoriteLabel)
        favoriteLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.currentValueLabel.snp.bottom).offset(20)
        }

        favoriteSwitch.isUserInteractionEnabled = true
        favoriteSwitch.addTarget(
            self,
            action: #selector(OfferDetailViewController.favoriteSwitchHasChanged),
            for: .valueChanged
        )
        view.addSubview(favoriteSwitch)
        favoriteSwitch.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(favoriteLabel.snp.centerY)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.favoriteLabel.snp.bottom).offset(20)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.height.equalTo(self.view.snp.width).offset(30)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    @objc func favoriteSwitchHasChanged() {
        delegate?.didFavoriteOffer(withId: offer.id)
    }
}
