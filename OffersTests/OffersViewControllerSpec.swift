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

                    expect(mockOffersService.getOffersWasCalled).to(beTrue())
                }
            }

            describe("favoriting an offer") {
                it("should call the OffersService to update the corresponding offer and reload the collection view") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let mockOffersService = MockOffersService()
                    let expectedOfferId = "should be this one"
                    mockOffersService.stubbedOffers = [
                        Offer(id: expectedOfferId, name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                        Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: "")
                    ]
                    let subject = OffersViewController(offersService: mockOffersService)
                    window.rootViewController = subject
                    subject.view.layoutSubviews()

                    subject.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .bottom)
                    subject.didFavoriteOffer(withId: expectedOfferId)

                    expect(mockOffersService.favoriteOfferWasCalled).to(beTrue())
                    expect(mockOffersService.lastFavoritedOfferId).to(equal(expectedOfferId))
                }
            }
        }
    }
}
