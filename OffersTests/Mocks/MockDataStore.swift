//
// Created by gideon on 10/30/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockDataStore: DataStore {
    var numberOfUpdateInvocations = 0
    var lastUpdatedElementId = ""
    func update<T: Codable>(element: T) {
        numberOfUpdateInvocations += 1
        if let offer = element as? Offer {
            lastUpdatedElementId = offer.id
        }
    }

    var numberOfElementInvocations = 0
    var lastElementId = ""
    var stubbedElement: Codable? = nil
    func element<T: Codable>(id: String) -> T? {
        numberOfElementInvocations += 1
        lastElementId = id
        if let element: T = stubbedElement as? T {
            return element
        } else {
            return nil
        }
    }

    var numberOfElementsInvocations = 0
    var stubbedElements = [Codable]()
    func elements<T: Codable>() -> [T] {
        numberOfElementsInvocations += 1
        return stubbedElements as! [T]
    }
}