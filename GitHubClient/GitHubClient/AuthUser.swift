//
//  AuthUser.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/22/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

struct AuthUser {
  let name: String
  let bio: String
  let hireable: Bool
  let avatar_url: String
  var avatar_image: UIImage?
  let public_repos: Int
  let private_repos: Int
}
