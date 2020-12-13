//
//  RSSFeedTableViewCell.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 12/12/2020.
//

import UIKit

class RSSFeedTableViewCell: UITableViewCell
{
    @IBOutlet weak private var rssFeed: UILabel!
    
    var rssFeedItem: RSSFeedItem?
    {
        didSet
        {
            self.layoutData()
        }
    }
    
    override func prepareForReuse()
    {
        self.rssFeed.text = ""
    }
}

extension RSSFeedTableViewCell
{
    private func layoutData()
    {
        guard let rssFeedItem = self.rssFeedItem else { return }
        
        self.rssFeed.text = rssFeedItem.rssFeedName
    }
}
