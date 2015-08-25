//
//  GitHubJSONParser.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/18/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class GitHubJSONParser {
  class func repoInfoFromJSONData(jsonData : NSData) -> [Repo]? {
    
    var error: NSError?
    var repos = [Repo]()
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject] {
      
      if let items = rootObject["items"] as? [[String: AnyObject]] {
        for repoRecord in items {
          
          if let name = repoRecord["name"] as? String,
            url = repoRecord["url"] as? String,
            htmlurl = repoRecord["html_url"] as? String
          {
            let repo = Repo(name: name, url: url, htmlurl: htmlurl)
            
            repos.append(repo)
          } else {
            println("There is a problem with your data")
          }
        }
      }
      
    }
    
    if let error = error {
      println(error.description)
      return nil
    } else {
      return repos
    }
    
}
  
  class func userInfoFromJSONData(jsonData : NSData) -> [User]? {
    
    var error: NSError?
    var users = [User]()
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject] {
      
      if let items = rootObject["items"] as? [[String: AnyObject]] {
        for userRecord in items {
          
          if let login = userRecord["login"] as? String,
            avatar_url = userRecord["avatar_url"] as? String,
            id = userRecord["id"] as? Int
            
          {
            let user = User(login: login, avatar_url: avatar_url, avatar_image: nil, id: id)
            users.append(user)
          } else {
            println("There is a problem with your data")
          }
        }
      }
      
    }
    
    if let error = error {
      println(error.description)
      return nil
    } else {
      return users
    }
    
  }
  
  
  class func authUserInfoFromJSONData(jsonData : NSData) -> AuthUser? {
    
    var error: NSError?
    var auth: AuthUser?
    let avatar_image = UIImage()
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject] {
      
      if let bio = rootObject["bio"] as? String,
        let name = rootObject["name"] as? String,
        let hireable = rootObject["hireable"] as? Bool,
          let avatar_url = rootObject["avatar_url"] as? String,
          let public_repos = rootObject["public_repos"] as? Int,
          let plan = rootObject["plan"] as? [String: AnyObject],
          let private_repos = plan["private_repos"] as? Int {
          
          ImageService.ImageExtraction(avatar_url, completionHandler: { (result) -> () in
              if let result = result {
                let avatar_image = result
              }
          })
            
            let auth = AuthUser(name: name, bio: bio, hireable: hireable, avatar_url: avatar_url, avatar_image: avatar_image, public_repos: public_repos, private_repos: private_repos)
        } else {
          println("There is a problem with your data")
        }
      }
    
    if let error = error {
      println(error.description)
      return nil
    } else {
      return auth
    }
  }
}

