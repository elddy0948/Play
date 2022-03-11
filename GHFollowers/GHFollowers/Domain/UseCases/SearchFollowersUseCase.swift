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

final class DefaultSearchFollowersUseCase: SearchFollowersUseCase {
  //MARK: - Properties
  private let followersRepository: FollowersRepository
  private let followersQueriesRepository: FollowersQueriesRepository
  
  //MARK: - Initializer
  init(followersRepository: FollowersRepository,
       followersQueriesRepository: FollowersQueriesRepository) {
    self.followersRepository = followersRepository
    self.followersQueriesRepository = followersQueriesRepository
  }
  
  func execute(
    requestValue: SearchFollowersUseCaseRequestValue,
    cached: @escaping (FollowersPage) -> Void,
    completion: @escaping (Result<FollowersPage, Error>) -> Void
  ) -> Cancelable? {
    return followersRepository.fetchFollowerList(
      query: requestValue.query,
      page: requestValue.page,
      cached: cached,
      completion: { result in
        if case .success = result {
          self.followersQueriesRepository.saveRecentQuery(requestValue.query,
                                                          completion: { _ in })
        }
        completion(result)
      }
    )
  }
}

struct SearchFollowersUseCaseRequestValue {
  let query: FollowerQuery
  let page: Int
}
