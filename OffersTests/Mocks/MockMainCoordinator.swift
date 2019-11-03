//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockMainCoordinator: MainCoordinator {
    var lastViewedOfferId = ""
    var numberOfViewOfferInvocations = 0
    override func viewOffer(offer: Offer) {
        lastViewedOfferId = offer.id
        numberOfViewOfferInvocations += 1
    }
}
