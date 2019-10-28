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

        describe("Offers Service") {
            describe("getOffers") {
                it("should read from offers.json and return an array of Offers") {
                    let offers = subject.getOffers()

                    expect(offers.count).to(equal(132))
                }
            }
        }
    }
}
