//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import XCTest
import UIKit

import Quick

@testable import Offers

class OffersViewSpec: QuickSpec {
    override func spec() {
        describe("OffersView") {
            describe("OffersView") {
                it("updateOffer should reload collection view") {
                    let expectedOffer = Offer(id: "this one", name: "", url: "", description: "", terms: "", currentValue: "")
                    let offers = [
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        expectedOffer
                    ]
                    let subject = OffersViewImplementation(offers: offers)
                    let mockCollectionView = MockCollectionView()
                    subject.collectionView = mockCollectionView

                    subject.updateOffer(offer: expectedOffer)

                    XCTAssertEqual(mockCollectionView.numberOfReloadDataInvocations, 1)
                    XCTAssertEqual(mockCollectionView.lastReloadedIndexPaths[0], IndexPath(row: 3, section: 0))
                }
            }

            describe("UICollectionViewDataSource") {
                it("numberOfItemsInSection should return number offers passed in") {
                    let offers = [
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: "")
                    ]
                    let subject = OffersViewImplementation(offers: offers)

                    XCTAssertEqual(subject.collectionView(subject.collectionView!, numberOfItemsInSection: 0), 4)
                }
            }

            describe("selecting an offer cell") {
                it("should call didSelectOfferAt on delegate with ") {
                    let expectedId = "expected id"
                    let offers = [
                        Offer(id: expectedId, name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: "")
                    ]
                    let subject = OffersViewImplementation(offers: offers)
                    let mockDelegate = MockSelectableDelegate()
                    subject.delegate = mockDelegate

                    subject.collectionView(subject.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))

                    XCTAssertEqual(mockDelegate.numberOfDidSelectOfferInvocations, 1)
                    XCTAssertEqual(mockDelegate.lastSelectedOfferId, expectedId)
                }
            }
        }
    }
}
