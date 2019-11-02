//
// Created by gideon on 10/30/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

class MockNavigationController: UINavigationController {
    var lastPushedVC: UIViewController = UIViewController()
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.lastPushedVC = viewController
    }
}
