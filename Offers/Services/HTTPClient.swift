//
// Created by gideon on 11/8/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

protocol HTTPClient {
    func get(url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
    func post(url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class OffersClient: HTTPClient {
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }

    func get(url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                callback(nil, nil, error)
                return
            }

            if let responseData = data {
                if let requestResponse = response as? HTTPURLResponse {
                    if requestResponse.statusCode == 200 {
                        callback(responseData, nil, nil)
                        return
                    } else if 400...500 ~= requestResponse.statusCode {
                        callback(nil, response, nil)
                        return
                    }
                }
            }
        }

        task.resume()
    }

    func post(url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = session.dataTask(with: request) { responseData, requestResponse, error in
            if let _ = error {
                callback(nil, nil, error)
                return
            }

            if let responseData = responseData {
                if let requestResponse = requestResponse as? HTTPURLResponse {
                    if requestResponse.statusCode == 200 {
                        callback(responseData, nil, nil)
                        return
                    } else if 400...500 ~= requestResponse.statusCode  {
                        callback(nil, requestResponse, nil)
                        return
                    }
                }
            }
        }

        task.resume()
    }
}