//
//  OffersViewControllerSpec.swift
//  OffersTests
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import Quick
import Nimble

@testable import Offers

class OffersViewControllerSpec: QuickSpec {
    override func spec() {
        describe("OffersViewController") {
            describe("viewDidLoad") {
                it("offers service should retrieve offers and update data source") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let mockOffersService = MockOffersService()
                    let subject = OffersViewController(offersService: mockOffersService)
                    window.rootViewController = subject

                    subject.view.layoutSubviews()

                    expect(mockOffersService.getOffersWasCalled).to(beTrue())
                }
            }

            describe("UICollectionViewDataSource") {
                it("numberOfSections") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let mockOffersService = MockOffersService()
                    let subject = OffersViewController(offersService: mockOffersService)
                    window.rootViewController = subject

                    subject.view.layoutSubviews()

                    expect(subject.numberOfSections(in: subject.collectionView!)).to(equal(1))
                }

                it("numberOfItemsInSection should return number offers retrieved from offers service") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let mockOffersService = MockOffersService()
                    mockOffersService.stubbedOffers = [
                        Offer(name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(name: "", url: "", description: "", terms: "", currentValue: "")
                    ]
                    let subject = OffersViewController(offersService: mockOffersService)
                    window.rootViewController = subject

                    subject.view.layoutSubviews()

                    expect(subject.collectionView(subject.collectionView!, numberOfItemsInSection: 0)).to(equal(4))
                }
            }
        }
    }
}
