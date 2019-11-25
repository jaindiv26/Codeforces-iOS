//
//  MainTabController.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 07/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

class MainTabController: UITabBarController {
    
    enum TabBarItemType {
        case home
        case gym
        case profile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        createViews()
    }
}

private extension MainTabController {
    
    func createViews() {
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = getTabBarItem(forType: .home)
               
        let gymViewcontroller = GymViewController()
        gymViewcontroller.tabBarItem = getTabBarItem(forType: .gym)
               
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.tabBarItem = getTabBarItem(forType: .profile)
        
        let tabBarList = [
            UINavigationController.init(rootViewController: homeViewController),
            UINavigationController.init(rootViewController: gymViewcontroller),
            UINavigationController.init(rootViewController: userProfileViewController)
        ]
        viewControllers = tabBarList
    }
    
    func getTabBarItem(forType type: TabBarItemType) -> UITabBarItem {
        switch type {
        case .home:
            let tabItem = UITabBarItem()
            tabItem.title = "Home"
            tabItem.image = UIImage(named: UIConstants.Image.home.rawValue)
            return tabItem
        case .gym:
            let tabItem = UITabBarItem()
            tabItem.title = "Gym"
            tabItem.image = UIImage(named: UIConstants.Image.gym.rawValue)
            return tabItem
        case .profile:
            let tabItem = UITabBarItem()
            tabItem.title = "Profile"
            tabItem.image = UIImage(named: UIConstants.Image.profile.rawValue)
            return tabItem
        }
    }
}
