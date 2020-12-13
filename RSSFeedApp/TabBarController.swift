//
//  TabBarController.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 13/12/2020.
//

import UIKit

class TabBarController: UITabBarController, Storyboarded
{
    var coordinator: Coordinator?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let _ = self.viewControllers?.forEach { viewController in
            
            if let rssFeedViewController = viewController as? RSSFeedViewController
            {
                rssFeedViewController.appCoordinator = self.coordinator
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "CNN RSS Feed"
    }
}
