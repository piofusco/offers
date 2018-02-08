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

class OffersViewController: UIViewController, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    private var offers = [] as [Offer]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.2, height: UIScreen.main.bounds.width / 2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: "offerCell")
        collectionView.backgroundColor = UIColor.blue

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

            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell",
                                                      for: indexPath) as! OffersCollectionViewCell

        cell.backgroundColor = UIColor.magenta
        cell.accessibilityIdentifier = "offerCell-\(indexPath.row)"
        cell.descriptionLabel.text = offers[indexPath.row].description
        cell.nameLabel.text = offers[indexPath.row].name

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}