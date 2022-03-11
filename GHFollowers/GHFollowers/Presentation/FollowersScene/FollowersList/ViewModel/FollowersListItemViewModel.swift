//
//  FollowersListItemViewModel.swift
//  GHFollowers
//
//  Created by 김호준 on 2022/03/11.
//

import Foundation

struct FollowersListItemViewModel {
  let login: String
}

extension FollowersListItemViewModel {
  init(follower: Follower) {
    self.login = follower.login
  }
}
