//
// Created by gideon on 11/8/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

enum URLs {
    case getOffer(id: String)
    case getOffers
    case postOffer(id: String)

    func url() -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 4567

        switch self {
            case .getOffer(let id): fallthrough
            case .postOffer(let id): components.path = "/offers/\(id)/offer"
            case .getOffers: components.path = "/offers"
        }

        guard let url = components.url else {
            fatalError("Invalid URL")
        }

        return url
    }
}
