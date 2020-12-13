//
//  CNNTravelRSSFeedViewController.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 12/12/2020.
//

import UIKit

class CNNTravelRSSFeedViewController: RSSFeedViewController
{    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.rssFeedDataSource?.startFetch(from: [URL(string: "http://rss.cnn.com/rss/edition_travel.rss")!])
    }
}
