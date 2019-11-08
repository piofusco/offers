//
// Created by gideon on 11/8/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

@testable import Offers

class MockURLSession: URLSession {
    private let mockURLSessionDataTask: URLSessionDataTask
    init(nextURLSessionDataTask: URLSessionDataTask) {
        self.mockURLSessionDataTask = nextURLSessionDataTask

        super.init()
    }

    var lastData: Data?
    var lastURL = URL(string: "")
    var lastHTTPMethod = ""

    var nextData: Data?
    var nextURLResponse: URLResponse?
    var nextError: Error?
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastData = request.httpBody
        lastURL = request.url
        lastHTTPMethod = request.httpMethod!
        completionHandler(nextData, nextURLResponse, nextError)
        return mockURLSessionDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var numberOfResumeInvocations = 0
    override func resume() {
        numberOfResumeInvocations += 1
    }
}