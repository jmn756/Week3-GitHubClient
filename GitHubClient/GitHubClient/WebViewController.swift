//
//  WebViewController.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/23/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit
import WebKit

//Brad Johnson code
class WebViewController: UIViewController {
  
    var selectedURL: String!
  
  override func viewDidLoad() {
        super.viewDidLoad()

      let webView = WKWebView(frame: view.frame)
      view.addSubview(webView)
      
      let urlRequest = NSURLRequest(URL: NSURL(string: selectedURL)!)
      webView.loadRequest(urlRequest)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
