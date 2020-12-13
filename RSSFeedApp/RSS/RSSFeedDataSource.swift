//
//  RSSFeedDataSource.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 12/12/2020.
//

import Foundation

protocol RSSFeedDataSourceProtocol
{
    var rssFeedFetchTimeInterval: TimeInterval { set get }
    var rssFeedObserver: ((_ rssFeedItem: [[RSSFeedItem]]) -> Void)? { get set }
    func startFetch(from urls: [URL])
    func stopFetching()
}

class RSSFeedDataSource: RSSFeedDataSourceProtocol
{
    private var rssFeedSourceUrls: [URL]?
    private var rssFeedFetcher: RSSFeedFethcerProtocol
    private var fetchingTimer: Timer?
    private var fetchedItems: [[RSSFeedItem]] = []
    
    var rssFeedFetchTimeInterval: TimeInterval = 5.0
    {
        didSet
        {
            self.initFetchingTimer()
        }
    }
    
    var rssFeedObserver: ((_ rssFeedItem: [[RSSFeedItem]]) -> Void)?
    
    init(rssFeedFetcher: RSSFeedFethcerProtocol)
    {
        self.rssFeedFetcher = rssFeedFetcher
    }
    
    func startFetch(from urls: [URL])
    {
        self.rssFeedSourceUrls = urls
        
        self.initFetchingTimer()
    }
    
    func stopFetching()
    {
        self.fetchingTimer?.invalidate()
        self.fetchingTimer = nil
    }
}

extension RSSFeedDataSource
{
    private func initFetchingTimer()
    {
        self.fetchingTimer?.invalidate()
        self.fetchingTimer = nil
        
        guard self.rssFeedSourceUrls != nil else {
            return
        }
        
        self.fetchingTimer = Timer.scheduledTimer(timeInterval: self.rssFeedFetchTimeInterval, target: self, selector: #selector(fetch), userInfo: nil, repeats: true)
        
        self.fetchingTimer?.fire()
    }
    
    @objc private func fetch()
    {
        self.fetchedItems = []
        self.rssFeedSourceUrls?.forEach { url in
            
            let _ = self.rssFeedFetcher.fetch(url.absoluteString) { [weak self] result in
                
                switch result
                {
                  case .success(let items):
                    
                    self?.fetchedItems.append(items)
                    
                    if self?.fetchedItems.count == self?.rssFeedSourceUrls?.count
                    {
                        self?.notifyObserver()
                    }
                    
                  case .failure(let error):
                      print(error.localizedDescription)
                }
            }
        }
    }
    
    private func notifyObserver()
    {
        self.rssFeedObserver?(self.fetchedItems)
    }
}
