//
//  CNNWorldSportAndEntertainmentRSSFeedViewController.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 12/12/2020.
//

import UIKit

class CNNWorldSportAndEntertainmentRSSFeedViewController: RSSFeedViewController
{    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.rssFeedDataSource?.startFetch(from: [URL(string: "http://rss.cnn.com/rss/edition_sport.rss")!,
                                            URL(string: "http://rss.cnn.com/rss/edition_entertainment.rss")!])
    }
}

extension CNNWorldSportAndEntertainmentRSSFeedViewController
{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section {
        case 0:
            return "World Sport"
        case 1:
            return "Entertainment"
        default:
            return nil
        }
    }
}
