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
  
  var message: String {
    switch self {
    case .invalidURL:
      return "올바르지 않은 URL입니다."
    }
  }
}

final class UserNetworkingAPI {
  private let baseURL = "https://api.github.com/users/"
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
  
  private func createURLRequest(with username: String) -> URLRequest? {
    guard let url = URL(string: baseURL + username) else {
      return nil
    }

    let request = URLRequest(url: url)
    return request
  }
}
