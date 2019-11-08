//
// Created by gideon on 10/27/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

protocol OffersService {
    func getOffers() -> [Offer]
    func getOffer(forId id: String) -> Offer?
    func toggleFavoriteOffer(forId id: String)

    var didUpdateOffer: ((Offer) -> Void)? { get set }
}
