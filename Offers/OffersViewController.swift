//
//  OffersViewController.swift
//  Offers
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import SnapKit
import UIKit

class OffersViewController: UIViewController {

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.2, height: UIScreen.main.bounds.width / 2)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(OffersCollectionViewCell.self, forCellWithReuseIdentifier: "offerCell")
        collectionView.backgroundColor = UIColor.blue

        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(self.view.bounds.height)
            make.width.equalTo(self.view.bounds.width)
        }

    }
}

extension OffersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell",
                                                      for: indexPath) as! OffersCollectionViewCell

        
            cell.backgroundColor = UIColor.magenta
            cell.accessibilityIdentifier = "offerCell-\(indexPath.row)"

            return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
