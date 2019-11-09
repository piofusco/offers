//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

import SnapKit

protocol Favoritable: class {
    func didFavoriteOffer(withId id: String)
}

class OfferDetailView: UIView {
    private let tableView = UITableView(frame: CGRect.zero)

    weak var delegate: Favoritable?
    private let offer: Offer
    init(offer: Offer) {
        self.offer = offer

        super.init(frame: CGRect.zero)

        setupTableView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}

extension OfferDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: OfferDetailTableViewCell.self),
            for: indexPath) as? OfferDetailTableViewCell else {
            fatalError("tableView(cellForRowAt:) could not dequeue cell")
        }

        switch indexPath.row {
            case 0: cell.setContent(forLabel: "Name", forValue: offer.name)
            case 1: cell.setContent(forLabel: "Description", forValue: offer.description)
            case 2: cell.setContent(forLabel: "Terms", forValue: offer.terms)
            case 3: cell.setContent(forLabel: "Current value", forValue: offer.currentValue)
            default: break
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: OfferDetailHeaderView.self)
        ) as? OfferDetailHeaderView else {
            fatalError("tableView(viewForHeaderInSection:) could not dequeue header")
        }

        header.setupForURL(url: offer.url)
        header.setupFavoritedButton(isFavorited: offer.favorited)
        header.favoriteButton.addTarget(
            self,
            action: #selector(OfferDetailView.favoriteButtonTapped),
            for: .touchUpInside
        )
        return header
    }
}

extension OfferDetailView {
    @objc func favoriteButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.didFavoriteOffer(withId: offer.id)
    }
}

extension OfferDetailView {
    private func setupTableView() {
        backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.register(
            OfferDetailHeaderView.self,
            forHeaderFooterViewReuseIdentifier: String(describing: OfferDetailHeaderView.self)
        )
        tableView.register(
            OfferDetailTableViewCell.self,
            forCellReuseIdentifier: String(describing: OfferDetailTableViewCell.self)
        )
        tableView.rowHeight = UITableView.automaticDimension

        addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp.leading)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
