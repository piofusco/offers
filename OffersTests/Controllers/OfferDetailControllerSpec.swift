//
//  OffersViewControllerSpec.swift
//  OffersTests
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import XCTest

import Quick

@testable import Offers

class OfferDetailControllerSpec: QuickSpec {
    override func spec() {
        describe("OfferDetailViewController") {
            describe("favoriting an offer") {
                it("should call didFavoriteOffer on coordinator with offer id") {
                    let expectedId = "some id"
                    let subject = OfferDetailController(
                        offer: Offer(
                            id: expectedId,
                            name: "",
                            url: "",
                            description: "",
                            terms: "",
                            currentValue: ""
                        )
                    )
                    let mockCoordinator = MockCoordinator()
                    subject.delegate = mockCoordinator

                    subject.didFavoriteOffer(withId: expectedId)

                    XCTAssertEqual(mockCoordinator.lastFavoritedId, expectedId)
                }
            }
        }
    }
}
