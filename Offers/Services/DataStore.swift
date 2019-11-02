//
// Created by gideon on 10/27/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

protocol DataStore: class {
    func elements<T: Codable>() -> [T]
    func element<T: Codable>(id: String) -> T?
    func update<T: Codable>(element: T)
}

class OffersDataStore: DataStore {
    private var offersInMemory: [Offer] = []

    init() {
        if let path = Bundle.main.path(forResource: "offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                offersInMemory = try JSONDecoder().decode([Offer].self, from: data)
            } catch {
                print("could not load initial json: \(error.localizedDescription)")
            }
        }
    }

    func element<Offer>(id: String) -> Offer? {
        for (offer) in offersInMemory {
            if (offer.id == id) {
                if let returnOffer = offer as? Offer {
                    return returnOffer
                }
            }
        }

        return nil
    }

    func elements<Codable>() -> [Codable] {
        guard let elements: [Codable] = offersInMemory as? [Codable] else {
            return []
        }

        return elements
    }

    func update<Codable>(element: Codable) {
        guard let offerToUpdate = element as? Offer else {
            return
        }

        for (index, offer) in offersInMemory.enumerated() {
            if (offer.id == offerToUpdate.id) {
                offersInMemory[index].favorited = !offersInMemory[index].favorited
                return
            }
        }
    }
}