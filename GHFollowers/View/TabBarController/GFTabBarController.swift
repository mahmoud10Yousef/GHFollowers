//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/23/21.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers                 = [createSearchNC() , createFavoritesNC()]
    }

    
    private func createSearchNC() -> UINavigationController{
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    private func createFavoritesNC() -> UINavigationController{
        let favoritesVC        = FavoritesListVC()
        favoritesVC.title      = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
    

}
