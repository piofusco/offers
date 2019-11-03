//
// Created by gideon on 10/30/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import XCTest

import Quick

@testable import Offers

class CoordinatorSpec: QuickSpec {
    override func spec() {
        describe("Coordinator") {
            describe("start") {
                it("pushes an OffersViewController onto the navigation controller with subject as coordinator") {
                    let mockNavigationController = MockNavigationController()
                    let subject = MainCoordinator(
                        navigationController: mockNavigationController,
                        offersService: MockOffersService()
                    )

                    subject.start()

                    let lastPushedVC = mockNavigationController.lastPushedVC
                    XCTAssert(lastPushedVC is OffersController)
                    let offersViewController = lastPushedVC as! OffersController
                    XCTAssert(offersViewController.coordinator === subject)
                }
            }

            describe("viewOffer") {
                it("pushes an OfferDetailViewController onto the navigation controller with subject as coordinator") {
                    let mockNavigationController = MockNavigationController()
                    let subject = MainCoordinator(
                        navigationController: mockNavigationController,
                        offersService: MockOffersService()
                    )

                    let offer = Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: "")
                    subject.viewOffer(offer: offer)

                    let lastPushedVC = mockNavigationController.lastPushedVC
                    XCTAssert(lastPushedVC is OfferDetailController)
                    let offersViewController = lastPushedVC as! OfferDetailController
                    XCTAssert(offersViewController.coordinator === subject)
                }
            }

            describe("Favoritable") {
                describe("didFavoriteOffer") {
                    it("didFavoriteOffer should call toggleFavoriteOffer on OffersService") {
                        let mockOffersService = MockOffersService()
                        let subject = MainCoordinator(
                            navigationController: MockNavigationController(),
                            offersService: mockOffersService
                        )

                        subject.didFavoriteOffer(withId: "some id")

                        XCTAssertEqual(mockOffersService.numberOfToggleFavoriteOfferInvocations, 1)
                        XCTAssertEqual(mockOffersService.lastToggledOffer, "some id")
                    }
                }
            }
        }
    }
}