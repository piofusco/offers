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
    private var offersOnDisk: [Offer] = []

    init() {
        if let path = Bundle.main.path(forResource: "offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                offersOnDisk = try decoder.decode([Offer].self, from: data)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
    }

    func toggleFavoriteOffer(forId id: String) {
        for (index, offer) in offersOnDisk.enumerated() {
            if (offer.id == id) {
                offersOnDisk[index].favorited = !offersOnDisk[index].favorited
                return
            }
        }
    }

    func getOffer(forId id: String) -> Offer? {
        offersOnDisk.first(where: { $0.id == id })
    }

    func getOffers() -> [Offer] {
        offersOnDisk
    }
}