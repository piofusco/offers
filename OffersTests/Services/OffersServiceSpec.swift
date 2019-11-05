//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import XCTest

import Quick

@testable import Offers

class OffersServiceSpec: QuickSpec {
    override func spec() {
        var subject: OffersServiceImplementation<MockDataStore>!
        var mockDataStore: MockDataStore!

        beforeEach {
            mockDataStore = MockDataStore()
            subject = OffersServiceImplementation(dataStore: mockDataStore)
        }

        describe("OffersService") {
            describe("getOffers") {
                it("data store should return retrieve all offers") {
                    let _ = subject.getOffers()

                    XCTAssertEqual(mockDataStore.numberOfElementsInvocations, 1)
                }
            }

            describe("toggleFavoriteOffer") {
                it("given id for an existing offer, data store should retrieve/update element with matching id") {
                    mockDataStore.stubbedElement = Offer(id: "110579", name: "", url: "", description: "", terms: "", currentValue: "")

                    subject.toggleFavoriteOffer(forId: "110579")

                    XCTAssertEqual(mockDataStore.numberOfElementInvocations, 1)
                    XCTAssertEqual(mockDataStore.numberOfUpdateInvocations, 1)
                    XCTAssertEqual(mockDataStore.lastUpdatedElementId, "110579")
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
