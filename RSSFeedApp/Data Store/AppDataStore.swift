//
//  AppDataStore.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 13/12/2020.
//

import Foundation

enum DataStoreKeys: String
{
    case lastRssFeedItem = "lastRssFeedItem"
}

protocol AppDataStoreProtocol
{
    subscript(key: String) -> Any? { get set }
}

class AppDataStore: AppDataStoreProtocol
{
    private var data: [String:Any] = [:]
    
    static let shared = AppDataStore()
    
    subscript(key: String) -> Any?
    {
       get { data[key] }
       set { data[key] = newValue }
    }
}
