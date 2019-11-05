//
// Created by gideon on 11/4/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockFavoritable: Favoritable {
    var lastFavoritedId = ""
    func didFavoriteOffer(withId id: String) {
        lastFavoritedId = id
    }
}