//
//  Storyboarded.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 13/12/2020.
//

import UIKit

func instantiateByStoryboardId(_ id: String) -> UIViewController
{
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id)
}

protocol Storyboarded
{
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController
{
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
