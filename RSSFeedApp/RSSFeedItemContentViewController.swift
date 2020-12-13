//
//  RSSFeedItemContentViewController.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 13/12/2020.
//

import UIKit
import WebKit

class RSSFeedItemContentViewController: UIViewController, Storyboarded
{
    @IBOutlet weak private var webView: WKWebView!
    
    var rssFeedItem: RSSFeedItem?

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.loadURL()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        guard let rssFeedItem = self.rssFeedItem else {
            return
        }
        
        self.navigationItem.title = rssFeedItem.rssFeedName
    }
}

extension RSSFeedItemContentViewController
{
    private func loadURL()
    {
        guard let rssFeedItem = self.rssFeedItem else {
            return
        }
        
        RSSFeedHelper.lastRSSFeedItem = rssFeedItem
        
        self.webView.load(URLRequest(url: rssFeedItem.rssFeedUrl))
    }
}
