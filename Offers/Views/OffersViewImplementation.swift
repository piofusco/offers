//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

import SnapKit

protocol Selectable: class {
    func didSelectOffer(offer: Offer)
}

protocol OffersView: class {
    func updateOffer(offer: Offer)
}

class OffersViewImplementation: UIView {
    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let margin = CGFloat(12)
        let interimItemSpacing = CGFloat(8)

        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        let width = (UIScreen.main.bounds.width - (margin * 2) - interimItemSpacing) / 2
        let height = width * 0.85
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = interimItemSpacing
        layout.minimumLineSpacing = 24

        return layout
    }()

    weak var delegate: Selectable?
    var collectionView: UICollectionView!
    private var offers: [Offer]
    init(offers: [Offer]) {
        self.offers = offers

        super.init(frame: CGRect.zero)

        setupViews()
        setupContraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}

extension OffersViewImplementation: OffersView {
    func updateOffer(offer: Offer) {
        guard let index = self.offers.firstIndex(where: { $0.id == offer.id }) else {
            return
        }

        offers[index] = offer
        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
}

extension OffersViewImplementation {
    private func setupViews() {
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: "offerCell")

        self.addSubview(collectionView)
    }

    private func setupContraints() {
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.trailing.bottom.leading.equalTo(self)
            make.width.height.equalTo(self)
        }
    }
}

extension OffersViewImplementation: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
            -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell",
                                                      for: indexPath) as! OffersCollectionViewCell

        cell.accessibilityIdentifier = "offerCell-\(indexPath.row)"
        cell.configureFor(offer: offers[indexPath.row])
        cell.isSelected = false
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        offers.count
    }
}

extension OffersViewImplementation: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOffer = offers[indexPath.row]
        delegate?.didSelectOffer(offer: selectedOffer)
    }
}