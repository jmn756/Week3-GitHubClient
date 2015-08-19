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
    //let baseURL = "https://api.github.com/search/repositories"
    let baseURL = "http://localhost:3000"
    let finalURL = baseURL + "?q=\(searchTerm)"
    var repos = [Repo]()
    
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("error")
        } else if let httpResponse = response as? NSHTTPURLResponse {
          switch httpResponse.statusCode {
          case 200...299:
               repos = GitHubJSONParser.repoInfoFromJSONData(data)!
               completionHandler(nil, repos)
               println(repos.count)
          case 400...499:
               println()
          case 500...599:
              println()
          default:
              println()
          }
        }
      }).resume()
    }
}
}

//  class func checkStatusCodes(statusCode: Int) {
//    switch statusCode {
//    case 200...299:
//      completionHandler(nil,data)
//    case 400...499:
//      completionHandler("this is our fault", nil)
//    case 500...599:
//      completionHandler("this is the servers fault", nil)
//    default:
//      completionHandler("error occurred", nil)
//  }

