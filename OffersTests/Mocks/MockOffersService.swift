//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockOffersService: OffersService {
    var numberOfGetOfferInvocations = 0
    var stubbedOffers: [Offer] = []
    func getOffers() -> [Offer] {
        numberOfGetOfferInvocations += 1

        return stubbedOffers
    }

    func getOffer(forId id: String) -> Offer? {
        fatalError("getOffer(forId:) has not been implemented")
    }

    var numberOfToggleFavoriteOfferInvocations = 0
    var lastToggledOffer = ""
    func toggleFavoriteOffer(forId id: String) {
        lastToggledOffer = id
        numberOfToggleFavoriteOfferInvocations += 1
    }
}