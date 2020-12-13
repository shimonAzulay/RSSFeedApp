//
//  CNNTravelRSSFeedViewController.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 12/12/2020.
//

import UIKit

class CNNTravelRSSFeedViewController: RSSFeedViewController
{
    let rssFeedDataSource = RSSFeedDataSource(rssFeedFetcher: RSSFeedFethcer())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        self.rssFeedDataSource.rssFeedObserver = { [weak self] items in
            self?.rssFeedItems = items
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.rssFeedDataSource.startFetch(from: [URL(string: "http://rss.cnn.com/rss/edition_travel.rss")!])
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.rssFeedDataSource.stopFetching()
    }
}
