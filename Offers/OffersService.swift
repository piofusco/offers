//
// Created by gideon on 10/27/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

protocol OffersService {
    func getOffers() -> [Offer]
}

class OffersServiceImplementation: OffersService {
    func getOffers() -> [Offer] {
        var offers: [Offer] = []

        if let path = Bundle.main.path(forResource: "offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                offers = try decoder.decode([Offer].self, from: data)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }

        return offers
    }
}