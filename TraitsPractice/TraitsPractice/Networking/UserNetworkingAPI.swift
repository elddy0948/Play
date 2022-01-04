//
//  UserNetworkingAPI.swift
//  TraitsPractice
//
//  Created by 김호준 on 2021/12/31.
//

import Foundation
import RxSwift

enum UserNetworkingAPIError: Error {
  case invalidURL
  case unknown
  
  var message: String {
    switch self {
    case .invalidURL:
      return "올바르지 않은 URL입니다."
    case .unknown:
      return "다시 시도해주세요!"
    }
  }
}

final class UserNetworkingAPI {
  static let shared: UserNetworkingAPI = UserNetworkingAPI()
  
  private let baseURL = "https://api.github.com/users/"
  
  private init() { }
  
  func fetchUserInfo(with username: String) -> Single<User> {
    guard let request = createURLRequest(with: username) else {
      return Single.error(UserNetworkingAPIError.invalidURL)
    }
    
    return URLSession.shared
      .rx
      .toDecodable(
        request: request,
        type: User.self
      )
  }
  
  func likeUser(with username: String) -> Completable {
    return Completable.create(subscribe: { completable in
      // Do networking ...
      // ...
      // ...
      
      let success = true
      
      if success {
        completable(.completed)
      } else {
        completable(.error(UserNetworkingAPIError.unknown))
      }
      
      return Disposables.create { }
    })
  }
  
  private func createURLRequest(with username: String) -> URLRequest? {
    guard let url = URL(string: baseURL + username) else {
      return nil
    }

    let request = URLRequest(url: url)
    return request
  }
}
