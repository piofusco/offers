//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import XCTest

import Quick

@testable import Offers

class OfferDetailViewSpec: QuickSpec {
    override func spec() {
        describe("OfferDetailView") {
            describe("favoriting an offer") {
                it("should call didFavoriteOffer on delegate with offer id") {
                    let expectedId = "some id"
                    let offer = Offer(id: expectedId, name: "", url: "", description: "", terms: "", currentValue: "")
                    let subject = OfferDetailView(offer: offer)
                    let mockFavoritableDelegate = MockFavoritable()
                    subject.delegate = mockFavoritableDelegate

                    subject.favoriteButtonTapped(sender: UIButton())

                    XCTAssertEqual(mockFavoritableDelegate.lastFavoritedId, expectedId)
                }
            }
        }
    }
}