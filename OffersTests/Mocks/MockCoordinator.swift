//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

@testable import Offers

class MockCoordinator: MainCoordinator {
    override init(
        navigationController: UINavigationController = UINavigationController(),
        offersService: OffersService = MockOffersService()
    ) {
        super.init(navigationController: UINavigationController(), offersService: MockOffersService())
    }

    override func start() {
    }

    var lastViewedOfferId = ""
    var numberOfViewOfferInvocations = 0
    override func viewOffer(offer: Offer) {
        lastViewedOfferId = offer.id
        numberOfViewOfferInvocations += 1
    }

    var lastFavoritedId = ""
    override func didFavoriteOffer(withId id: String) {
        lastFavoritedId = id
    }
}
