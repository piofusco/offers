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
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private var termsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private var currentValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var favoriteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = "Favorited"
        return label
    }()

    private var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.favorited.image, for: .normal)
        button.setImage(Images.favoritedFilled.image, for: .selected)
        return button
    }()

    private var offer: Offer
    weak var coordinator: MainCoordinator?

    init(offer: Offer) {
        self.offer = offer

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupForOffer()

        favoriteButton.addTarget(
            self,
            action: #selector(OfferDetailViewController.favoriteButtonTapped),
            for: .touchUpInside
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}

extension OfferDetailViewController {
    @objc func favoriteButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        coordinator?.didFavoriteOffer(withId: offer.id)
    }
}

extension OfferDetailViewController {
    private func setupForOffer() {
        nameLabel.text = "Name: \(offer.name)"
        descriptionLabel.text = "Description: \(offer.description)"
        termsLabel.text = "Terms: \(offer.terms)"
        currentValueLabel.text = "Current value: \(offer.currentValue)"
        favoriteButton.isSelected = offer.favorited
        favoriteButton.accessibilityIdentifier = "FavoriteButton"
        if let urlString = offer.url, let url = URL(string: urlString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
    }
}

extension OfferDetailViewController {
    private func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(termsLabel)
        view.addSubview(currentValueLabel)
        view.addSubview(favoriteLabel)
        view.addSubview(favoriteButton)
        view.addSubview(imageView)
    }

    private func setupConstraints() {
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        descriptionLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        termsLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        currentValueLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.termsLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        favoriteLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.currentValueLabel.snp.bottom).offset(20)
        }

        favoriteButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(favoriteLabel.snp.centerY)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.favoriteLabel.snp.bottom).offset(20)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.height.equalTo(self.view.snp.width).offset(30)
        }
    }
}