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
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 16, height: UIScreen.main.bounds.width / 2)

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: "offerCell")
        collectionView.backgroundColor = UIColor.green
        collectionView.delegate = self

        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp.top)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
            make.leading.equalTo(self.view.snp.leading)

            make.height.equalTo(self.view.bounds.height)
            make.width.equalTo(self.view.bounds.width)
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

        cell.backgroundColor = UIColor.magenta
        cell.accessibilityIdentifier = "offerCell-\(indexPath.row)"
        cell.descriptionLabelText = offers[indexPath.row].description
        cell.nameLabelText = offers[indexPath.row].name
        if offers[indexPath.row].favorited {
            cell.favoriteCell()
        } else {
            cell.unfavoriteCell()
        }

        if let urlString = offers[indexPath.row].url {
            if let url = URL(string: urlString) {
                cell.imageView.kf.setImage(with: url)
            }
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
