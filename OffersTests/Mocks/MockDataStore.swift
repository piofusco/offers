//
// Created by gideon on 10/30/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockDataStore: DataStore {
    typealias T = Offer

    var numberOfUpdateInvocations = 0
    var lastUpdatedElementId = ""
    func update(element: T) {
        numberOfUpdateInvocations += 1
        lastUpdatedElementId = element.id
    }

    var numberOfElementInvocations = 0
    var lastElementId = ""
    var stubbedElement: T? = nil
    func element(id: String) -> T? {
        numberOfElementInvocations += 1
        lastElementId = id
        return stubbedElement
    }

    var numberOfElementsInvocations = 0
    var stubbedElements = [T]()
    func elements() -> [T] {
        numberOfElementsInvocations += 1
        return stubbedElements
    }
}