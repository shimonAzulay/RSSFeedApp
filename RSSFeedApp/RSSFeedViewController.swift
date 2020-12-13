//
//  RSSFeedViewController.swift
//  RSSFeedApp
//
//  Created by Shimon Azulay on 12/12/2020.
//

import UIKit

class RSSFeedViewController: UIViewController
{
    weak private var rssFeedTableView: UITableView?
    weak private var fetchingIndicator: UIActivityIndicatorView?
    
    var appCoordinator: Coordinator?
    
    var rssFeedItems: [[RSSFeedItem]] = [] {
        didSet
        {
            self.layoutData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.createFetchingIndicator()
        self.createRssFeedTableView()
        self.registerRssFeedTableViewCells()
        self.configureRssFeedTableView()
    }
}

extension RSSFeedViewController
{
    private func layoutData()
    {
        DispatchQueue.main.async { [weak self] in
            self?.fetchingIndicator?.stopAnimating()
            self?.rssFeedTableView?.isHidden = false
            self?.rssFeedTableView?.reloadData()
        }
    }
}

extension RSSFeedViewController
{
    private func createFetchingIndicator()
    {
        let fetchingIndicator = UIActivityIndicatorView()
        fetchingIndicator.style = .large
        fetchingIndicator.hidesWhenStopped = true
        fetchingIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fetchingIndicator)
        
        fetchingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fetchingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        fetchingIndicator.startAnimating()
    }
    
    private func createRssFeedTableView()
    {        
        let tableView = UITableView()
        tableView.isHidden = true
        self.view.addSubview(tableView)
        self.rssFeedTableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    private func registerRssFeedTableViewCells() {
        let rssFeedNibCell = UINib(nibName: "RSSFeedTableViewCell", bundle: nil)
        self.rssFeedTableView?.register(rssFeedNibCell, forCellReuseIdentifier: "RSSFeedCell")
    }
    
    private func configureRssFeedTableView()
    {
        self.rssFeedTableView?.delegate = self
        self.rssFeedTableView?.dataSource = self
    }
}

extension RSSFeedViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let rssFeedItem = self.rssFeedItems[indexPath.section][indexPath.row]
        self.appCoordinator?.loadRssFeedItemScreen(rssFeedItem: rssFeedItem)
    }
}

extension RSSFeedViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.rssFeedItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.rssFeedItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let rssFeedItem = self.rssFeedItems[indexPath.section][indexPath.row]
        
        guard let reusedRssFeedCell = tableView.dequeueReusableCell(withIdentifier: "RSSFeedCell") as? RSSFeedTableViewCell else {
            let rssFeedCell = RSSFeedTableViewCell()
            rssFeedCell.rssFeedItem = rssFeedItem
            return rssFeedCell
        }
        
        reusedRssFeedCell.rssFeedItem = rssFeedItem
        return reusedRssFeedCell
    }
}
