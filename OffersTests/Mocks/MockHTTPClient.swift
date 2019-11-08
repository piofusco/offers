//
// Created by gideon on 11/8/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

@testable import Offers

class MockHTTPClient: HTTPClient {
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?

    var lastURL: URL?
    var numberOfGetInvocations = 0
    func get(url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        callback(nextData, nextResponse, nextError)
        numberOfGetInvocations += 1
        lastURL = url
    }

    var numberOfPostInvocations = 0
    func post(url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        callback(nextData, nextResponse, nextError)
        numberOfPostInvocations += 1
        lastURL = url
    }
}