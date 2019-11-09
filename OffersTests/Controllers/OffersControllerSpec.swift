//
//  OffersViewControllerSpec.swift
//  OffersTests
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import XCTest
import UIKit

import Quick

@testable import Offers

class OffersControllerSpec: QuickSpec {
    override func spec() {
        describe("OffersController") {
            describe("loadView") {
                it("offers service shoud call get offers") {
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
                    let mockMainCoordinator = MockCoordinator(
                        navigationController: UINavigationController(),
                        offersService: MockOffersService()
                    )
                    subject.delegate = mockMainCoordinator

                    subject.didSelectOffer(offer: expectedOffer)

                    XCTAssertEqual(mockMainCoordinator.numberOfViewOfferInvocations, 1)
                    XCTAssertEqual(mockMainCoordinator.lastViewedOfferId, expectedId)
                }
            }
        }
    }
}
