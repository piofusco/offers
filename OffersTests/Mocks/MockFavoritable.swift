//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

@testable import Offers

class MockFavoriatable: Favoritable {
    var lastFavoritedId = ""

    func didFavoriteOffer(withId id: String) {
        lastFavoritedId = id
    }
}