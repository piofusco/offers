//
// Created by gideon on 10/28/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

enum Fonts: String {
    case demiBold = "AvenirNext-DemiBold"
    case regular = "AvenirNext-Regular"

    func font(withSize size: CGFloat) -> UIFont {
        UIFont(name: self.rawValue, size: size) ?? UIFont()
    }
}