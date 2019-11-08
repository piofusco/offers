//
// Created by gideon on 11/8/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

class OffersHTTPService: OffersService {
    var didUpdateOffer: ((Offer) -> Void)?
    private var httpClient: HTTPClient
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getOffers() -> [Offer] {
        var offers = [Offer]()
        let url = URLs.getOffers.url()

        httpClient.get(url: url) { data, response, _ in
            if let responseData = data {
                if let requestResponse = response as? HTTPURLResponse {
                    if requestResponse.statusCode == 200 {
                        if let parsedOffers = try? JSONDecoder().decode([Offer].self, from: responseData) {
                            offers = parsedOffers
                            return
                        }
                    }
                }
            }
        }

        return offers
    }

    func getOffer(forId id: String) -> Offer? {
        var offer: Offer? = nil
        let url = URLs.getOffer(id: id).url()

        httpClient.get(url: url) { data, response, _ in
            if let responseData = data {
                if let requestResponse = response as? HTTPURLResponse {
                    if requestResponse.statusCode == 200 {
                        if let parsedOffer = try? JSONDecoder().decode(Offer.self, from: responseData) {
                            offer = parsedOffer
                            return
                        }
                    }
                }
            }
        }

        return offer
    }

    func toggleFavoriteOffer(forId id: String) {
        let url = URLs.postOffer(id: id).url()

        httpClient.post(url: url) { _, response, _ in
            if let requestResponse = response as? HTTPURLResponse {
                if requestResponse.statusCode == 200 {
                    if let offer = self.getOffer(forId: id) {
                        self.didUpdateOffer?(offer)
                    }
                }
            }
        }
    }
}
