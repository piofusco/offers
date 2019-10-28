//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockOffersService: OffersService {
    var getOffersWasCalled = false
    var getOffersNumberOfCalls = 0
    var stubbedOffers: [Offer] = []
    func getOffers() -> [Offer] {
        getOffersWasCalled = true
        getOffersNumberOfCalls += 1

        return stubbedOffers
    }

    func getOffer(forId id: String) -> Offer? {
        fatalError("getOffer(forId:) has not been implemented")
    }

    var favoriteOfferWasCalled = false
    var lastFavoritedOfferId = ""

    func toggleFavoriteOffer(forId id: String) {
        favoriteOfferWasCalled = true
        lastFavoritedOfferId = id
    }
}