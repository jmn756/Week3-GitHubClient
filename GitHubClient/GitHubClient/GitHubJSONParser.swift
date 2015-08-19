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
            url = repoRecord["url"] as? String
            
          {
            let repo = Repo(name: name, url: url)
            
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
            url = userRecord["url"] as? String
            
          {
            let user = User(login: login, url: url)
            
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
  
  
}

