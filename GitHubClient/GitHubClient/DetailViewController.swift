//
//  DetailViewController.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/22/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
   var selectedUser: User?
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imageView.image = selectedUser!.avatar_image
        navigationItem.title = "Detail User View"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
