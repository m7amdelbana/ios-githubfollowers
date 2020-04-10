//
//  TabBarController.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

let TAB = TabBarController.shared

class TabBarController: UITabBarController {
    
    static let shared = TabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        viewControllers = [searchNavController, favoritesNavController]
        tabBar.tintColor = .primary
    }
    
    var searchNavController: NavController {
        let searchController = SearchController()
        searchController.title = localizedText("search")
        searchController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return NavController(rootViewController: searchController)
    }
    
    var favoritesNavController: NavController {
        let favoritesController = FavoritesController()
        favoritesController.title = localizedText("favorites")
        favoritesController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return NavController(rootViewController: favoritesController)
    }
}
