//
//  ViewController.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 12/12/2020.
//

import UIKit

class ViewController: UIViewController, Storyboarded
{
    @IBOutlet weak private var lastRssFeedItem: UILabel!
    @IBOutlet weak var dateAndTime: DateAndTime!
    
    var coordinator: Coordinator?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Main"
        
        self.layoutLastRssFeedItemData()
    }
    
    @IBAction func rssFeedButtonPressed(_ sender: Any)
    {
        self.coordinator?.loadCNNRssFeed()
    }
    
    @IBAction func lastRssFeedItemPressed(_ sender: UITapGestureRecognizer)
    {
        guard let lastRssFeedItem = RSSFeedHelper.lastRSSFeedItem else {
            return
        }
        
        self.coordinator?.loadRssFeedItemScreen(rssFeedItem: lastRssFeedItem)
    }
}

extension ViewController
{
    private func layoutLastRssFeedItemData()
    {
        guard let lastRssFeedItem = RSSFeedHelper.lastRSSFeedItem else {
            return
        }
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 17),
              .foregroundColor: UIColor.blue,
              .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        self.lastRssFeedItem.attributedText = NSMutableAttributedString(string: lastRssFeedItem.rssFeedName, attributes: yourAttributes)
        
    }
}

