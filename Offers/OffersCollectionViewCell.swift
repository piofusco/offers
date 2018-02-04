//
// Created by gideon on 2/2/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

import SnapKit

class OffersCollectionViewCell: UICollectionViewCell {
    func OffersCollectionCell() -> UICollectionViewCell {
        let collectionViewCell = UICollectionViewCell()

        let imageView = UIImageView(image: UIImage(named: "MockProduct"))
        imageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(self.contentView.bounds.height)
            make.width.equalTo(self.contentView.bounds.width)
        }

        contentView.backgroundColor = UIColor.gray
        

        return collectionViewCell
    }
}