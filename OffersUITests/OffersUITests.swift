//
//  OffersUITests.swift
//  OffersUITests
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import XCTest

class OffersUITests: XCTestCase {

    let application = XCUIApplication()

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        application.launch()
    }

    func test_usersCanSeeOffers() {
        let collectionCell1 = application.collectionViews.cells["offerCell-0"]
        XCTAssertTrue(collectionCell1.exists)
        XCTAssertTrue(collectionCell1.staticTexts["$0.75 Cash Back"].exists)
        XCTAssertTrue(collectionCell1.staticTexts["Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges"].exists)
        collectionCell1.tap()

        XCTAssertTrue(application.navigationBars["Offer Detail"].exists)
        XCTAssertTrue(application.staticTexts["Name"].exists)
        XCTAssertTrue(application.staticTexts["Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges"].exists)
        XCTAssertTrue(application.staticTexts["Description"].exists)
        XCTAssertTrue(application.staticTexts["Any variety - 2 ct. pack or larger"].exists)
        XCTAssertTrue(application.staticTexts["Terms"].exists)
        XCTAssertTrue(application.staticTexts["Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger."].exists)
        XCTAssertTrue(application.staticTexts["Current value"].exists)
        XCTAssertTrue(application.staticTexts["$0.75 Cash Back"].exists)

        let offerOneFavoritedButton = application.buttons["FavoriteButton"]
        XCTAssertTrue(offerOneFavoritedButton.exists)
        XCTAssertFalse(offerOneFavoritedButton.isSelected)

        offerOneFavoritedButton.tap()
        offerOneFavoritedButton.tap()
        offerOneFavoritedButton.tap()
        application.buttons["Offers"].tap()

        XCTAssertTrue(collectionCell1.images["FavoritedFilled"].exists)

        collectionCell1.tap()
        XCTAssertTrue(application.buttons["FavoriteButton"].isSelected)

        offerOneFavoritedButton.tap()
        application.buttons["Offers"].tap()

        XCTAssertFalse(collectionCell1.images["Favorited"].exists)

        let collectionCell3 = application.collectionViews.cells["offerCell-2"]
        XCTAssertTrue(collectionCell3.exists)
        XCTAssertTrue(collectionCell3.staticTexts["$0.50 Cash Back"].exists)
        XCTAssertTrue(collectionCell3.staticTexts["Girl Scout Cookie™ Inspired Baking Mix"].exists)
        collectionCell3.tap()

        XCTAssertTrue(application.navigationBars["Offer Detail"].exists)
        XCTAssertTrue(application.staticTexts["Name"].exists)
        XCTAssertTrue(application.staticTexts["Girl Scout Cookie™ Inspired Baking Mix"].exists)
        XCTAssertTrue(application.staticTexts["Description"].exists)
        XCTAssertTrue(application.staticTexts["Any variety - Any size"].exists)
        XCTAssertTrue(application.staticTexts["Terms"].exists)
        XCTAssertTrue(application.staticTexts["Rebate valid on Girl Scout Cookie™ Inspired Baking Mix for any variety, any size."].exists)
        XCTAssertTrue(application.staticTexts["Current value"].exists)
        XCTAssertTrue(application.staticTexts["$0.50 Cash Back"].exists)

        let offerTwoFavoritedButton = application.buttons["FavoriteButton"]
        XCTAssertTrue(offerTwoFavoritedButton.exists)
        XCTAssertFalse(offerTwoFavoritedButton.isSelected)

        offerTwoFavoritedButton.tap()
        application.buttons["Offers"].tap()

        XCTAssertTrue(collectionCell3.images["FavoritedFilled"].exists)
        collectionCell3.tap()
        XCTAssertTrue(offerTwoFavoritedButton.isSelected)
    }
}
