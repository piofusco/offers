//
// Created by gideon on 10/30/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
    func viewOffer(offer: Offer)
}