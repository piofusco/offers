//
//  OffersViewControllerSpec.swift
//  OffersTests
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import UIKit

import Quick
import Nimble

@testable import Offers

class OffersControllerSpec: QuickSpec {
    override func spec() {
        describe("OffersController") {
            describe("loadView") {
                it("should assign primary view to be an OffersView and call elements on services") {
                    let mockOffersService = MockOffersService()
                    let subject = OffersController(offersService: mockOffersService)

                    subject.loadView()

                    expect(mockOffersService.numberOfGetOfferInvocations).to(equal(1))
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

                    expect(mockMainCoordinator.numberOfViewOfferInvocations).to(equal(1))
                    expect(mockMainCoordinator.lastViewedOfferId).to(equal(expectedId))
                }
            }
        }
    }
}

class MockOffersView: OffersView {

}

class MockUICollectionView: UICollectionView {
    var numberOfReloadDataInvocations = 0
    override func reloadData() {
        numberOfReloadDataInvocations += 1
    }
}
