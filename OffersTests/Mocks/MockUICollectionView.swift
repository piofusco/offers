//
// Created by gideon on 11/5/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

class MockCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    var numberOfReloadDataInvocations = 0
    var lastReloadedIndexPaths = [IndexPath]()
    override func reloadItems(at indexPaths: [IndexPath]) {
        numberOfReloadDataInvocations += 1
        lastReloadedIndexPaths.append(contentsOf: indexPaths)
    }
}