//
// Created by gideon on 2/7/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import Foundation

struct Offer: Codable {
    let id: String
    let name: String
    let url: String?
    let description: String
    let terms: String
    let currentValue: String

    var favorited = false
}

extension Offer {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case description
        case terms
        case currentValue = "current_value"
    }
}
