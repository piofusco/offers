//
//  OffersViewController.swift
//  Offers
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit
import Freddy
import Kingfisher

class OffersViewController: UIViewController, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    private var offers = [] as [Offer]

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        let margin = CGFloat(12)
        let interimItemSpacing = CGFloat(8)
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        let width = (UIScreen.main.bounds.width - (margin * 2) - interimItemSpacing) / 2
        let height = width * 0.85
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = interimItemSpacing
        layout.minimumLineSpacing = 24

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: "offerCell")
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white

        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.trailing.bottom.leading.equalTo(self.view)
            make.width.height.equalTo(self.view)
        }

        if let path = Bundle.main.path(forResource: "offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON(data: data)
                offers = try json.getArray().map(Offer.init)
                collectionView.reloadData()
            } catch {
                print("Uh oh")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
                    -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell",
                                                      for: indexPath) as! OffersCollectionViewCell

        cell.accessibilityIdentifier = "offerCell-\(indexPath.row)"
        cell.valueLabelText = offers[indexPath.row].currentValue
        cell.nameLabelText = offers[indexPath.row].name
        if offers[indexPath.row].favorited {
            cell.favoriteCell()
        } else {
            cell.unfavoriteCell()
        }

        if let urlString = offers[indexPath.row].url, let url = URL(string: urlString) {
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: url)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension OffersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.delegate = self
        detailViewController.offer = offers[indexPath.row]
        detailViewController.navigationItem.title = "Offer \(indexPath.row + 1)"

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension OffersViewController: Favoritable {
    func offerFavoritedWasToggled() {
        if let selectedOfferIndex = self.collectionView.indexPathsForSelectedItems?[0].row {
            offers[selectedOfferIndex].favorited = !offers[selectedOfferIndex].favorited
            collectionView.reloadData()
        }
    }
}
