//
//  MenuTableViewController.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/17/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()
      if let token = KeychainService.loadToken() {
        println(token)
      } else {
        AuthService.performInitialRequest()
      }

    }

  
    // MARK: - Navigation

//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    if segue.identifier == "ShowMyProfile" {
//      if let destination = segue.destinationViewController as? DetailViewController {
//         GitHubService.getAuthenticatedUser({(String, authUser) -> (Void) in
//           if let authUser = authUser {
//              destination.authUser = authUser
//           }
//        })
//      }
//    }
//  }
}
