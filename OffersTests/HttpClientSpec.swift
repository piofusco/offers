//
// Created by gideon on 11/5/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Quick

@testable import Offers

class HttpClientSpec: QuickSpec {
    override func spec() {
        describe("HttpClient") {
            let expectedURL = URL(string: "localhost")!
            var receivedData: Data?
            var receivedResponse: URLResponse?
            var receivedError: Error?

            var mockSession: MockURLSession!

            beforeEach {
                receivedData = nil
                receivedResponse = nil
                receivedError = nil

                mockSession = MockURLSession(nextURLSessionDataTask: MockURLSessionDataTask())
            }

            describe("GET") {
                describe("on success") {
                    it("with a status code of 200, callback should return retrieved data and trigger callback") {
                        var didTriggerCallback = false
                        let nextURLSessionDataTask = MockURLSessionDataTask()
                        mockSession = MockURLSession(nextURLSessionDataTask: nextURLSessionDataTask)
                        mockSession.nextData = Data(base64Encoded: "")
                        mockSession.nextURLResponse = HTTPURLResponse(
                            url: expectedURL,
                            statusCode: 200,
                            httpVersion: nil,
                            headerFields: [:]
                        )
                        let subject = OffersClient(session: mockSession)

                        subject.get(url: expectedURL) { data, response, error in
                            didTriggerCallback = true
                            receivedData = data
                            receivedResponse = response
                            receivedError = error
                        }

                        XCTAssertEqual(mockSession.lastHTTPMethod, "GET")
                        XCTAssertTrue(didTriggerCallback)
                        XCTAssertEqual(expectedURL.absoluteURL, mockSession.lastURL)
                        XCTAssertEqual(nextURLSessionDataTask.numberOfResumeInvocations, 1)
                        XCTAssertEqual(receivedData, mockSession.nextData)
                        XCTAssertNil(receivedResponse)
                        XCTAssertNil(receivedError)
                    }
                }

                describe("on HTTP failure") {
                    it("with a status code of 400, callback should return url response") {
                        mockSession.nextData = Data(base64Encoded: "")
                        mockSession.nextURLResponse = HTTPURLResponse(
                            url: expectedURL,
                            statusCode: 400,
                            httpVersion: nil,
                            headerFields: [:]
                        )
                        let subject = OffersClient(session: mockSession)

                        subject.get(url: expectedURL) { data, response, error in
                            receivedData = data
                            receivedResponse = response
                            receivedError = error
                        }

                        XCTAssertNil(receivedData)
                        XCTAssertEqual(receivedResponse as! HTTPURLResponse, mockSession.nextURLResponse)
                        XCTAssertNil(receivedError)
                    }

                    it("with a status code of 500, callback should return url response") {
                        mockSession.nextData = Data(base64Encoded: "")
                        mockSession.nextURLResponse = HTTPURLResponse(
                            url: expectedURL,
                            statusCode: 500,
                            httpVersion: nil,
                            headerFields: [:]
                        )
                        let subject = OffersClient(session: mockSession)

                        subject.get(url: expectedURL) { data, response, error in
                            receivedData = data
                            receivedResponse = response
                            receivedError = error
                        }

                        XCTAssertNil(receivedData)
                        XCTAssertEqual(receivedResponse as! HTTPURLResponse, mockSession.nextURLResponse)
                        XCTAssertNil(receivedError)
                    }
                }

                describe("on error") {
                    it("callback should return error") {
                        mockSession.nextError = NSError(domain: "somethin' wrong", code: -9)
                        let subject = OffersClient(session: mockSession)

                        subject.get(url: expectedURL) { data, response, error in
                            receivedData = data
                            receivedResponse = response
                            receivedError = error
                        }

                        XCTAssertNil(receivedData)
                        XCTAssertNil(receivedResponse)
                        XCTAssertEqual((receivedError! as NSError).domain, (mockSession.nextError! as NSError).domain)
                    }
                }
            }

            describe("POST") {
                describe("on success") {
                    it("session should make POST request with expected URL and trigger callback") {
                        var didTriggerCallback = false
                        let nextURLSessionDataTask = MockURLSessionDataTask()
                        mockSession = MockURLSession(nextURLSessionDataTask: nextURLSessionDataTask)
                        mockSession.nextData = Data(base64Encoded: "")
                        mockSession.nextURLResponse = HTTPURLResponse(
                            url: expectedURL,
                            statusCode: 200,
                            httpVersion: nil,
                            headerFields: [:]
                        )
                        let subject = OffersClient(session: mockSession)

                        subject.post(url: expectedURL) { data, response, error in
                            didTriggerCallback = true
                            receivedData = data
                            receivedResponse = response
                            receivedError = error
                        }

                        XCTAssertTrue(didTriggerCallback)
                        XCTAssertEqual(expectedURL.absoluteURL, mockSession.lastURL)
                        XCTAssertEqual(nextURLSessionDataTask.numberOfResumeInvocations, 1)
                        XCTAssertEqual(mockSession.lastHTTPMethod, "POST")
                        XCTAssertEqual(receivedData, mockSession.nextData)
                        XCTAssertNil(receivedResponse)
                        XCTAssertNil(receivedError)
                    }
                }

                describe("on HTTP failure") {
                    it("with a status code of 400, callback should return url response") {
                        mockSession.nextData = Data(base64Encoded: "")
                        mockSession.nextURLResponse = HTTPURLResponse(
                            url: expectedURL,
                            statusCode: 400,
                            httpVersion: nil,
                            headerFields: [:]
                        )
                        let subject = OffersClient(session: mockSession)

                        subject.post(url: expectedURL) { data, response, error in
                            receivedData = data
                            receivedResponse = response
                            receivedError = error
                        }

                        XCTAssertNil(receivedData)
                        XCTAssertEqual(receivedResponse as! HTTPURLResponse, mockSession.nextURLResponse)
                        XCTAssertNil(receivedError)
                    }

                    it("with a status code of 500, callback should return url response") {
                        mockSession.nextData = Data(base64Encoded: "")
                        mockSession.nextURLResponse = HTTPURLResponse(
                            url: expectedURL,
                            statusCode: 500,
                            httpVersion: nil,
                            headerFields: [:]
                        )
                        let subject = OffersClient(session: mockSession)

                        subject.post(url: expectedURL) { data, response, error in
                            receivedData = data
                            receivedResponse = response
                            receivedError = error
                        }

                        XCTAssertNil(receivedData)
                        XCTAssertEqual(receivedResponse as! HTTPURLResponse, mockSession.nextURLResponse)
                        XCTAssertNil(receivedError)
                    }
                }

                describe("on error") {
                    it("callback should return error") {
                        mockSession.nextError = NSError(domain: "somethin' wrong", code: -9)
                        let subject = OffersClient(session: mockSession)

                        subject.post(url: expectedURL) { data, response, error in
                            receivedData = data
                            receivedResponse = response
                            receivedError = error
                        }

                        XCTAssertNil(receivedData)
                        XCTAssertNil(receivedResponse)
                        XCTAssertEqual((receivedError! as NSError).domain, (mockSession.nextError! as NSError).domain)
                    }
                }
            }
        }
    }
}
