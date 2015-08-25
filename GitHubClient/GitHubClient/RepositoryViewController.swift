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
  var url: String!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Repository Search"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowWebPage" {
      if let destination = segue.destinationViewController as? WebViewController {
        var selectedIndexPath = self.tableView.indexPathForSelectedRow()
        var selectedURL = self.repos[selectedIndexPath!.row].htmlurl
        destination.selectedURL = selectedURL
      }
    }
  }
  
}

//MARK: UISearchBarDelegate
extension RepositoryViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    GitHubService.repositoriesForSearchTerm(searchBar.text, completionHandler: {(String, repos) -> (Void) in
       if let repos = repos {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
        self.repos = repos
        self.tableView.reloadData()
        self.searchBar.resignFirstResponder()
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
    cell.backgroundColor = UIColor.whiteColor()
    
    cell.nameLabel.text = repos[indexPath.row].name
    cell.urlLabel.text = repos[indexPath.row].htmlurl
    if indexPath.row % 2 == 0 {
      cell.backgroundColor = UIColor.redColor()
    }
    
    return cell
  }
  
}

extension RepositoryViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowWebPage", sender: self)
    
  }
}















