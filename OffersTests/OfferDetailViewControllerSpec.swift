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

class OfferDetailViewControllerSpec: QuickSpec {
    override func spec() {
        describe("OfferDetailViewController") {
            describe("favoriting an offer") {
                it("should call delegate with offer id") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let expetedId = "some id"
                    let subject = OfferDetailViewController(
                        offer: Offer(
                            id: expetedId,
                            name: "",
                            url: "",
                            description: "",
                            terms: "",
                            currentValue: ""
                        )
                    )
                    let mockFavoritableDelegate = MockFavoriatable()
                    subject.delegate = mockFavoritableDelegate
                    window.rootViewController = subject
                    subject.view.layoutSubviews()

                    subject.favoriteButtonTapped(sender: UIButton())

                    expect(mockFavoritableDelegate.lastFavoritedId).to(equal(expetedId))
                }
            }
        }
    }
}
