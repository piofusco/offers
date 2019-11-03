//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockSelectableDelegate: Selectable {
    var lastSelectedOfferId = ""
    var numberOfDidSelectOfferInvocations = 0
    func didSelectOffer(offer: Offer) {
        lastSelectedOfferId = offer.id
        numberOfDidSelectOfferInvocations += 1
    }
}