//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import XCTest

import Quick

@testable import Offers

class OffersHTTPServiceSpec: QuickSpec {
    override func spec() {
        describe("OffersHTTPService") {
            describe("getOffers") {
                fit("HTTP client should call get and correctly parse JSON into a list of Offers") {
                    let mockHTTPClient = MockHTTPClient()
                    mockHTTPClient.nextResponse = HTTPURLResponse(
                        url: URL(string: "www.googles.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: [:]
                    )
                    mockHTTPClient.nextData = try! JSONEncoder().encode(
                        [
                            Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                            Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                            Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: ""),
                            Offer(id: "", name: "", url: "", description: "", terms: "", currentValue: "")
                        ])
                    let subject = OffersHTTPService(httpClient: mockHTTPClient)

                    let retrievedOffers = subject.getOffers()

                    XCTAssertEqual(mockHTTPClient.numberOfGetInvocations, 1)
                    XCTAssertEqual(mockHTTPClient.lastURL!.pathComponents[1], "offers")
                    XCTAssertEqual(retrievedOffers.count, 4)
                }

                it("if JSON cannot be parsed Offers returned should be empty") {
                    let mockHTTPClient = MockHTTPClient()
                    mockHTTPClient.nextResponse = HTTPURLResponse(
                        url: URL(string: "www.googles.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: [:]
                    )
                    mockHTTPClient.nextData = Data(base64Encoded: "")
                    let subject = OffersHTTPService(httpClient: mockHTTPClient)

                    let retrievedOffers = subject.getOffers()

                    XCTAssertEqual(mockHTTPClient.numberOfGetInvocations, 1)
                    XCTAssertEqual(retrievedOffers.count, 0)
                }

            }

            describe("getOffer") {
                it("HTTP client should call get offer for given id and correctly parse JSON into an Offer") {
                    let expectedOffer = Offer(id: "expectedId", name: "", url: "", description: "", terms: "", currentValue: "")
                    let mockHTTPClient = MockHTTPClient()
                    mockHTTPClient.nextResponse = HTTPURLResponse(
                        url: URL(string: "www.googles.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: [:]
                    )
                    mockHTTPClient.nextData = try! JSONEncoder().encode(expectedOffer)
                    let subject = OffersHTTPService(httpClient: mockHTTPClient)

                    let retrievedOffer = subject.getOffer(forId: "expectedId")

                    XCTAssertEqual(mockHTTPClient.numberOfGetInvocations, 1)
                    XCTAssertEqual(mockHTTPClient.lastURL!.pathComponents[1], "offers")
                    XCTAssertEqual(mockHTTPClient.lastURL!.pathComponents[2], "expectedId")
                    XCTAssertEqual(mockHTTPClient.lastURL!.pathComponents[3], "offer")
                    XCTAssertEqual(retrievedOffer!.id, expectedOffer.id)
                }

                it("if JSON cannot be parsed Offer returned should be nil") {
                    let mockHTTPClient = MockHTTPClient()
                    mockHTTPClient.nextData = Data(base64Encoded: "")
                    let subject = OffersHTTPService(httpClient: mockHTTPClient)

                    let retrievedOffer = subject.getOffer(forId: "expectedId")

                    XCTAssertEqual(mockHTTPClient.numberOfGetInvocations, 1)
                    XCTAssertNil(retrievedOffer)
                }
            }

            describe("toggleFavoriteOffer") {
                it("HTTP client should call post with corresponding offer id, trigger callback, and retrieve update offer") {
                    let expectedOffer = Offer(id: "expectedId", name: "", url: "", description: "", terms: "", currentValue: "")
                    var didUpdateOffer = false
                    var lastUpdatedOfferId = ""
                    let mockHTTPClient = MockHTTPClient()
                    mockHTTPClient.nextResponse = HTTPURLResponse(
                        url: URL(string: "www.googles.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: [:]
                    )
                    mockHTTPClient.nextData = try! JSONEncoder().encode(expectedOffer)
                    let subject = OffersHTTPService(httpClient: mockHTTPClient)
                    subject.didUpdateOffer = { offer in
                        didUpdateOffer = true
                        lastUpdatedOfferId = offer.id
                    }

                    subject.toggleFavoriteOffer(forId: "expectedId")

                    XCTAssertTrue(didUpdateOffer)
                    XCTAssertEqual(lastUpdatedOfferId, "expectedId")
                    XCTAssertEqual(mockHTTPClient.numberOfPostInvocations, 1)
                    XCTAssertEqual(mockHTTPClient.lastURL!.pathComponents[1], "offers")
                    XCTAssertEqual(mockHTTPClient.lastURL!.pathComponents[2], "expectedId")
                    XCTAssertEqual(mockHTTPClient.lastURL!.pathComponents[3], "offer")

                    XCTAssertEqual(mockHTTPClient.numberOfGetInvocations, 1)
                }

                it("if status code is 400, should not trigger callback") {
                    var didUpdateOffer = false
                    let mockHTTPClient = MockHTTPClient()
                    mockHTTPClient.nextResponse = HTTPURLResponse(
                        url: URL(string: "www.googles.com")!,
                        statusCode: 400,
                        httpVersion: nil,
                        headerFields: [:]
                    )
                    let subject = OffersHTTPService(httpClient: mockHTTPClient)
                    subject.didUpdateOffer = { offer in
                        didUpdateOffer = true
                    }

                    subject.toggleFavoriteOffer(forId: "expectedId")

                    XCTAssertFalse(didUpdateOffer)
                    XCTAssertEqual(mockHTTPClient.numberOfPostInvocations, 1)
                    XCTAssertEqual(mockHTTPClient.numberOfGetInvocations, 0)
                }

                it("if status code is 500, should not trigger callback") {
                    var didUpdateOffer = false
                    let mockHTTPClient = MockHTTPClient()
                    mockHTTPClient.nextResponse = HTTPURLResponse(
                        url: URL(string: "www.googles.com")!,
                        statusCode: 500,
                        httpVersion: nil,
                        headerFields: [:]
                    )
                    let subject = OffersHTTPService(httpClient: mockHTTPClient)
                    subject.didUpdateOffer = { offer in
                        didUpdateOffer = true
                    }

                    subject.toggleFavoriteOffer(forId: "expectedId")

                    XCTAssertFalse(didUpdateOffer)
                    XCTAssertEqual(mockHTTPClient.numberOfPostInvocations, 1)
                    XCTAssertEqual(mockHTTPClient.numberOfGetInvocations, 0)
                }
            }
        }
    }
}
