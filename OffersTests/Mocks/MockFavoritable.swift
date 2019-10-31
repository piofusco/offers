//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

@testable import Offers

class MockFavoriatable: MainCoordinator {
    init() {
        super.init(navigationController: UINavigationController(), offersService: MockOffersService())
    }

    var lastFavoritedId = ""

    override func didFavoriteOffer(withId id: String) {
        lastFavoritedId = id
    }
}