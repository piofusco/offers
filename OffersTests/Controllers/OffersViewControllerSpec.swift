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

class OffersViewControllerSpec: QuickSpec {
    override func spec() {
        describe("OffersViewController") {
            describe("UICollectionViewDataSource") {
                it("numberOfItemsInSection should return number offers retrieved from the OffersService") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let mockOffersService = MockOffersService()
                    mockOffersService.stubbedOffers = [
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: "")
                    ]
                    let subject = OffersViewController(offersService: mockOffersService)
                    window.rootViewController = subject

                    subject.view.layoutSubviews()

                    expect(subject.collectionView(subject.collectionView!, numberOfItemsInSection: 0)).to(equal(4))
                }
            }

            describe("selecting an offer cell") {
                it("navigation controller should push a DetailViewController with the offer from the OffersService") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let mockOffersService = MockOffersService()
                    mockOffersService.stubbedOffers = [
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: "")
                    ]
                    let subject = OffersViewController(offersService: mockOffersService)
                    window.rootViewController = subject
                    subject.view.layoutSubviews()

                    subject.collectionView(subject.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))

                    expect(mockOffersService.didGetOffers).to(beTrue())
                }
            }
        }
    }
}
