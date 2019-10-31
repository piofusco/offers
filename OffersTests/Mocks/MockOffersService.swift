//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockOffersService: OffersService {
    var didGetOffers = false
    var getOffersNumberOfCalls = 0
    var stubbedOffers: [Offer] = []

    func getOffers() -> [Offer] {
        didGetOffers = true
        getOffersNumberOfCalls += 1

        return stubbedOffers
    }

    func getOffer(forId id: String) -> Offer? {
        fatalError("getOffer(forId:) has not been implemented")
    }

    var didToggleFavoriteOffer = false
    var lastToggledOffer = ""

    func toggleFavoriteOffer(forId id: String) {
        didToggleFavoriteOffer = true
        lastToggledOffer = id
    }
}