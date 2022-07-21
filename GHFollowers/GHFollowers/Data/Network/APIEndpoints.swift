//
//  APIEndpoints.swift
//  GHFollowers
//
//  Created by 김호준 on 2022/03/11.
//

import Foundation

struct APIEndpoints {
  static func getFollowers(
    with username: String
  ) -> Endpoint<FollowersResponseDTO> {
    let path = "https://api.github.com/users/\(username)/followers"
    return Endpoint(
      path: path,
      method: .get
    )
  }
}
