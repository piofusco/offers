//
//  OffersViewController.swift
//  Offers
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit

class OffersViewController: UIViewController, UICollectionViewDataSource {
    private let offersService: OffersService

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
    var collectionView: UICollectionView!

    init(offersService: OffersService) {
        self.offersService = offersService

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupContraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
            -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell",
                                                      for: indexPath) as! OffersCollectionViewCell

        cell.accessibilityIdentifier = "offerCell-\(indexPath.row)"
        cell.configureFor(offer: offersService.getOffers()[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        offersService.getOffers().count
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}

extension OffersViewController {
    private func setupViews() {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: "offerCell")
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white

        self.view.addSubview(collectionView)
    }

    private func setupContraints() {
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.trailing.bottom.leading.equalTo(self.view)
            make.width.height.equalTo(self.view)
        }
    }
}

extension OffersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOffer = offersService.getOffers()[indexPath.row]
        let detailViewController = OfferDetailViewController(offer: selectedOffer)
        detailViewController.delegate = self
        detailViewController.navigationItem.title = "Offer \(indexPath.row + 1)"

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension OffersViewController: Favoritable {
    func didFavoriteOffer(withId id: String) {
        if let _ = self.collectionView.indexPathsForSelectedItems?[0].row {
            offersService.toggleFavoriteOffer(forId: id)
        }
    }
}
