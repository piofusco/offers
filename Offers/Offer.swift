//
// Created by gideon on 2/7/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import Foundation

import Freddy

struct Offer {
    let name: String
    let url: String?
    let description: String
    let terms: String
    let currentValue: String
}

extension Offer: JSONDecodable {
    public init(json value: JSON) throws {
        name = try value.getString(at: "name")
        url = try value.getString(at: "url", alongPath: .nullBecomesNil)
        description = try value.getString(at: "description")
        terms = try value.getString(at: "terms")
        currentValue = try value.getString(at: "current_value")
    }
}