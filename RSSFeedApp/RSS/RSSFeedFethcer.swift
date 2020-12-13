//
//  RSSFeedFethcer.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 12/12/2020.
//

import Foundation
import Alamofire
import TIFeedParser

enum RSSFetchError: Error
{
    case NetworkError
    case ParseError
}

protocol RSSFeedFethcerProtocol
{
    func fetch(_ feedUrlString: String, compaltionHandler: @escaping (Result<[RSSFeedItem], RSSFetchError>) -> Void)
}

class RSSFeedFethcer: RSSFeedFethcerProtocol
{
    func fetch(_ feedUrlString: String, compaltionHandler: @escaping (Result<[RSSFeedItem], RSSFetchError>) -> Void)
    {
        AF.request(feedUrlString).response { response in
            
            guard response.response?.statusCode == 200 else {
                compaltionHandler(.failure(.NetworkError))
                return
            }
            
            guard let data = response.data else {
                return
            }

            TIFeedParser.parseRSS(xmlData: data, onSuccess: { (channel) in
                var items = [RSSFeedItem]()
                channel.items.forEach { item in
                    
                    if let rssFeedName = item.title, let rssFeedUrl = item.link
                    {
                        items.append(RSSFeedItem(rssFeedName: rssFeedName, rssFeedUrl: URL(string: rssFeedUrl)!))
                    }
                }
                compaltionHandler(.success(items))
                
            }, onNotFound: {
                compaltionHandler(.failure(.ParseError))
            }, onFailure: { (error) in
                compaltionHandler(.failure(.ParseError))
            })
        }
    }
}
