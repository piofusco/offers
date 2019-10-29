//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

enum Images: String {
    case favorited = "Favorited"
    case favoritedFilled = "FavoritedFilled"

    var image: UIImage {
        let image = UIImage(named: self.rawValue) ?? UIImage()
        return image
    }
}
