//
//  OffersViewControllerSpec.swift
//  OffersTests
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import Quick
import Nimble

@testable import Offers

class OfferDetailViewControllerSpec: QuickSpec {
    override func spec() {
        describe("OfferDetailViewController") {
            describe("favoriting an offer") {
                it("should call didFavoriteOffer on coordinator with offer id") {
                    let expectedId = "some id"
                    let subject = OfferDetailViewController(
                        offer: Offer(
                            id: expectedId,
                            name: "",
                            url: "",
                            description: "",
                            terms: "",
                            currentValue: ""
                        )
                    )
                    let mockCoordinator = MockFavoriatable()
                    subject.coordinator = mockCoordinator

                    subject.didFavoriteOffer(withId: expectedId)

                    expect(mockCoordinator.lastFavoritedId).to(equal(expectedId))
                }
            }
        }
    }
}
