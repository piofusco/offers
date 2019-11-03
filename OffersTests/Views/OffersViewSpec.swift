//
// Created by gideon on 11/2/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Quick
import XCTest

@testable import Offers

class OffersViewSpec: QuickSpec {
    override func spec() {
        describe("OffersView") {
            describe("UICollectionViewDataSource") {
                it("numberOfItemsInSection should return number offers passed in") {
                    let offers = [
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: "")
                    ]
                    let subject = OffersView(offers: offers)

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
                    let subject = OffersView(offers: offers)
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
