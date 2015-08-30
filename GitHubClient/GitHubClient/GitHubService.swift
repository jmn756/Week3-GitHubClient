//
//  GitHubService.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/17/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import Foundation

class GitHubService {
  class func repositoriesForSearchTerm(searchTerm: String, completionHandler: (String?, [Repo]?) ->Void) {
    let baseURL = "https://api.github.com/search/repositories"
    let finalURL = baseURL + "?q=\(searchTerm)"
    var repos = [Repo]()
    
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("An error has occurred")
        } else if let httpResponse = response as? NSHTTPURLResponse {
          let rv = self.checkStatusCodes(httpResponse.statusCode)
          if rv == "OK" {
            repos = GitHubJSONParser.repoInfoFromJSONData(data)!
            completionHandler(nil, repos)
          } else {
            completionHandler(rv, nil)
          }
        }
      }).resume()
    }
}
  
  
  class func usersForSearchTerm(searchTerm: String, completionHandler: (String?, [User]?) ->Void) {
    let baseURL = "https://api.github.com/search/users"
    let finalURL = baseURL + "?q=\(searchTerm)"
    var users = [User]()
    
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("An error has occurred")
        } else if let httpResponse = response as? NSHTTPURLResponse {
          let rv = self.checkStatusCodes(httpResponse.statusCode)
          if rv == "OK" {
            users = GitHubJSONParser.userInfoFromJSONData(data)!
            completionHandler(nil, users)
          } else {
            completionHandler(rv, nil)
          }
        }
      }).resume()
    }
  }

  
  class func getAuthenticatedUser(completionHandler: (String?, AuthUser?) ->Void) {
    let baseURL = "https://api.github.com/"
    let token = KeychainService.loadToken()
    let finalURL = baseURL + "?access_token=\(token)"
    var authUser: AuthUser!
    
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("error")
        } else if let httpResponse = response as? NSHTTPURLResponse {
            let rv = self.checkStatusCodes(httpResponse.statusCode)
            if rv == "OK" {
              authUser = GitHubJSONParser.authUserInfoFromJSONData(data)!
              completionHandler(nil, authUser)
            } else {
              completionHandler(rv, nil)
            }
            println(rv)
        }
      }).resume()
    }
  }

  class func checkStatusCodes(statusCode: Int) -> String {
    var resultString: String
    
     switch statusCode {
      case 200...299:
        resultString = "OK"
      case 400...499:
        resultString = "Page not found"
      case 500...599:
        resultString = "Server issue occurred"
      default:
        resultString = "Request could not be completed"
    }
    return resultString
  }

  
}


