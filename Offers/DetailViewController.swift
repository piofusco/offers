//
// Created by gideon on 2/10/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit

protocol Favoritable {
    func offerFavoritedWasToggled()
}

class DetailViewController: UIViewController {

    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    var termsLabel = UILabel()
    var currentValueLabel = UILabel()

    var image = UIImageView()
    var favoriteLabel = UILabel()
    var favoriteSwitch = UISwitch()

    var delegate: Favoritable?
    var offer: Offer?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        if let offer = offer {
            nameLabel.text = "Name: \(offer.name)"
            descriptionLabel.text = "Description: \(offer.description)"
            termsLabel.text = "Terms: \(offer.terms)"
            currentValueLabel.text = "Current value: \(offer.currentValue)"
            favoriteSwitch.isOn = offer.favorited
        } else {
            nameLabel.text = "Name NA"
            descriptionLabel.text = "Description NA"
            termsLabel.text = "Terms NA"
            currentValueLabel.text = "Currentvalue NA"
        }

        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.numberOfLines = 0
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.top.equalTo(self.view.snp.top).inset(76)
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
        favoriteSwitch.addTarget(self, action: #selector(DetailViewController.favoriteSwitchHasChanged),
                                 for: .valueChanged)
        view.addSubview(favoriteSwitch)
        favoriteSwitch.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(favoriteLabel.snp.centerY)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
        }

        image.backgroundColor = UIColor.gray
        view.addSubview(image)
        image.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.favoriteLabel.snp.bottom).offset(20)
            make.trailing.equalTo(self.view.snp.trailing).inset(10)
            make.leading.equalTo(self.view.snp.leading).inset(10)
            make.bottom.equalTo(self.view.snp.bottom).inset(10)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = false
    }

    @objc func favoriteSwitchHasChanged() {
        delegate!.offerFavoritedWasToggled()
    }
}
