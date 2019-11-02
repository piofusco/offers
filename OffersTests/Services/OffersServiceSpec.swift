//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Quick
import Nimble

@testable import Offers

class OffersServiceSpec: QuickSpec {
    override func spec() {
        var subject: OffersServiceImplementation!
        var mockDataStore: MockDataStore!

        beforeEach {
            mockDataStore = MockDataStore()
            subject = OffersServiceImplementation(dataStore: mockDataStore)
        }

        describe("OffersService") {
            describe("getOffers") {
                it("data store should return retrieve all offers") {
                    let _ = subject.getOffers()

                    expect(mockDataStore.numberOfElementsInvocations).to(equal(1))
                }
            }

            describe("toggleFavoriteOffer") {
                it("given id for an existing offer, data store should retrieve/update element with matching id") {
                    mockDataStore.stubbedElement = Offer(id: "110579", name: "", url: "", description: "", terms: "", currentValue: "")

                    subject.toggleFavoriteOffer(forId: "110579")

                    expect(mockDataStore.numberOfElementInvocations).to(equal(1))
                    expect(mockDataStore.numberOfUpdateInvocations).to(equal(1))
                    expect(mockDataStore.lastUpdatedElementId).to(equal("110579"))
                }
            }

            describe("getOffer") {
                it("given an id that is not associated to an existing offer, should return nil") {
                    let offer = subject.getOffer(forId: "Bob Sagat")

                    expect(offer).to(beNil())
                    expect(mockDataStore.numberOfElementInvocations).to(equal(1))
                    expect(mockDataStore.lastElementId).to(equal("Bob Sagat"))
                }

                it("given an existing id, data store should return corresponding offer") {
                    mockDataStore.stubbedElement = Offer(id: "Ted Bundy", name: "", url: "", description: "", terms: "", currentValue: "")

                    let offer = subject.getOffer(forId: "Ted Bundy")

                    expect(offer!.id).to(equal("Ted Bundy"))
                    expect(mockDataStore.numberOfElementInvocations).to(equal(1))
                    expect(mockDataStore.lastElementId).to(equal("Ted Bundy"))
                }
            }
        }
    }
}
