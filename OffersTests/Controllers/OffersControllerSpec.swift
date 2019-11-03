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

class OffersControllerSpec: QuickSpec {
    override func spec() {
        describe("OffersController") {
            describe("loadView") {
                it("should assign primary view to be an OffersView and call elements on services") {
                    let mockOffersService = MockOffersService()
                    let subject = OffersController(offersService: mockOffersService)

                    subject.loadView()

                    XCTAssertEqual(mockOffersService.numberOfGetOfferInvocations, 1)
                }
            }

            describe("Selectable") {
                it("should call viewOffer on coordinator with corresponding offer") {
                    let expectedId = "expected id"
                    let expectedOffer = Offer(
                        id: expectedId,
                        name: "",
                        url: "",
                        description: "",
                        terms: "",
                        currentValue: ""
                    )
                    let subject = OffersController(offersService: MockOffersService())
                    let mockMainCoordinator = MockMainCoordinator(
                        navigationController: UINavigationController(),
                        offersService: MockOffersService()
                    )
                    subject.coordinator = mockMainCoordinator

                    subject.didSelectOffer(offer: expectedOffer)

                    XCTAssertEqual(mockMainCoordinator.numberOfViewOfferInvocations, 1)
                    XCTAssertEqual(mockMainCoordinator.lastViewedOfferId, expectedId)
                }
            }
        }
    }
}
