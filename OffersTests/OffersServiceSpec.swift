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

        beforeEach {
            subject = OffersServiceImplementation()
        }

        describe("OffersService") {
            describe("getOffers") {
                it("should return Offers read in from memory") {
                    expect(subject.getOffers().count).to(equal(132))
                }
            }

            describe("toggleFavoriteOffer") {
                it("given id for an existing offer, should find that offer and update favorited to be true") {
                    subject.toggleFavoriteOffer(forId: "110579")

                    expect(subject.getOffer(forId: "110579")).notTo(beNil())
                    expect(subject.getOffer(forId: "110579")!.favorited).to(beTrue())

                    subject.toggleFavoriteOffer(forId: "110579")

                    expect(subject.getOffer(forId: "110579")).notTo(beNil())
                    expect(subject.getOffer(forId: "110579")!.favorited).to(beFalse())
                }
            }

            describe("getOffer") {
                it("given an id that is not associated to an existing offer, should return nil") {
                    expect(subject.getOffer(forId: "Bob Sagat")).to(beNil())
                }
            }
        }
    }
}
