//
// Created by gideon on 10/30/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

import Quick
import Nimble

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
                    expect(lastPushedVC).to(beAnInstanceOf(OffersViewController.self))
                    let offersViewController = lastPushedVC as! OffersViewController
                    expect(offersViewController.coordinator).to(be(subject))
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
                    expect(lastPushedVC).to(beAnInstanceOf(OfferDetailViewController.self))
                    let offersViewController = lastPushedVC as! OfferDetailViewController
                    expect(offersViewController.coordinator).to(be(subject))
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

                        expect(mockOffersService.numberOfToggleFavoriteOfferInvocations).to(equal(1))
                        expect(mockOffersService.lastToggledOffer).to(equal("some id"))
                    }
                }
            }
        }
    }
}