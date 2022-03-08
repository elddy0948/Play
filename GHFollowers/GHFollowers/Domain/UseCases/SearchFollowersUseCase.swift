//
//  SearchFollowersUseCase.swift
//  GHFollowers
//
//  Created by 김호준 on 2022/03/08.
//

import Foundation

protocol SearchFollowersUseCase {
  func execute(
    requestValue: SearchFollowersUseCaseRequestValue,
    cached: @escaping (FollowersPage) -> Void,
    completion: @escaping (Result<FollowersPage, Error>) -> Void
  ) -> Cancelable?
}

struct SearchFollowersUseCaseRequestValue {
  let query: FollowerQuery
  let page: Int
}
