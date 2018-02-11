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
        XCTAssertTrue(collectionCell1.staticTexts["Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges"].exists)
        XCTAssertTrue(collectionCell1.staticTexts["Any variety - 2 ct. pack or larger"].exists)
        collectionCell1.tap()

        XCTAssertTrue(application.navigationBars["Offer 1"].exists)
        XCTAssertTrue(application.staticTexts["Name: Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges"].exists)
        XCTAssertTrue(application.staticTexts["Description: Any variety - 2 ct. pack or larger"].exists)
        XCTAssertTrue(application.staticTexts["Terms: Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges " +
                "for any variety, 2 ct. pack or larger."].exists)
        XCTAssertTrue(application.staticTexts["Current value: $0.75 Cash Back"].exists)

        let offerOneFavoritedSwitch = application.switches.element(boundBy: 0)
        XCTAssertTrue(offerOneFavoritedSwitch.exists)
        var offerOneIsFavorited = (offerOneFavoritedSwitch.value as! String).toBool()
        XCTAssertFalse(offerOneIsFavorited)

        offerOneFavoritedSwitch.tap()
        application.buttons["Back"].tap()

        collectionCell1.tap()
        offerOneIsFavorited = (offerOneFavoritedSwitch.value as! String).toBool()
        XCTAssertTrue(offerOneIsFavorited)
        application.buttons["Back"].tap()

        let collectionCell2 = application.collectionViews.cells["offerCell-1"]
        XCTAssertTrue(collectionCell2.exists)
        XCTAssertTrue(collectionCell2.staticTexts["Scotch-Brite® Scrub Dots Heavy Duty Scrub Sponges"].exists)
        XCTAssertTrue(collectionCell2.staticTexts["Any variety - 2 ct. pack or larger"].exists)
        collectionCell2.tap()

        XCTAssertTrue(application.navigationBars["Offer 2"].exists)
        XCTAssertTrue(application.staticTexts["Name: Scotch-Brite® Scrub Dots Heavy Duty Scrub Sponges"].exists)
        XCTAssertTrue(application.staticTexts["Description: Any variety - 2 ct. pack or larger"].exists)
        XCTAssertTrue(application.staticTexts["Terms: Rebate valid on Scotch-Brite® Scrub Dots Heavy Duty Scrub Sponges for " +
                "any variety, 2 ct. pack or larger."].exists)
        XCTAssertTrue(application.staticTexts["Current value: $0.75 Cash Back"].exists)

        let offerTwoFavoritedSwitch = application.switches.element(boundBy: 0)
        XCTAssertTrue(offerTwoFavoritedSwitch.exists)
        var offerTwoIsFavorited = (offerTwoFavoritedSwitch.value as! String).toBool()
        XCTAssertFalse(offerTwoIsFavorited)

        offerTwoFavoritedSwitch.tap()
        application.buttons["Back"].tap()

        collectionCell1.tap()
        offerTwoIsFavorited = (offerTwoFavoritedSwitch.value as! String).toBool()
        XCTAssertTrue(offerTwoIsFavorited)
    }
}

extension String {
    func toBool() -> Bool {
        switch self {
            case "True", "true", "yes", "1": return true
            case "False", "false", "no", "0": return false
            default: return false
        }
    }
}
