//
// Created by gideon on 11/8/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import XCTest

import Quick

@testable import Offers

class OffersDataStoreServiceSpec: QuickSpec {
    override func spec() {
        describe("OffersServiceDataStore") {
            var subject: OffersDataStoreService<MockDataStore>!
            var mockDataStore: MockDataStore!

            beforeEach {
                mockDataStore = MockDataStore()
                subject = OffersDataStoreService(dataStore: mockDataStore)
            }

            describe("getOffers") {
                it("data store should return retrieve all offers") {
                    let _ = subject.getOffers()

                    XCTAssertEqual(mockDataStore.numberOfElementsInvocations, 1)
                }
            }

            describe("toggleFavoriteOffer") {
                it("given id for an existing offer, data store should retrieve/update element with matching id and trigger callback") {
                    let expectedOffer = Offer(id: "110579", name: "", url: "", description: "", terms: "", currentValue: "")
                    mockDataStore.stubbedElement = expectedOffer
                    var didCallUpdateOffer = false
                    var lastUpdatedOffer: Offer? = nil
                    subject.didUpdateOffer = { offer in
                        didCallUpdateOffer = true
                        lastUpdatedOffer = offer
                    }

                    subject.toggleFavoriteOffer(forId: "110579")

                    XCTAssertTrue(didCallUpdateOffer)
                    XCTAssertEqual(lastUpdatedOffer!.id, expectedOffer.id)
                    XCTAssertEqual(mockDataStore.numberOfElementInvocations, 1)
                    XCTAssertEqual(mockDataStore.numberOfUpdateInvocations, 1)
                    XCTAssertEqual(mockDataStore.lastUpdatedElementId, expectedOffer.id)
                }
            }

            describe("getOffer") {
                it("given an id that is not associated to an existing offer, should return nil") {
                    let offer = subject.getOffer(forId: "Bob Sagat")

                    XCTAssertNil(offer)
                    XCTAssertEqual(mockDataStore.numberOfElementInvocations, 1)
                    XCTAssertEqual(mockDataStore.lastElementId, "Bob Sagat")
                }

                it("given an existing id, data store should return corresponding offer") {
                    mockDataStore.stubbedElement = Offer(id: "Ted Bundy", name: "", url: "", description: "", terms: "", currentValue: "")

                    let offer = subject.getOffer(forId: "Ted Bundy")

                    XCTAssertEqual(offer!.id, "Ted Bundy")
                    XCTAssertEqual(mockDataStore.numberOfElementInvocations, 1)
                    XCTAssertEqual(mockDataStore.lastElementId, "Ted Bundy")
                }
            }
        }
    }
}