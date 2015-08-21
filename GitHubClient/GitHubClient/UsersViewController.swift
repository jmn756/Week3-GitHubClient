//
//  UsersViewController.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/20/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  lazy var imageQueue = NSOperationQueue()

  var users = [User]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    collectionView.dataSource = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    collectionView.reloadData()
  }
  
  
}

//MARK: UISearchBarDelegate
extension UsersViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    GitHubService.usersForSearchTerm(searchBar.text, completionHandler: {(String, users) -> (Void) in
      if let users = users {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
          self.users = users
          self.collectionView.reloadData()
          self.searchBar.resignFirstResponder()
        }
      }
    })
  }
}


  //MARK: UICollectionViewDataSource
extension UsersViewController : UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return users.count
  }
    
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! AvatarCell
    
      cell.imageView.image = nil
     // cell.alpha = 0
    
      cell.tag++
      let tag = cell.tag
    
    let user = users[indexPath.row]
    
      if let avatar_image = user.avatar_image {
        cell.imageView.image = avatar_image
      } else {
        //Profile Image generation
        imageQueue.addOperationWithBlock({ () -> Void in
          if let imageURL = NSURL(string: user.avatar_url) {
            if let imageData = NSData(contentsOfURL: imageURL){
            if let image = UIImage(data: imageData) {
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  self.users[indexPath.row].avatar_image = image
                if cell.tag == tag {
                  cell.imageView.image = image
                }
              })
              }
            }
          }
        })
      }
    return cell
    }
}


  //MARK: UICollectionViewDelegate
extension UsersViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
      
      
//      let options = PHImageRequestOptions()
//      options.synchronous = true
//      
//      if let asset = fetchResult[indexPath.row] as? PHAsset {
//        imageQueue.addOperationWithBlock({ () -> Void in
//          
//
//            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//              if let image = image {
//                self.delegate?.galleryViewController(self, didSelectImage: image)
//                self.navigationController?.popViewControllerAnimated(true)
//              }
//            })
//          }
//        })
//        
//      }
//      
  }
  }

 


