//
//  AppDelegate.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 05/10/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let nav = UINavigationController.init(rootViewController: MainTabController())
        nav.setNavigationBarHidden(true, animated: false)
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.backgroundColor = .systemBackground
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

