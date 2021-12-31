//
//  RxURLSessionError.swift
//  TraitsPractice
//
//  Created by 김호준 on 2021/12/31.
//

import Foundation

enum RxURLSessionError: Error {
  case unknown
  case invalidResponse
  
  var message: String {
    switch self {
    case .unknown:
      return "알 수 없는 에러입니다."
    case .invalidResponse:
      return "잘못된 응답입니다."
    }
  }
}
