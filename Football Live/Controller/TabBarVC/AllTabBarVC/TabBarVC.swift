//
//  TabBarVC.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import UIKit

class TabBarVC: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let todayVC = TodayVC()
        let navTodayVC = UINavigationController()
        navTodayVC.viewControllers = [todayVC]
        
        let favoritesVC = FavoritesVC()
        let navFavoritesVC = UINavigationController()
        navFavoritesVC.viewControllers = [favoritesVC]
        
        self.viewControllers = [navTodayVC, navFavoritesVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let items = tabBar.items else { return }
        items[0].title = "Today's Fixtures"
        items[1].title = "Favorites"
    }
}

