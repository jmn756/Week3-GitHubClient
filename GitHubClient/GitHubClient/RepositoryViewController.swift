//
//  RepositoryViewController.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/17/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  var repos = [Repo]()
  
  override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

//MARK: UISearchBarDelegate
extension RepositoryViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    GitHubService.repositoriesForSearchTerm(searchBar.text, completionHandler: {(String, repos) -> (Void) in
       if let repos = repos {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
        self.repos = repos
        //self.activityIndicator.stopAnimating()
        self.tableView.reloadData()
      }
    }
  })
  
}
}

extension RepositoryViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
    
  }
  
  func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Repos", forIndexPath: indexPath) as! RepoCell
    
    cell.nameLabel.text = repos[indexPath.row].name
    cell.urlLabel.text = repos[indexPath.row].url
    
    return cell
  }
  
  
}















