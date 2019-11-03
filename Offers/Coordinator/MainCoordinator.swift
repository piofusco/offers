//
// Created by gideon on 10/30/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator, Favoritable {
    internal var navigationController: UINavigationController
    internal var offersService: OffersService

    init(
        navigationController: UINavigationController,
        offersService: OffersService
    ) {
        self.navigationController = navigationController
        self.offersService = offersService
    }

    func start() {
        let vc = OffersController(offersService: offersService)
        vc.navigationItem.title = "Offers"
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func viewOffer(offer: Offer) {
        let vc = OfferDetailController(offer: offer)
        vc.navigationItem.title = "Offer Detail"
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func didFavoriteOffer(withId id: String) {
        offersService.toggleFavoriteOffer(forId: id)
    }
}
