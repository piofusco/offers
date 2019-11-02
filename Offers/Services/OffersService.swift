//
// Created by gideon on 10/27/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

protocol OffersService {
    func getOffers() -> [Offer]
    func getOffer(forId id: String) -> Offer?
    func toggleFavoriteOffer(forId id: String)
}

class OffersServiceImplementation: OffersService {
    private var dataStore: DataStore

    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }

    func toggleFavoriteOffer(forId id: String) {
        if var offer: Offer = dataStore.element(id: id) {
            offer.favorited = !offer.favorited
            dataStore.update(element: offer)
        }
    }

    func getOffer(forId id: String) -> Offer? {
        dataStore.element(id: id)
    }

    func getOffers() -> [Offer] {
        dataStore.elements()
    }
}