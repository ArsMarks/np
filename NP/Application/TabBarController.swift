//
//  TabBarController.swift
//  NP
//
//  Created by Рушан Киньягулов on 26.11.2021.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        self.tabBar.backgroundColor = .secondarySystemBackground
        self.tabBar.tintColor = Color.brandRed

        let filterVC = UINavigationController(rootViewController: FilterViewController())
        let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let profileWithoutAuthVC = UINavigationController(rootViewController: ProfileWithoutAuthViewController())
        
        filterVC.title = "Подобрать квартиру"
        favoriteVC.title = "Избранное"
        [profileVC, profileWithoutAuthVC].forEach({ viewControllers in
            viewControllers.title = "Профиль"
            viewControllers.tabBarItem.image = UIImage(named: "profile")
        })

        filterVC.tabBarItem.image = UIImage(named: "home")
        favoriteVC.tabBarItem.image = UIImage(named: "favorite")
        self.viewControllers = [filterVC, favoriteVC, profileWithoutAuthVC]
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.viewControllers = [filterVC, favoriteVC, profileWithoutAuthVC]
            } else {
                self.viewControllers = [filterVC, favoriteVC, profileVC]
            }
        }
        
        self.selectedViewController = filterVC
    }
}
