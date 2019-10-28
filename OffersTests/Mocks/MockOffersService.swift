//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockOffersService: OffersService {
    var getOffersWasCalled = false

    var stubbedOffers: [Offer] = []

    func getOffers() -> [Offer] {
        getOffersWasCalled = true

        return stubbedOffers
    }
}