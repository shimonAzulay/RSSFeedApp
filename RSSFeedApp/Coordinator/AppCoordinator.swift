//
//  AppCoordinator.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 13/12/2020.
//

import UIKit

protocol Coordinator
{
    var navigationController: UINavigationController { get set }

    func loadMainScreen()
    func loadCNNRssFeed()
    func loadRssFeedItemScreen(rssFeedItem: RSSFeedItem)
}

class AppCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func loadMainScreen()
    {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        vc.dataStore = AppDataStore.shared
        navigationController.pushViewController(vc, animated: true)
    }
    
    func loadCNNRssFeed()
    {
        let vc = TabBarController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func loadRssFeedItemScreen(rssFeedItem: RSSFeedItem)
    {
        let vc = RSSFeedItemContentViewController.instantiate()
        vc.rssFeedItem = rssFeedItem
        vc.dataStore = AppDataStore.shared
        navigationController.pushViewController(vc, animated: true)
    }
}
