//
//  Errors.swift
//  RxNews
//
//  Created by 김호준 on 2021/11/26.
//

import Foundation

enum RxURLSessionError: Error {
  case unknown
  case invalidResponse
  case requestFailed
  
  
  var message: String {
    switch self {
    case .unknown:
      return "알 수 없는 에러가 발생했습니다."
    case .invalidResponse:
      return "잘못된 응답입니다."
    case .requestFailed:
      return "요청에 실패했습니다."
    }
  }
}
