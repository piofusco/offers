//
// Created by gideon on 11/8/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

class OffersDataStoreService<T: DataStore>: OffersService where T.T == Offer {
    private var dataStore: T
    var didUpdateOffer: ((Offer) -> Void)?

    init(dataStore: T) {
        self.dataStore = dataStore
    }

    func getOffers() -> [Offer] {
        dataStore.elements()
    }

    func getOffer(forId id: String) -> Offer? {
        dataStore.element(id: id)
    }

    func toggleFavoriteOffer(forId id: String) {
        if var offer: Offer = dataStore.element(id: id) {
            offer.favorited = !offer.favorited
            dataStore.update(element: offer)
            didUpdateOffer?(offer)
        }
    }
}