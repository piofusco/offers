//
//  AppDelegate.swift
//  Offers
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let homeViewController = OffersViewController()
        homeViewController.view.backgroundColor = UIColor.blue

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()

        return true
    }
}
