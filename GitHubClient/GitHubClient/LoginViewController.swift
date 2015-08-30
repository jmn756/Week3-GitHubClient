//
//  LoginViewController.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/19/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newToken", name: kTokenNotification, object: nil)
      
    }
  
  
    override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      
   }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  func newToken() {
    performSegueWithIdentifier("PresentMenu", sender: nil)
  }
  
  
  @IBAction func loginButton(sender: AnyObject) {
    if let token = KeychainService.loadToken() {
      
    } else {
      AuthService.performInitialRequest()
    }
  }
  
   
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: kTokenNotification, object: nil)
  }

}
