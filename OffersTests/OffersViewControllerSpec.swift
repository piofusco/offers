//
//  OffersViewControllerSpec.swift
//  OffersTests
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import XCTest

import Quick
import Nimble

@testable import Offers

class OffersTests: QuickSpec {
    override func spec() {
        describe("OffersViewController"){
            describe("UICollectionViewDataSource") {
                it("numberOfSections") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let subject = OffersViewController()
                    window.rootViewController = subject

                    subject.view.layoutSubviews()

                    expect(subject.numberOfSections(in: subject.collectionView!)).to(equal(1))
                }

                it("numberOfItemsInSection") {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    let subject = OffersViewController()
                    window.rootViewController = subject

                    subject.view.layoutSubviews()

                    expect(subject.collectionView(subject.collectionView!, numberOfItemsInSection: 0)).to(equal(8))
                }
            }
        }
    }
}
