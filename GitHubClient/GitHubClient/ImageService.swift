//
//  ImageService.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/22/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class ImageService {
  class func ImageExtraction (url: String, completionHandler: (UIImage?) -> ()) {
    
    var imageQueue = NSOperationQueue()
    var image = UIImage()
    
    imageQueue.addOperationWithBlock({ () -> Void in
      if let imageURL = NSURL(string: url) {
        if let imageData = NSData(contentsOfURL: imageURL) {
          if let image = UIImage(data: imageData) {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(image)
            })
          }
        }
      }
    })
  }
}
